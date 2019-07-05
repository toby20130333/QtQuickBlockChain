#ifndef DDNAccountsModel_H
#define DDNAccountsModel_H

#include <QAbstractTableModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include "ddntablemodel.h"


typedef struct tagDDNAccountsInfo{
    QString address;
    QString amout;
    QString publicKey;
    tagDDNAccountsInfo(){
        address.clear();
        amout.clear();
        publicKey.clear();
    }
}DDNAccountsInfo;

class DDNAccountsObject
{
public:
    DDNAccountsObject(){}
    DDNAccountsObject(const DDNAccountsObject& other):
        mInfo(other.getInfo())
    {

    }

    DDNAccountsObject(const DDNAccountsInfo& info):
        mInfo(info)
    {

    }

    DDNAccountsInfo getInfo() const{return mInfo;}
    void setDessert(const DDNAccountsInfo& dessert){mInfo = dessert;}
private:
    DDNAccountsInfo mInfo;
};

class DDNAccountsModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DDNAccountsModel(QObject *parent = 0);
    Q_INVOKABLE void initData(int count = 5);
    Q_INVOKABLE void addObject(const QJsonObject &obj);

    void addDataList(const QList<DDNAccountsObject>& list);
    void addDataList(const DDNAccountsObject& listStu);


    void addRowData(int row,const DDNAccountsObject& data);
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
    QList<DDNAccountsObject> mObjDataList;
};

#endif // DDNAccountsModel_H
