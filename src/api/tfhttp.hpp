#ifndef TFHTTP_H
#define TFHTTP_H
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QTimer>
#include <QThread>
#include <QEventLoop>
#include <QGuiApplication>

class  TFHttp
{
public:
    typedef struct {
        bool isSuccess;
        QByteArray data;
    }HttpResult;

    ///
    /// \brief get 同步接口
    /// \param url url地址
    /// \return
    ///
    static HttpResult get(const QUrl& url){
        QNetworkAccessManager nm;
        nm.setRedirectPolicy(QNetworkRequest::NoLessSafeRedirectPolicy);//允许重定向
        QNetworkRequest request(url);
        request.setSslConfiguration(getSslConfig());
        QEventLoop el;
        QObject::connect(&nm, &QNetworkAccessManager::finished,&el,&QEventLoop::quit);
        QScopedPointer<QNetworkReply,QScopedPointerDeleteLater> reply(nm.get(request));
        el.exec();

        //异常处理
        if(reply->error() != QNetworkReply::NoError){
            HttpResult result = {false,reply->errorString().toUtf8()};
            qDebug() << "download error:" << result.data;
            return result;
        }
        HttpResult result = {true,reply->readAll()};
        return result;
    }

    static HttpResult post(const QUrl& url,const QByteArray &data){
        QNetworkAccessManager nm;
        nm.setRedirectPolicy(QNetworkRequest::NoLessSafeRedirectPolicy);//允许重定向
        QNetworkRequest request(url);
        request.setSslConfiguration(getSslConfig());
        QEventLoop el;
        QObject::connect(&nm, &QNetworkAccessManager::finished,&el,&QEventLoop::quit);
        QScopedPointer<QNetworkReply,QScopedPointerDeleteLater> reply(nm.post(request,data));
        el.exec();

        //异常处理
        if(reply->error() != QNetworkReply::NoError){
            HttpResult result = {false,reply->errorString().toUtf8()};
            qDebug() << "download error:" << result.data;
            return result;
        }
        HttpResult result = {true,reply->readAll()};
        return result;
    }


    ///
    /// 以下是异步接口
    /// typedef void (*callbackFunc)(const HttpResult& );
    ///
    template<typename T>
    static void get(const QUrl& url,T callbackFunc){
        if(!url.isValid()){
            qDebug() << "url is invaild ==>" << url;
            HttpResult result = {false,QByteArray("url is invaild")};
            callbackFunc(result);
            return;
        }
        QNetworkAccessManager* nm = new QNetworkAccessManager;
        nm->setRedirectPolicy(QNetworkRequest::NoLessSafeRedirectPolicy);//允许重定向
        QNetworkRequest request(url);
        request.setSslConfiguration(getSslConfig());
        QObject::connect(nm,&QNetworkAccessManager::finished,qApp,[=](QNetworkReply *reply){
            bool  isSuccess = (reply->error() == QNetworkReply::NoError);
            HttpResult result = {isSuccess,isSuccess?reply->readAll():reply->errorString().toUtf8()};
            callbackFunc(result);
            reply->deleteLater();
            nm->deleteLater();
        });
        nm->get(request);
    }

    template<typename T>
    static void post(const QUrl& url,const QByteArray &data,T callbackFunc){
        if(!url.isValid()){
            qDebug() << "url is invaild ==>" << url;
            HttpResult result = {false,QByteArray("url is invaild")};
            callbackFunc(result);
            return;
        }
        QNetworkAccessManager* nm = new QNetworkAccessManager;
        nm->setRedirectPolicy(QNetworkRequest::NoLessSafeRedirectPolicy);//允许重定向
        QNetworkRequest request(url);
        request.setSslConfiguration(getSslConfig());
        QObject::connect(nm,&QNetworkAccessManager::finished,gTFCore,[=](QNetworkReply *reply){
            bool  isSuccess = (reply->error() == QNetworkReply::NoError);
            HttpResult result = {isSuccess,isSuccess?reply->readAll():reply->errorString().toUtf8()};
            callbackFunc(result);
            reply->deleteLater();
            nm->deleteLater();
        });
        nm->post(request,data);
    }

    static QSslConfiguration getSslConfig(){
        QSslConfiguration SslConfig = QSslConfiguration::defaultConfiguration();
        SslConfig.setPeerVerifyMode(QSslSocket::VerifyNone);
        SslConfig.setProtocol(QSsl::TlsV1_2);
        return SslConfig;
    }
};



#endif // TFHTTP_H
