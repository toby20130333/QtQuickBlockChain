#ifndef DDNTABLEMODEL_H
#define DDNTABLEMODEL_H

#include <QAbstractTableModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDateTime>

typedef struct tagDDNTableInfo{
    QString id;
    qint64 height;
    qint64 numberOfTransactions;
    QString totalAmount;
    QString reward;
    QString totalFee;
    QString generatorId;
    QString timestamp;
    tagDDNTableInfo(){
        id.clear();
        height=0;
        numberOfTransactions=0;
        totalAmount.clear();
        reward.clear();
        timestamp.clear();
        generatorId.clear();
    }
}DDNTableInfo;

enum DDNTableEnum{
    FIRST = 0x00000,
    SECONDE,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVE,
    EIGHT
};

class DDNTableObject
{
public:
    DDNTableObject(){}
    DDNTableObject(const DDNTableObject& other):
        mInfo(other.getInfo())
    {

    }

    DDNTableObject(const DDNTableInfo& info):
        mInfo(info)
    {

    }

    DDNTableInfo getInfo() const{return mInfo;}
    void setDessert(const DDNTableInfo& dessert){mInfo = dessert;}
private:
    DDNTableInfo mInfo;
};

class DDNTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DDNTableModel(QObject *parent = 0);
    Q_INVOKABLE void initData(int count = 5);
    Q_INVOKABLE void addObject(const QJsonObject &obj);

    void addDataList(const QList<DDNTableObject>& list);
    void addDataList(const DDNTableObject& listStu);


    void addRowData(int row,const DDNTableObject& data);
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
    QList<DDNTableObject> mObjDataList;
    QDateTime ddnTi;
};

#endif // DDNTABLEMODEL_H
