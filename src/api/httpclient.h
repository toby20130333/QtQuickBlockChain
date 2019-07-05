#ifndef HTTPCLIENT_H
#define HTTPCLIENT_H

#include <QObject>
#include "tfhttp.hpp"

class HttpClient : public QObject
{
    Q_OBJECT
public:
    explicit HttpClient(QObject *parent = nullptr);

    Q_INVOKABLE void requestAllgdnpsData(int pageIndex,int pageSize);
signals:

    void signalDataResult(const QString &json);
public slots:
    QString removeHeaders(const QString &json);
};

#endif // HTTPCLIENT_H
