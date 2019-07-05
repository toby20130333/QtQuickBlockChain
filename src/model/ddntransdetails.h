#ifndef DDNTransDetailsModel_H
#define DDNTransDetailsModel_H

#include <QAbstractTableModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include "ddntablemodel.h"

#include <QDateTime>

typedef struct tagDDNTransInfo{
    QString id;
    qint64 height;
    int transType;//0 zhuanzhang
    QString totalAmount;
    QString totalFee;
    QString senderId;
    QString receviId;
    QString timestamp;
    tagDDNTransInfo(){
        id.clear();
        height=0;
        transType=0;
        totalAmount.clear();
    }
}DDNTransInfo;

//enum DDNTableEnum{
//    FIRST = 0x00000,
//    SECONDE,
//    THREE,
//    FOUR,
//    FIVE,
//    SIX,
//    SEVE,
//    EIGHT
//};

class DDNTransObject
{
public:
    DDNTransObject(){}
    DDNTransObject(const DDNTransObject& other):
        mInfo(other.getInfo())
    {

    }

    DDNTransObject(const DDNTransInfo& info):
        mInfo(info)
    {

    }

    DDNTransInfo getInfo() const{return mInfo;}
    void setDessert(const DDNTransInfo& dessert){mInfo = dessert;}
private:
    DDNTransInfo mInfo;
};

class DDNTransDetailsModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DDNTransDetailsModel(QObject *parent = 0);
    Q_INVOKABLE void initData(int count = 5);
    Q_INVOKABLE void addObject(const QJsonObject &obj);

    void addDataList(const QList<DDNTransObject>& list);
    void addDataList(const DDNTransObject& listStu);


    void addRowData(int row,const DDNTransObject& data);
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
    QList<DDNTransObject> mObjDataList;
    QDateTime ddnTi;
};

#endif // DDNTransDetailsModel_H
