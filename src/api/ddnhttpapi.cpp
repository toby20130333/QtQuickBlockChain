#include "ddnhttpapi.h"

DDNHttpApi::DDNHttpApi(QObject *parent) : QObject(parent)
{
    mManager = new QNetworkAccessManager(this);
    connect(mManager,&QNetworkAccessManager::finished,this,&DDNHttpApi::finished);
}
///
/// \brief DDNHttpApi::requestDDNBlocksData
/// \param offset
/// \param limit
/// \param orderBY
///* Request URL: http://47.94.93.132:8000/api/blocks?offset=0&limit=10&orderBy=height%3Adesc


void DDNHttpApi::requestDDNBlocksData(int offset, int limit, const QString &orderBY,bool first)
{
    QString url = QString("%1/api/blocks?offset=%2&limit=%3&orderBy=%4")
            .arg(mHostPortUrl.toString()).arg(offset).arg(limit).arg(orderBY);
    requestDDNData(BLOCKS,QUrl(url),first);
}
///
/// \brief DDNHttpApi::requestDDNBlockDetails
/// \param height
///http://47.94.93.132:8000/api/blocks/full?height=1234817
void DDNHttpApi::requestDDNBlockDetails(int height)
{
    QString url = QString("%1/api/blocks/full?height=%2")
            .arg(mHostPortUrl.toString()).arg(height);
    requestDDNData(FULL_HEIGHT,QUrl(url),false);
}
///
/// \brief DDNHttpApi::requestDDNTransactions
/// \param offset
/// \param limit
/// \param orderBy
/// \param first
///http://47.94.93.132:8000/api/transactions?offset=0&limit=10&orderBy=t_timestamp%3Adesc
void DDNHttpApi::requestDDNTransactions(int offset, int limit, const QString &orderBy, bool first)
{
    QString url = QString("%1/api/transactions?offset=%2&limit=%3&orderBy=%4")
            .arg(mHostPortUrl.toString()).arg(offset).arg(limit).arg(orderBy);
    requestDDNData(TRANSACATIONS,QUrl(url),first);
}
///
/// \brief DDNHttpApi::requestDDNTransDetails
/// \param transId
///http://47.94.93.132:8000/api/transactions/get?id=5712ac5d479ce1d75996a0545305f
///
void DDNHttpApi::requestDDNTransDetails(const QString &transId)
{
    QString url = QString("%1/api/transactions/get?id=%2")
            .arg(mHostPortUrl.toString()).arg(transId);
    requestDDNData(TRANSACATIONS_DETAILS,QUrl(url),false);
}
///
/// \brief DDNHttpApi::requestDDNPeers
/// \param offset
/// \param limit
///http://47.94.93.132:8000/api/peers?offset=0&limit=10
void DDNHttpApi::requestDDNPeers(int offset, int limit)
{
    QString url = QString("%1/api/peers?offset=%2&limit=%3")
            .arg(mHostPortUrl.toString()).arg(offset).arg(limit);
    requestDDNData(PEERS,QUrl(url),false);
}
///
/// \brief DDNHttpApi::requestDDNAccounts
/// \param offset
/// \param limit
///http://47.94.93.132:8000/api/accounts/top?offset=0&limit=10
void DDNHttpApi::requestDDNAccounts(int offset, int limit)
{
    QString url = QString("%1/api/accounts/top?offset=%2&limit=%3")
            .arg(mHostPortUrl.toString()).arg(offset).arg(limit);
    requestDDNData(ACCOUNT,QUrl(url),false);
}
///
/// \brief DDNHttpApi::requestDDNAccountsDetails
/// \param address
///* Request URL: http://47.94.93.132:8000/api/accounts?address=D8h4AxFtN8zjHLSH8t9aaWMJZKv9XqLjZ6

void DDNHttpApi::requestDDNAccountsDetails(const QString &address)
{
    QString url = QString("%1/api/accounts?address=%2")
            .arg(mHostPortUrl.toString()).arg(address);
    requestDDNData(ACCOUN_DETAILS,QUrl(url),false);
}
///
/// \brief DDNHttpApi::requestDDNDelegates
/// \param offset
/// \param limit
/// http://47.94.93.132:8000/api/delegates?offset=0&limit=10
///
void DDNHttpApi::requestDDNDelegates(int offset, int limit)
{
    QString url = QString("%1/api/delegates?offset=%2&limit=%3")
            .arg(mHostPortUrl.toString()).arg(offset).arg(limit);
    requestDDNData(DELEGATES,QUrl(url),false);
}

void DDNHttpApi::finished(QNetworkReply *reply)
{
    qDebug()<<Q_FUNC_INFO<<reply->property("tag");
    QByteArray arr = reply->readAll();
    //qDebug()<<Q_FUNC_INFO<<arr;
    DDN_REQU_ENUM type = reply->property("tag").value<DDN_REQU_ENUM>();
    emit signalData(type,arr);
}

void DDNHttpApi::requestDDNData(DDNHttpApi::DDN_REQU_ENUM ddnType, const QUrl &reqUrl,bool first)
{
    emit signalRequest();
    qDebug()<<Q_FUNC_INFO<<ddnType<<" reqUrl "<<reqUrl;
    QNetworkRequest request;
    QSslConfiguration  mSslConfig = QSslConfiguration::defaultConfiguration();
    mSslConfig.setPeerVerifyMode(QSslSocket::VerifyNone);
    mSslConfig.setProtocol(QSsl::TlsV1_2);
    request.setSslConfiguration(mSslConfig);
    QUrl url(reqUrl);
    QByteArray encode = url.toEncoded();
    request.setUrl(QUrl(encode));
    request.setHeader(QNetworkRequest::UserAgentHeader,"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36");
    QNetworkReply *reply=nullptr;
    if(first){
        reply = mManager->sendCustomRequest(request,"OPTIONS","");
    }else{
        reply = mManager->get(request);
    }
    reply->setProperty("tag",ddnType);
}
