#ifndef DDTEXTIMPWIDTH_H
#define DDTEXTIMPWIDTH_H

#include <QObject>
#include <QVariant>
#include <QDateTime>

class DDTextImpWidth : public QObject
{
    Q_OBJECT
public:
    explicit DDTextImpWidth(QObject *parent = nullptr);
    Q_INVOKABLE qreal getWidth(const QString &text,int pointSize=12);
    Q_INVOKABLE QString imageAbsPath(const QString &resPath);
    Q_INVOKABLE QString getDateForString(QVariant ti);
signals:
    void signalCommonToBlocksPage(QString from,QString to,int type,QVariant value);
public slots:
private:
    QDateTime ddnTi;
};

#endif // DDTEXTIMPWIDTH_H
