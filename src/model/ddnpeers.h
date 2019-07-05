#ifndef DDNPeerDetailsModel_H
#define DDNPeerDetailsModel_H

#include <QAbstractTableModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include "ddntablemodel.h"

typedef struct tagDDNPEERInfo{
    QString ip;
    qint64 port;
    int status;//0 zhuanzhang
    QString os;
    QString version;
    tagDDNPEERInfo(){
        ip.clear();
        port=0;
        status=0;
        os.clear();
        version.clear();
    }
}DDNPEERInfo;

class DDNPEERObject
{
public:
    DDNPEERObject(){}
    DDNPEERObject(const DDNPEERObject& other):
        mInfo(other.getInfo())
    {

    }

    DDNPEERObject(const DDNPEERInfo& info):
        mInfo(info)
    {

    }

    DDNPEERInfo getInfo() const{return mInfo;}
    void setDessert(const DDNPEERInfo& dessert){mInfo = dessert;}
private:
    DDNPEERInfo mInfo;
};

class DDNPeerDetailsModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DDNPeerDetailsModel(QObject *parent = 0);
    Q_INVOKABLE void initData(int count = 5);
    Q_INVOKABLE void addObject(const QJsonObject &obj);

    void addDataList(const QList<DDNPEERObject>& list);
    void addDataList(const DDNPEERObject& listStu);


    void addRowData(int row,const DDNPEERObject& data);
    void removeRowData(int row);
    // Basic functionality:
    Q_INVOKABLE  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    // Remove data:
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    virtual QHash<int,QByteArray> roleNames() const;
    Q_INVOKABLE QStringList userRoleNames();

private:
    QList<DDNPEERObject> mObjDataList;
    QString omitName(const QString &username);
};

#endif // DDNPeerDetailsModel_H
