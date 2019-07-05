#ifndef DDNDELEGATE_H
#define DDNDELEGATE_H

#include <QAbstractTableModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include "ddntablemodel.h"


typedef struct tagDDNDelegatesInfo{
    QString address;//地址
    QString amout;//收入
    QString username;//用户名
    QString approval;//得票率
    QString productivity;// 生产率
    tagDDNDelegatesInfo(){
        address.clear();
        amout.clear();
        username.clear();
        approval.clear();
        productivity.clear();
    }
}DDNDelegatesInfo;

class DDNDelegatesObject
{
public:
    DDNDelegatesObject(){}
    DDNDelegatesObject(const DDNDelegatesObject& other):
        mInfo(other.getInfo())
    {

    }
    DDNDelegatesObject(const DDNDelegatesInfo& info):
        mInfo(info)
    {

    }
    DDNDelegatesInfo getInfo() const{return mInfo;}
    void setDessert(const DDNDelegatesInfo& dessert){mInfo = dessert;}
private:
    DDNDelegatesInfo mInfo;
};

class DDNDelegatesModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DDNDelegatesModel(QObject *parent = 0);
    Q_INVOKABLE void initData(int count = 5);
    Q_INVOKABLE void addObject(const QJsonObject &obj);

    void addDataList(const QList<DDNDelegatesObject>& list);
    void addDataList(const DDNDelegatesObject& listStu);


    void addRowData(int row,const DDNDelegatesObject& data);
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
    QList<DDNDelegatesObject> mObjDataList;

    QString omitName(const QString &username);
};

#endif // DDNDelegatesModel_H
