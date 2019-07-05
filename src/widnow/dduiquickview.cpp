#include "dduiquickview.h"
#include <QQmlEngine>
#include <QDesktopServices>

DDuiQuickView::DDuiQuickView(QQuickView *parent) :
    DDQuickView(parent)
{
    registerCppModel();
}
void DDuiQuickView::slotCheckUpdater()
{
    connect(&updater,&DDNUpdater::signalHasUpdater,this,[&](){
        QString msg  = updater.getLastVersion();
        notifyToUi(msg);
        slotShowMsg(QString("Get The newest Version: v%1").arg(msg),"Updater");
     });
    updater.checkIni();
}

void DDuiQuickView::slotSaveIniUpdaterFile()
{
    updater.movIniFile();
    QDesktopServices::openUrl(QUrl(updater.getNewDownloadUrl()));
}

QVariant DDuiQuickView::notifyToUi(const QVariant &var)
{
    QVariant returnVal,tmpVar;
    if(!var.isValid()){
        tmpVar = updater.getLastVersion();
    }
    QObject *qmlObj = getQmlObj();
    if(!qmlObj)return QVariant();
    if(qmlObj){
        QMetaObject::invokeMethod(qmlObj,"notifyToUi",Q_RETURN_ARG(QVariant,returnVal),
                                  Q_ARG(QVariant,tmpVar));
    }
    return returnVal;
}

void DDuiQuickView::slotShowMsg(const QString &msg, const QString &title)
{
    QObject *trayObj = getSystemTrayIcon();//
    QSystemTrayIcon *obj = qobject_cast<QSystemTrayIcon*>(trayObj);
    if(obj)obj->showMessage(title,msg,QSystemTrayIcon::Information,1000);
}
void DDuiQuickView::registerCppModel()
{
    //model需要在setsource之前设置
    this->rootContext()->setContextProperty("ddnObject", &ddnObject);
    this->rootContext()->setContextProperty("mTableModel", &mTableModel);
    this->rootContext()->setContextProperty("mTransModel", &mTransModel);
    this->rootContext()->setContextProperty("mPeersModel", &mPeersModel);
    this->rootContext()->setContextProperty("mAccountsModel", &mAccountsModel);
    this->rootContext()->setContextProperty("mDelegateModel",&mDelegateModel);
    this->rootContext()->setContextProperty("mMsgModel",&mMsgModel);
}

void DDuiQuickView::registerCppToQmlConnects()
{
    //setSource后才能得到obj对象
    QObject *qmlObj = getQmlObj();
    if(!qmlObj)return;
    connect(qmlObj,SIGNAL(signalQmlOptions(QVariant,QVariant)),this,SLOT(slotRecevQmlReq(QVariant,QVariant)));
    connect(qmlObj,SIGNAL(signalQmlTocppMoveheigth(QVariant)),this,SLOT(slotRecevQmlMoveH(QVariant)));
    connect(qmlObj,SIGNAL(signalTransQmlToOther(QVariant,QVariant)),this,SLOT(slotTransQmlToOther(QVariant,QVariant)));
}
#include <QDesktopWidget>
#include <QApplication>

void DDuiQuickView::moveCenter()
{
    QDesktopWidget* desktop = QApplication::desktop(); // =qApp->desktop();也可以
    setPosition((desktop->width() - this->width())/2, (desktop->height() - this->height())/2);
}
void DDuiQuickView::slotTransQmlToOther(QVariant var, QVariant data)
{
    if(var.toString() == "opendownloadurl"){
        slotSaveIniUpdaterFile();
    }else if(var.toString() == "resize"){
        QList<QVariant> lst = data.toList();
        if(lst.size() != 2)return;
        this->resize(lst.first().toInt(),lst.last().toInt());
        moveCenter();
    }else if(var.toString() == "msg"){
        QList<QVariant> lst = data.toList();
        if(lst.size() != 2)return;
        slotShowMsg(lst.first().toString(),lst.last().toString());
    }
}
