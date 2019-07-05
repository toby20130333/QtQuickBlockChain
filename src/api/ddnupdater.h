#ifndef DDNUPDATER_H
#define DDNUPDATER_H

#include <QObject>
#include <QSettings>
#include "core/common/downloadmanager.h"

class DDNUpdater : public QObject
{
    Q_OBJECT
public:
    explicit DDNUpdater(QObject *parent = nullptr);
    void checkIni();
    ///
    /// \brief hasUpdater
    /// \return
    /// 检查是否有更新
    ///
    bool hasUpdater();

    QString getLastVersion();

    QUrl getNewDownloadUrl();

    bool restartApp(bool restart=true);

    void movIniFile();
signals:
    void signalHasUpdater();
public slots:
private:
    void init();
    QUrl mDownloadUrl;
    QString mVersion;
    QUrl mIniUrl;
    DownloadManager mDownMa;
};

#endif // DDNUPDATER_H
