#include "ddnstylemanager.h"
#include <QCoreApplication>
#include <QSettings>
#include <QDebug>
#include <QFile>
#include <QDir>
#include <QUrl>
#include <QDirIterator>

DDNStyleManager::DDNStyleManager(QObject *parent) : QObject(parent)
{
    mStyleMap.clear();
    initAllSkins();
    restore();
    changeSkin(curSkin,true);
}

DDNStyleManager::~DDNStyleManager()
{
    save();
}
void DDNStyleManager::changeSkin(const QString &skinfile,bool first)
{
    if(curSkin == skinfile && !first){
        return;
    }
    curSkin = skinfile;
    QString skin = mUiSkinMap.value(skinfile);
    qDebug()<<" skin "<<skin;
    QString path = QString("%1/skin/%2.ini").arg(QCoreApplication::applicationDirPath()).arg(skin);
    if(!QFile::exists(path))return;
    QSettings settings(path, QSettings::IniFormat);
    mStyleMap.clear();
    settings.beginGroup("theme");
    qDebug()<<settings.childKeys();
    foreach (QString key, settings.childKeys()) {
        mStyleMap.insert(key,settings.value(key,"#000000").toString());
    }
    settings.endGroup();
    emit signalSkinChanged(curSkin,first);
}

QStringList DDNStyleManager::getAllTagsSkins()
{
     if(mUiSkinMap.isEmpty())return QStringList();
     return mUiSkinMap.keys();
}
QStringList DDNStyleManager::getAllSkins()
{
    QString skinDir = QString("%1/skin/").arg(QCoreApplication::applicationDirPath());
    QDir dir(skinDir);
    if(!dir.exists())return QStringList();
    //获取所选文件类型过滤器
    QStringList filters;
    filters<<QString("*.ini");
    //定义迭代器并设置过滤器
    QDirIterator dir_iterator(skinDir,
                              filters,
                              QDir::Files | QDir::NoSymLinks,
                              QDirIterator::Subdirectories);
    QStringList string_list;
    while(dir_iterator.hasNext())
    {
        dir_iterator.next();
        QFileInfo file_info = dir_iterator.fileInfo();
        string_list.append(file_info.baseName());
    }
    qDebug()<<string_list;
    return string_list;
}

void DDNStyleManager::save()
{
    QSettings settings("DDN-Client", "skin");
    settings.beginGroup(QLatin1String("Settings"));
    settings.setValue("skin",curSkin);
    settings.endGroup();
}

void DDNStyleManager::restore()
{
    QSettings settings("DDN-Client", "skin");
    settings.beginGroup(QLatin1String("Settings"));
    curSkin = settings.value("skin",QStringLiteral("午夜紫兰")).toString();
    qDebug()<<Q_FUNC_INFO<<curSkin;
    settings.endGroup();
}

QColor DDNStyleManager::getColorByKey(const QString &key)
{
    if(mStyleMap.keys().contains(key)){
        QColor color = mStyleMap.value(key);
        //qDebug()<<Q_FUNC_INFO<<key<<" color "<<color.name();
        return color;
    }
    return QColor(Qt::white);
}

QString DDNStyleManager::getCurSkin()
{
    return curSkin;
}

void DDNStyleManager::initAllSkins()
{
    QStringList lst = getAllSkins();
    if(lst.isEmpty())return;
    mUiSkinMap.clear();
    foreach (QString skin, lst) {
        QString path = QString("%1/skin/%2.ini").arg(QCoreApplication::applicationDirPath()).arg(skin);
        if(!QFile::exists(path))continue;
        QSettings settings(path, QSettings::IniFormat);
        settings.beginGroup("tag");
        mUiSkinMap.insert(settings.value("tag","").toString(),skin);
        settings.endGroup();
    }
    emit signalSkinFilesChanged();
}
