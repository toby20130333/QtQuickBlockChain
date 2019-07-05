#include "ddquickview.h"
#include <QQmlEngine>
#include <QDesktopServices>

DDQuickView::DDQuickView(QQuickView *parent) :
    QQuickView(parent),
    mRootObj(nullptr)
  , mIsMax(false)
{
    setFlags(Qt::FramelessWindowHint|Qt::WindowStaysOnTopHint);
    setColor(Qt::transparent);
    setResizeMode(QQuickView::SizeRootObjectToView);
    setMinimumWidth(816);
    setMinimumHeight(500);

    mHelper = new DDFramelessHelper(this);
    mHelper->activateOnQmlWidget(this);
    mHelper->setTitleHeight(80);
    mHelper->setWidgetMovable(true);
    mHelper->setWidgetResizable(true);
    registerCppModel();
    registerCppToQmlConnects();
}
void DDQuickView::setWindowResizable(bool resizable)
{
    if(mHelper)mHelper->setWidgetResizable(resizable);
}
DDQuickView::~DDQuickView()
{
}
///
/// \brief DDQuickView::showTrayIcon
/// 显示系统托盘 可扩展
///
void DDQuickView::showTrayIcon(){
    if (mRootObj != NULL)
    {
        QAction *minimizeAction = new QAction(QObject::tr("Mi&nimize"), this);
        mRootObj->connect(minimizeAction, SIGNAL(triggered()), this, SLOT(hide()));
        QAction *maximizeAction = new QAction(QObject::tr("Ma&ximize"), this);
        mRootObj->connect(maximizeAction, SIGNAL(triggered()), this, SLOT(slotShowMaximized()));
        QAction *restoreAction = new QAction(QObject::tr("&Restore"), this);
        mRootObj->connect(restoreAction, SIGNAL(triggered()), this, SLOT(showNormal()));
        QAction *quitAction = new QAction(QObject::tr("&Quit"), this);
        mRootObj->connect(quitAction, SIGNAL(triggered()), qApp, SLOT(quit()));

        QMenu *trayIconMenu = new QMenu();
        trayIconMenu->addAction(minimizeAction);
        trayIconMenu->addAction(maximizeAction);
        trayIconMenu->addAction(restoreAction);
        trayIconMenu->addSeparator();
        trayIconMenu->addAction(quitAction);

        mTrayIcon = new QSystemTrayIcon(this);
        mTrayIcon->setContextMenu(trayIconMenu);
        mTrayIcon->setIcon(QIcon(":/favicon.ico"));
        mTrayIcon->show();
    }

}

void DDQuickView::slotShowMaximized()
{
    mIsMax = true;
    showMaxAndNormalWindow(mIsMax);
    update();
    this->showMaximized();
}
void DDQuickView::setSourceAndRegsiterObj(const QUrl &url, bool regsiter)
{
    if(regsiter){
        //setSource后才能得到obj对象
        setSource(url);
        mRootObj = this->rootObject();
        registerCppToQmlConnects();
    }
}
void DDQuickView::transQmlToOther(QVariant, QVariant)
{

}

QObject *DDQuickView::getQmlObj()
{
    return mRootObj;
}

QObject *DDQuickView::getSystemTrayIcon()
{
    return mTrayIcon;
}
void DDQuickView::mouseDoubleClickEvent(QMouseEvent *event)
{
    if(!mHelper){
        QQuickView::mouseDoubleClickEvent(event);
        return;
    }
    QRect rect(10,2,this->width()-70,mHelper->titleHeight());
    if(event->button() == Qt::LeftButton && rect.contains(event->pos())) {
        if(!mIsMax){
            mIsMax = !mIsMax;
            showMaximized();
        }else{
            mIsMax = !mIsMax;
            showNormal();
        }
        showMaxAndNormalWindow(mIsMax);
        update();
    }
    QQuickView::mouseDoubleClickEvent(event);
}
bool DDQuickView::event(QEvent *e)
{
    switch (e->type()) {
    case QEvent::Close:{
        qApp->quit();
    }break;
    }
    return QQuickView::event(e);
}

QVariant DDQuickView::notifyToUi(const QVariant &var)
{
    QVariant returnVal;
    if(mRootObj){
        QMetaObject::invokeMethod(mRootObj,"notifyToUi",Q_RETURN_ARG(QVariant,returnVal),
                                  Q_ARG(QVariant,var));
    }
    return returnVal;
}
///
/// \brief DDQuickView::showMaxAndNormalWindow
/// \param showMax
///  你可以注册该方法到QML当中
///
void DDQuickView::showMaxAndNormalWindow(bool showMax)
{
    if(mRootObj){
        QVariant returnVal;
        QMetaObject::invokeMethod(mRootObj,"transToQml",Q_RETURN_ARG(QVariant,returnVal),
                                  Q_ARG(QVariant,showMax));
    }
}
///
/// \brief DDQuickView::slotRecevQmlReq
/// \param var
/// \param cmd
/// 接受来自QML的请求
void DDQuickView::slotRecevQmlReq(QVariant var, QVariant cmd)
{
    qDebug()<<Q_FUNC_INFO<<var<<cmd;
    if(var.toString()=="system"){
        if(cmd == "close"){
            this->close();
            qApp->quit();
        }else if(cmd == "min"){
            this->showMinimized();
        }
    }else if(var.toString() == "topheight"){
        mHelper->setTitleHeight(cmd.toInt());
    }
}

void DDQuickView::slotRecevQmlMoveH(QVariant var)
{
    if(mHelper){
        mHelper->setTitleHeight(var.toInt());
    }
}
