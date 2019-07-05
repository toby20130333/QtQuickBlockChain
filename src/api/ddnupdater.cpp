#include "ddnupdater.h"
#include <QCoreApplication>
#include <QFile>
#include <QDir>
#include <QProcess>

#define DOWN_URL "http://qtddui.b0.upaiyun.com/gitdir/DDN-Client-0.0.0.1.zip"
#define VERSION "0.0.0.1"
#define INI_URL "http://qtddui.b0.upaiyun.com/gitdir/updater.ini"

DDNUpdater::DDNUpdater(QObject *parent) : QObject(parent)
{
    init();
    connect(&mDownMa,&DownloadManager::finished,this,[&](const QString &gifDir){
        if(QFile::exists(gifDir)){
            if(hasUpdater()){
                emit signalHasUpdater();
            }
        }
    });
}

void DDNUpdater::checkIni()
{
    if(mIniUrl.isEmpty())return;
    mDownMa.append(QStringList()<< mIniUrl.toString());
}
bool DDNUpdater::hasUpdater()
{
    QString path = QString("%1/updater/%2.ini").arg(QCoreApplication::applicationDirPath()).arg("updater");
    if(!QFile::exists(path))return false;
    QSettings settings(path, QSettings::IniFormat);
    settings.beginGroup("updater");
    qDebug()<<settings.childKeys();
    QString Version = settings.value("version",VERSION).toString();
    mDownloadUrl = settings.value("downloadurl",DOWN_URL).toString();
    settings.endGroup();
    qDebug()<<Version<<" old "<<mVersion;
    if(Version != mVersion){
        mVersion = Version;
        return true;
    }
    return false;
}

QString DDNUpdater::getLastVersion()
{
    return mVersion;
}

QUrl DDNUpdater::getNewDownloadUrl()
{
    return mDownloadUrl;
}

bool DDNUpdater::restartApp(bool restart)
{
    if(!restart)return true;
    QString startPath = QDir::toNativeSeparators(qApp->applicationFilePath());
    bool sucess = QProcess::startDetached(startPath,qApp->arguments());
    return sucess;
}

void DDNUpdater::movIniFile()
{
    QString path = QString("%1/%2.ini").arg(QCoreApplication::applicationDirPath()).arg("updater");
    QString path2 = QString("%1/updater/%2.ini").arg(QCoreApplication::applicationDirPath()).arg("updater");
    if(QFile::exists(path)){
        QFile::remove(path);
    }
    qDebug()<<" copy"<<QFile::copy(path2,path)<<path<<" "<<path2;
}

void DDNUpdater::init()
{
    QString path = QString("%1/%2.ini").arg(QCoreApplication::applicationDirPath()).arg("updater");
    if(!QFile::exists(path))return;
    QSettings settings(path, QSettings::IniFormat);
    settings.beginGroup("updater");
    qDebug()<<settings.childKeys();
    mVersion = settings.value("version",VERSION).toString();
    mDownloadUrl = settings.value("downloadurl",DOWN_URL).toString();
    mIniUrl = settings.value("url",INI_URL).toString();
    settings.endGroup();
}
