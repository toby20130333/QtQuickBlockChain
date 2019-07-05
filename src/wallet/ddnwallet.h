#ifndef DDNWALLET_H
#define DDNWALLET_H

#include <QObject>
#include <QString>
#include <QCryptographicHash>
typedef struct tag_DDNWalletData
{
        QString      f_phasePass; // 交易密码
        QString       phaseKey;  // 主密钥
        QString       address; //钱包地址
        QString       v_addressError;//错误信息
        QString       disc;//钱包描述
        tag_DDNWalletData() {}
}DDNWalletData;

class DDNWallet : public QObject
{
    Q_OBJECT
public:
    explicit DDNWallet(QObject *parent = nullptr);

    void handleCreatePhase(const QString &phase);
signals:

public slots:
private:
    DDNWalletData mWallet;
private:
    QString crypto_sign_keypair_fromseed(const QString &seed);
    QString getDeviceIdBySha(const QString &phase,QCryptographicHash::Algorithm = QCryptographicHash::Md5);
    QString getAddress(const QString &publicKey);
};

#endif // DDNWALLET_H
