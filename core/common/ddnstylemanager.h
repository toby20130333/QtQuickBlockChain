#ifndef DDNSTYLEMANAGER_H
#define DDNSTYLEMANAGER_H

#include <QObject>
#include <QColor>
#include <QMap>

class DDNStyleManager : public QObject
{
    Q_OBJECT
public:
    explicit DDNStyleManager(QObject *parent = nullptr);
    ~DDNStyleManager();
    ///
    /// \brief changeSkin
    /// \param type
    /// 更改皮肤
    ///
    Q_INVOKABLE void changeSkin(const QString &skinfile,bool first=false);
    Q_INVOKABLE QStringList getAllTagsSkins();
    Q_INVOKABLE QColor getColorByKey(const QString &key);
signals:
    void signalSkinChanged(const QString &skin,bool first);
    void signalSkinFilesChanged();
public slots:
    ///
    /// \brief initAllSkins
    ///初始化所有皮肤
    ///
    void initAllSkins();
    QString getCurSkin();
private:
    QStringList getAllSkins();
    void save();
    void restore();
private:
    QMap<QString,QColor> mStyleMap;
    QMap<QString,QString> mUiSkinMap;
    QString curSkin;
};

#endif // DDNSTYLEMANAGER_H
