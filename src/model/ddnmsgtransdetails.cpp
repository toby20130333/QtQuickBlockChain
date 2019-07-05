#include "DDNmsgTransDetails.h"
#include <QDebug>
#define UNIT 100000000

DDNMsgDetailsModel::DDNMsgDetailsModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    mObjDataList.clear();
    ddnTi  = QDateTime(QDate(2017, 12, 20),QTime(12,0,0));
}

void DDNMsgDetailsModel::initData(int count)
{
    if(count <0)return;
    for(int i=0;i<count;i++){
        DDNMsgTransInfo info;
        DDNMsgObject obj(info);
        addDataList(obj);
    }
}
#include <QDateTime>

void DDNMsgDetailsModel::addObject(const QJsonObject &obj)
{
//    qDebug()<<Q_FUNC_INFO<<obj.value("wh").toString();
    if(obj.isEmpty())return;
//    qDebug()<<Q_FUNC_INFO<<obj.value("wh").toString();
    DDNMsgTransInfo info;
    info.wh = obj.value("wh").toString();
    info.fwgg = obj.value("fwgg").toString();
    info.publishTime = obj.value("publishTime").toString();
    info.fbjgmc = obj.value("fbjgmc").toString();
    info.title =  obj.value("title").toString();
    info.subjectName = obj.value("subjectName").toString();
    info.fwjg = obj.value("fwjg").toString();
    info.scrq = obj.value("scrq").toString();
    info.ztfl = obj.value("ztfl").toString();
    info.gwzl = obj.value("gwzl").toString();
    DDNMsgObject objs(info);
    addDataList(objs);
}

void DDNMsgDetailsModel::addDataList(const QList<DDNMsgObject> &list)
{
    mObjDataList.append(list);
}

void DDNMsgDetailsModel::addDataList(const DDNMsgObject &listStu)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mObjDataList << listStu;
    endInsertRows();
}

void DDNMsgDetailsModel::addRowData(int row, const DDNMsgObject &data)
{
    if(row < 0 || row > mObjDataList.size()-1)return;
    mObjDataList.insert(row,data);
    insertRows(row,1,this->index(0,0).parent());
}

void DDNMsgDetailsModel::removeRowData(int row)
{
    if(row <0 || row > mObjDataList.size()-1)return;
    mObjDataList.removeAt(row);
    removeRows(row,1,this->index(0,0).parent());
}

int DDNMsgDetailsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjDataList.size();
    // FIXME: Implement me!
}

int DDNMsgDetailsModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 8;
    // FIXME: Implement me!
}

QVariant DDNMsgDetailsModel::data(const QModelIndex &index, int role) const
{
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    if (!index.isValid() || rowCount() < index.row() || index.row() < 0)
        return QVariant();
    DDNMsgObject obj = mObjDataList[index.row()];
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    DDNMsgTransInfo info = obj.getInfo();
    switch (role) {
    case 0:
        return info.wh;
    case 1:
        return info.fwgg;
    case 2:
        return info.publishTime;
    case 3:
        return info.fbjgmc;
    case 4:
        return info.title;
    case 5:
        return info.subjectName;
    case 6:
        return info.fwjg;
    case 7:
        return info.scrq;
    case 8:
        return info.ztfl;
    case 9:
        return info.gwzl;
    default:
        break;
    }
    return QVariant();
}


bool DDNMsgDetailsModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool DDNMsgDetailsModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> DDNMsgDetailsModel::roleNames() const
{
    QHash<int, QByteArray> hashData;
    hashData.insert(0,"wh");
    hashData.insert(1,"fwgg");
    hashData.insert(2,"publishTime" );
    hashData.insert(3,"fbjgmc" );
    hashData.insert(4,"title" );
    hashData.insert(5,"subjectName" );
    hashData.insert(6,"fwjg");
    hashData.insert(7,"scrq");
    hashData.insert(8,"ztfl");
    hashData.insert(9,"gwzl");
    return hashData;
}


QStringList DDNMsgDetailsModel::userRoleNames()
{
    QMap<int, QString> res;
    QHashIterator<int, QByteArray> i(roleNames());
    while (i.hasNext()) {
        i.next();
//        if(i.key() > Qt::UserRole)
            res[i.key()] = i.value();
    }
    return res.values();
}
