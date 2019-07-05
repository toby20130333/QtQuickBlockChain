#include "DDNTransDetails.h"
#include <QDebug>
#define UNIT 100000000

DDNTransDetailsModel::DDNTransDetailsModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    mObjDataList.clear();
    ddnTi  = QDateTime(QDate(2017, 12, 20),QTime(12,0,0));
}

void DDNTransDetailsModel::initData(int count)
{
    if(count <0)return;
    for(int i=0;i<count;i++){
        DDNTransInfo info;
        DDNTransObject obj(info);
        addDataList(obj);
    }
}
#include <QDateTime>

void DDNTransDetailsModel::addObject(const QJsonObject &obj)
{
    if(obj.isEmpty())return;
    DDNTransInfo info;
    info.id = obj.value("id").toString();
    info.height = obj.value("height").toString().toDouble();
    info.transType = obj.value("type").toInt();
    info.receviId = obj.value("recipientId").toString();
    info.totalAmount = QString("%1DDN").arg(QString::number(obj.value("amount").toDouble()/UNIT,'f',2));
    info.totalFee = QString("%1DDN").arg(obj.value("fee").toDouble()/UNIT);
    info.senderId = obj.value("senderId").toString();
    double ti = obj.value("timestamp").toDouble();
    ti = ti+ddnTi.toSecsSinceEpoch();
    info.timestamp = QString("%1").arg(QDateTime::fromMSecsSinceEpoch(ti*1000).toString());
    DDNTransObject objs(info);
    addDataList(objs);
}

void DDNTransDetailsModel::addDataList(const QList<DDNTransObject> &list)
{
    mObjDataList.append(list);
}

void DDNTransDetailsModel::addDataList(const DDNTransObject &listStu)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mObjDataList << listStu;
    endInsertRows();
}

void DDNTransDetailsModel::addRowData(int row, const DDNTransObject &data)
{
    if(row < 0 || row > mObjDataList.size()-1)return;
    mObjDataList.insert(row,data);
    insertRows(row,1,this->index(0,0).parent());
}

void DDNTransDetailsModel::removeRowData(int row)
{
    if(row <0 || row > mObjDataList.size()-1)return;
    mObjDataList.removeAt(row);
    removeRows(row,1,this->index(0,0).parent());
}

int DDNTransDetailsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjDataList.size();
    // FIXME: Implement me!
}

int DDNTransDetailsModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 8;
    // FIXME: Implement me!
}

QVariant DDNTransDetailsModel::data(const QModelIndex &index, int role) const
{
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    if (!index.isValid() || rowCount() < index.row() || index.row() < 0)
        return QVariant();
    DDNTransObject obj = mObjDataList[index.row()];
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    DDNTransInfo info = obj.getInfo();
    switch (role) {
    case FIRST:
        return info.id;
    case SECONDE:
        return info.height;
    case THREE:
        return info.transType==0?QStringLiteral("转账"):"";
    case FOUR:
        return info.totalAmount;
    case FIVE:
        return info.totalFee;
    case SIX:
        return info.senderId;
    case SEVE:
        return info.receviId;
    case EIGHT:
        return info.timestamp;
    default:
        break;
    }
    return QVariant();
}


bool DDNTransDetailsModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool DDNTransDetailsModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> DDNTransDetailsModel::roleNames() const
{
    QHash<int, QByteArray> hashData;
    hashData.insert(FIRST,"id");
    hashData.insert(SECONDE,"height");
    hashData.insert(THREE,"transType" );
    hashData.insert(FOUR,"totalAmount" );
    hashData.insert(FIVE,"totalFee" );
    hashData.insert(SIX,"senderId" );
    hashData.insert(SEVE,"receviId");
    hashData.insert(EIGHT,"timestamp");
    return hashData;
}


QStringList DDNTransDetailsModel::userRoleNames()
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
