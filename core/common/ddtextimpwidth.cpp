#include "ddtextimpwidth.h"
#include <QFont>
#include <QFontMetricsF>
#include <QGuiApplication>
#include <QDebug>

DDTextImpWidth::DDTextImpWidth(QObject *parent) : QObject(parent)
{
    ddnTi  = QDateTime(QDate(2017, 12, 20),QTime(12,0,0));
}

qreal DDTextImpWidth::getWidth(const QString &text, int pointSize)
{
    QFontMetricsF fm(qApp->font());
    QFont f(qApp->font());
    f.setPixelSize(pointSize);
    qreal pixelsWide = fm.width(text);
    qDebug()<<Q_FUNC_INFO<<pixelsWide<<" text "<<text;
    return pixelsWide;
}

QString DDTextImpWidth::imageAbsPath(const QString &resPath)
{
    QString path;
#ifdef Q_OS_WIN
#ifdef QT_NO_DEBUG
     path = QString("file:///%1/img/%2").arg(qApp->applicationDirPath()).arg(resPath);
#else
     path = QString("file:///%1/../img/%2").arg(qApp->applicationDirPath()).arg(resPath);
#endif
#else
     path = QString("file:///%1/img/%2").arg(qApp->applicationDirPath()).arg(resPath);
#endif
//    qDebug()<<Q_FUNC_INFO<<path;
     return path;
}

QString DDTextImpWidth::getDateForString(QVariant ti2)
{
    qint64 ti = ti2.toDouble();
    ti = ti+ddnTi.toSecsSinceEpoch();
    return QString("%1").arg(QDateTime::fromMSecsSinceEpoch(ti*1000).toString());
}
