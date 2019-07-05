#ifndef DDNMsgDetailsModel_H
#define DDNMsgDetailsModel_H

#include <QAbstractTableModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

#include <QDateTime>

typedef struct tagDDNMsgTransInfo{
    QString wh;// QString 工厅安全〔2018〕581号QString ,
    QString fwgg;// QString 办公厅简函QString ,
    QString publishTime;// QString 20180809082112QString ,
    QString fbjgmc;// QString 安全生产司QString ,
    QString title;// QString 工业和信息化部办公厅关于举办部属单位安全管理人员培训班的通知QString ,
    QString subjectName;// QString 其他QString ,
    QString fwjg;// QString 办公厅QString ,
    QString scrq;// QString 2018-07-31QString ,
    QString ztfl;// QString 安全生产QString ,
    QString gwzl;// QString 通知QString
    tagDDNMsgTransInfo(){
    }
}DDNMsgTransInfo;

//enum DDNTableEnumX{
//    FIRST = 0x00000,
//    SECONDE,
//    THREE,
//    FOUR,
//    FIVE,
//    SIX,
//    SEVE,
//    EIGHT
//};

class DDNMsgObject
{
public:
    DDNMsgObject(){}
    DDNMsgObject(const DDNMsgObject& other):
        mInfo(other.getInfo())
    {

    }

    DDNMsgObject(const DDNMsgTransInfo& info):
        mInfo(info)
    {

    }

    DDNMsgTransInfo getInfo() const{return mInfo;}
    void setDessert(const DDNMsgTransInfo& dessert){mInfo = dessert;}
private:
    DDNMsgTransInfo mInfo;
};

class DDNMsgDetailsModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit DDNMsgDetailsModel(QObject *parent = 0);
    Q_INVOKABLE void initData(int count = 5);
    Q_INVOKABLE void addObject(const QJsonObject &obj);

    void addDataList(const QList<DDNMsgObject>& list);
    void addDataList(const DDNMsgObject& listStu);


    void addRowData(int row,const DDNMsgObject& data);
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
    QList<DDNMsgObject> mObjDataList;
    QDateTime ddnTi;
};

#endif // DDNMsgDetailsModel_H
