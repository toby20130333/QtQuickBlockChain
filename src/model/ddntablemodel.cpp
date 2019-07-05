#include "ddntablemodel.h"
#include <QDebug>
#include <QDateTime>

#define UNIT 100000000

DDNTableModel::DDNTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    mObjDataList.clear();
    ddnTi  = QDateTime(QDate(2017, 12, 20),QTime(12,0,0));
}

void DDNTableModel::initData(int count)
{
    if(count <0)return;
    for(int i=0;i<count;i++){
        DDNTableInfo info;
        DDNTableObject obj(info);
        addDataList(obj);
    }
}
void DDNTableModel::addObject(const QJsonObject &obj)
{
    if(obj.isEmpty())return;
    DDNTableInfo info;
    info.id = obj.value("id").toString();
    info.height = obj.value("height").toDouble();
    info.numberOfTransactions = obj.value("numberOfTransactions").toDouble()/UNIT;
    info.reward = QString("%1DDN").arg(obj.value("reward").toDouble()/UNIT);
    info.totalAmount = QString("%1DDN").arg(obj.value("totalAmount").toDouble()/UNIT);
    info.totalFee = QString("%1DDN").arg(obj.value("toDouble").toDouble());
    info.generatorId = obj.value("generatorId").toString();
    qint64 ti = obj.value("timestamp").toDouble();
    //qDebug()<<" ddnTi "<<ddnTi.toSecsSinceEpoch()<<" ti "<<ti;
    ti = ti+ddnTi.toSecsSinceEpoch();
//    qDebug()<<" ddnTi  Total "<<ti;
    info.timestamp = QString("%1").arg(QDateTime::fromMSecsSinceEpoch(ti*1000).toString());
    DDNTableObject objs(info);
    addDataList(objs);
}

void DDNTableModel::addDataList(const QList<DDNTableObject> &list)
{
    mObjDataList.append(list);
}

void DDNTableModel::addDataList(const DDNTableObject &listStu)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mObjDataList << listStu;
    endInsertRows();
}

void DDNTableModel::addRowData(int row, const DDNTableObject &data)
{
    if(row < 0 || row > mObjDataList.size()-1)return;
    mObjDataList.insert(row,data);
    insertRows(row,1,this->index(0,0).parent());
}

void DDNTableModel::removeRowData(int row)
{
    if(row <0 || row > mObjDataList.size()-1)return;
    mObjDataList.removeAt(row);
    removeRows(row,1,this->index(0,0).parent());
}

int DDNTableModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjDataList.size();
}

int DDNTableModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 8;
}

QVariant DDNTableModel::data(const QModelIndex &index, int role) const
{
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    if (!index.isValid() || rowCount() < index.row() || index.row() < 0)
        return QVariant();
    DDNTableObject obj = mObjDataList[index.row()];
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    DDNTableInfo info = obj.getInfo();
    switch (role) {
    case FIRST:
        return info.id;
    case SECONDE:
        return info.height;
    case THREE:
        return info.numberOfTransactions;
    case FOUR:
        return info.totalAmount;
    case FIVE:
        return info.reward;
    case SIX:
        return info.totalFee;
    case SEVE:
        return info.generatorId;
    case EIGHT:
        return info.timestamp;
    default:
        break;
    }
    return QVariant();
}


bool DDNTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool DDNTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> DDNTableModel::roleNames() const
{
    QHash<int, QByteArray> hashData;
    hashData.insert(FIRST,"id");
    hashData.insert(SECONDE,"height");
    hashData.insert(THREE,"numberOfTransactions" );
    hashData.insert(FOUR,"totalAmount" );
    hashData.insert(FIVE,"reward" );
    hashData.insert(SIX,"totalFee" );
    hashData.insert(SEVE,"generatorId");
    hashData.insert(EIGHT,"timestamp");
    return hashData;
}


QStringList DDNTableModel::userRoleNames()
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
