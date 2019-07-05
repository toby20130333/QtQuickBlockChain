#include "httpclient.h"
#include <QDebug>

/*
 * http://xxgk.miit.gov.cn/gdnps/searchIndex.jsp?
 * params={"goPage":1,"orderBy":[{"orderBy":"publishTime","reverse":true},{"orderBy":"orderTime","reverse":true}],"pageSize":10,"queryParam":[{},{"shortName":"fbjg","value":"/1/29/1146295/1652858/1652930"}]}
 * &callback=jQuery1111009625668923489172_1533879204852
 * &_=1533879204857
*/

#define URL_REQ "http://xxgk.miit.gov.cn/gdnps/searchIndex.jsp?params=%1&callback=jQuery1111009625668923489172_1533879204852&_=%2"
#define URL_REQ_PARAM "\{\"goPage\":%1,\"orderBy\":[\{\"orderBy\":\"publishTime\",\"reverse\":true\},\{\"orderBy\":\"orderTime\",\"reverse\":true\}]\
,\"pageSize\":%2,\"queryParam\":[\{\},\{\"shortName\":\"fbjg\",\"value\":\"/1/29/1146295/1652858/1652930\"\}]\}"

HttpClient::HttpClient(QObject *parent) : QObject(parent)
{
  qDebug()<<Q_FUNC_INFO<<URL_REQ_PARAM;
  QByteArray ba("Montreal);");
  ba.remove(ba.size()-2, 2);
  qDebug()<<Q_FUNC_INFO<<ba;
}

void HttpClient::requestAllgdnpsData(int pageIndex, int pageSize)
{
    QString url = QString(URL_REQ);
    QString params(URL_REQ_PARAM);
    params = params.arg(pageIndex).arg(pageSize);
    params = params.toUtf8().toPercentEncoding("","",'%').toPercentEncoding();
    url = url.arg(params).arg(QDateTime::currentMSecsSinceEpoch());
    qDebug()<<Q_FUNC_INFO<<url<<"\n"<<QUrl(url).isValid();
    TFHttp::get(QUrl(url),[=](TFHttp::HttpResult res){
        qDebug()<<" res "<<res.isSuccess;
         if(res.isSuccess){
            qDebug()<<"data\n"<<res.data.size();
            emit signalDataResult(removeHeaders(res.data));
         }
    });
}
#include <QFile>
///
/// \brief HttpClient::removeHeaders
/// \param json
/// jQuery1111009625668923489172_1533879204852(
///
QString HttpClient::removeHeaders(const QString &json)
{
    QString temp  = json;
    temp = temp.remove("jQuery1111009625668923489172_1533879204852(");
    temp = temp.remove(");",Qt::CaseSensitive);
//    qDebug()<<Q_FUNC_INFO<<temp.size();
//    QFile file("xcx.json");
//    if(file.open(QIODevice::WriteOnly)){
//        file.write(temp.toUtf8());
//    }
//    file.close();
    return temp;
}
