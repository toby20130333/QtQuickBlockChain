#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QMessageBox>
#include <QFont>
#include <QDebug>

#include "core/common/ddnstylemanager.h"
#include "core/common/ddtextimpwidth.h"
#include "src/widnow/dduiquickview.h"
#include <src/api/httpclient.h>

static QObject * qapp_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    DDTextImpWidth *example = new DDTextImpWidth();
    return example;
}
static QObject * qapp_singletontype_style(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    DDNStyleManager *example = new DDNStyleManager();
    //example->getAllTagsSkins();
    //
    return example;
}
bool checkExpired(){
    QString curData = QDateTime::currentDateTime().toString("yyyyMMdd");
    if(curData.toInt() >= 20180912){
        QMessageBox::warning(NULL, QObject::tr("DDN Application"),
                             QObject::tr("The App has a Expired license.\n"
                                         "Do you want to Fees for renewal?"),
                             QMessageBox::Ok | QMessageBox::Discard
                             | QMessageBox::Cancel,
                             QMessageBox::Ok);
        return false;
    }
    return true;
}
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
//    if(!checkExpired()){
//        return 0;
//    }
    app.setFont(QFont(QStringLiteral("微软雅黑")));
    qmlRegisterSingletonType<DDTextImpWidth>("DDui.ddn", 1, 0, "DDTextImpWidth", qapp_singletontype_provider);
    qmlRegisterSingletonType<DDNStyleManager>("DDui.style", 1, 0, "DDNSkin", qapp_singletontype_style);
    qmlRegisterType<HttpClient>("HttpClient",1,0,"HttpClient");
    DDuiQuickView window;
    window.setFlags(Qt::FramelessWindowHint|Qt::Window);
#ifndef QT_DEBUG
    window.setSourceAndRegsiterObj(QUrl("qrc:/qml/apps/poetry/DDPoeLogin.qml"));
#else
#ifdef Q_OS_MACOS
    window.setSourceAndRegsiterObj(QUrl::fromLocalFile("../../../main.qml"));
#else
    window.setSourceAndRegsiterObj(QUrl::fromLocalFile("./../../DDNBlockViewer/qml/apps/poetry/DDPoeLogin.qml"));
#endif
#endif
    window.setWindowResizable(true);
    window.show();
    window.showTrayIcon();
    window.notifyToUi();
    window.slotCheckUpdater();
#if 0
    DDNHttpApi ddnObject;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("ddnObject", &ddnObject);
    DDNTableModel mTableModel;//区块model
    DDNTransDetailsModel mTransModel;//交易model
    DDNPeerDetailsModel mPeersModel;//节点model
    DDNAccountsModel mAccountsModel;
    engine.rootContext()->setContextProperty("mTableModel", &mTableModel);
    engine.rootContext()->setContextProperty("mTransModel", &mTransModel);
    engine.rootContext()->setContextProperty("mPeersModel", &mPeersModel);
    engine.rootContext()->setContextProperty("mAccountsModel", &mAccountsModel);
#ifdef QT_NO_DEBUG
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#else
    engine.load(QUrl::fromLocalFile(QStringLiteral("main.qml")));
#endif
    if (engine.rootObjects().isEmpty())
        return -1;
#endif
    return app.exec();
}
