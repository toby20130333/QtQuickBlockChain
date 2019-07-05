#include "ddnwallet.h"
#include "bip/bip39.h"
#include "bip/sweetnalc.h"

DDNWallet::DDNWallet(QObject *parent) : QObject(parent)
{

}

void DDNWallet::handleCreatePhase(const QString &phase)
{
    mWallet.f_phasePass = phase;
    QString mnemonic = QString(mnemonic_generate(128));
    QString hash = getDeviceIdBySha(mnemonic,QCryptographicHash::Sha256);
    unsigned char *pkey = new unsigned char[crypto_sign_ed25519_tweet_PUBLICKEYBYTES];
    unsigned char *sk= new unsigned char[crypto_sign_ed25519_tweet_SECRETKEYBYTES];

    int res = crypto_sign_ed25519_keypair(pkey,sk);
//    QString keys = crypto.getKeys(mnemonic);
//    QString address = crypto.getAddress(keys.publicKey);
//    mWallet.phaseKey = mnemonic;
    //    mWallet.address = address;
}

QString DDNWallet::crypto_sign_keypair_fromseed(const QString &seed)
{
    if (seed.size()  != crypto_sign_ed25519_tweet_PUBLICKEYBYTES) return "";
    unsigned char *pkey = new unsigned char[crypto_sign_ed25519_tweet_PUBLICKEYBYTES];
    unsigned char *sk = new unsigned char[crypto_sign_ed25519_tweet_SECRETKEYBYTES];
    for (int i = 0; i < 32; i++) sk[i] = seed.at(i).toLatin1();
    crypto_sign_ed25519_keypair(pkey,sk);
    return "";
}

QString DDNWallet::getDeviceIdBySha(const QString &phase, QCryptographicHash::Algorithm algor)
{
    QCryptographicHash crypto(algor);
    crypto.addData(phase.toUtf8());
    return crypto.result().toHex();
}
QString DDNWallet::getAddress(const QString & publicKey) {
    //return addressHelper.generateBase58CheckAddress(publicKey);
    QString hs = getDeviceIdBySha(publicKey,QCryptographicHash::Sha256);
//    var h2 = new RIPEMD160().update(Buffer.from(h1)).digest()
//        return NORMAL_PREFIX + base58check.encode(h2)
    return "";
}
