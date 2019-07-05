#ifndef DDNHTTPAPI_H
#define DDNHTTPAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSslConfiguration>
#include <QDebug>

///
/// \brief The DDNHttpApi class
///  DDN 浏览器接口
///
///
typedef struct tagDDN_REQ_TYPE
{
    tagDDN_REQ_TYPE() {}
    int offset{0};
    int limit{10};
    QString orderBy{""};

}DDN_REQ_TYPE;
class DDNHttpApi : public QObject
{
    Q_OBJECT
public:
    explicit DDNHttpApi(QObject *parent = nullptr);

    ///
    /// \brief The DDNHttpApi class
    ///  DDN 浏览器枚举
    ///
    ///
    enum DDN_REQU_ENUM{
        BLOCKS,
        FULL_HEIGHT,
        TRANSACATIONS,
        TRANSACATIONS_DETAILS,
        ACCOUNT,
        ACCOUN_DETAILS,
        PEERS,
        DELEGATES
    };
    Q_ENUM(DDN_REQU_ENUM)
    ///
    /// \brief requestDDNBlocksData
    /// \param offset
    /// \param limit
    /// \param orderBY
    ///  区块链查询接口
    ///
    Q_INVOKABLE void requestDDNBlocksData(int offset=0,int limit=10,const QString& orderBY="height:desc",bool first=true);
    ///
    /// \brief requestDDNBlockDetails
    /// \param height
    ///  区块的详细信息
    ///
    Q_INVOKABLE void requestDDNBlockDetails(int height=0);
    ///
    /// \brief requestDDNTransactions
    /// \param offset
    /// \param limit
    /// \param orderBy
    /// 查询交易记录
    ///
    Q_INVOKABLE void requestDDNTransactions(int offset=0,int limit=10,const QString &orderBy="t_timestamp:desc",bool first=false);

    ///
    /// \brief requestDDNTransDetails
    /// \param transId 交易ID
    ///  每个交易的详细信息
    ///
    Q_INVOKABLE void requestDDNTransDetails(const QString &transId);
    ///
    /// \brief requestDDNPeers
    /// \param offset
    /// \param limit
    ///  查询节点数量和信息
    ///
    Q_INVOKABLE void requestDDNPeers(int offset=0,int limit=10);
    ///
    /// \brief requestDDNAccounts
    /// \param offset
    /// \param limit
    /// 查询账户列表信息
    Q_INVOKABLE void requestDDNAccounts(int offset=0,int limit=10);
    ///
    /// \brief requestDDNAccountsDetails
    /// \param address
    /// 查询某个账户的信息
    ///
   Q_INVOKABLE  void requestDDNAccountsDetails(const QString &address);
    ///
    /// \brief requestDDNDelegates
    /// \param offset
    /// \param limit
    ///  查询委托人列表的详细信息
    ///
    Q_INVOKABLE void requestDDNDelegates(int offset=0,int limit=10);
signals:
    void signalData(DDN_REQU_ENUM type,const QString &json);
    void signalRequest();
public slots:
    void finished(QNetworkReply *reply);
private:
    ///
    /// \brief requestDDNData
    /// \param ddnType
    /// \param reqUrl
    /// 请求DDN区块数据
    ///
    void requestDDNData(DDN_REQU_ENUM ddnType,const QUrl& reqUrl,bool first=true);
private:
    QMap<DDN_REQU_ENUM,QByteArray> mDDNDataMap;
    QNetworkAccessManager *mManager{nullptr};
    QUrl mHostPortUrl{"http://47.94.93.132:8000"};
};

#endif // DDNHTTPAPI_H
