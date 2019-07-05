#include "DDNaccounts.h"
#include <QDebug>
#define UNIT 100000000

DDNAccountsModel::DDNAccountsModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    mObjDataList.clear();
}

void DDNAccountsModel::initData(int count)
{
    if(count <0)return;
    for(int i=0;i<count;i++){
        DDNAccountsInfo info;
        DDNAccountsObject obj(info);
        addDataList(obj);
    }
}
#include <QDateTime>

void DDNAccountsModel::addObject(const QJsonObject &obj)
{
    if(obj.isEmpty())return;
    DDNAccountsInfo info;
    info.address = obj.value("address").toString();
    info.amout = QString::number(obj.value("balance").toDouble()/UNIT,'f',6).append(" DDN");
    info.publicKey = obj.value("publicKey").toString();
    DDNAccountsObject objs(info);
    addDataList(objs);
}

void DDNAccountsModel::addDataList(const QList<DDNAccountsObject> &list)
{
    mObjDataList.append(list);
}

void DDNAccountsModel::addDataList(const DDNAccountsObject &listStu)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mObjDataList << listStu;
    endInsertRows();
}

void DDNAccountsModel::addRowData(int row, const DDNAccountsObject &data)
{
    if(row < 0 || row > mObjDataList.size()-1)return;
    mObjDataList.insert(row,data);
    insertRows(row,1,this->index(0,0).parent());
}

void DDNAccountsModel::removeRowData(int row)
{
    if(row <0 || row > mObjDataList.size()-1)return;
    mObjDataList.removeAt(row);
    removeRows(row,1,this->index(0,0).parent());
}

int DDNAccountsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjDataList.size();
    // FIXME: Implement me!
}

int DDNAccountsModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 3;
    // FIXME: Implement me!
}

QVariant DDNAccountsModel::data(const QModelIndex &index, int role) const
{
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    if (!index.isValid() || rowCount() < index.row() || index.row() < 0)
        return QVariant();
    DDNAccountsObject obj = mObjDataList[index.row()];
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    DDNAccountsInfo info = obj.getInfo();
    switch (role) {
    case FIRST:
        return info.address;
    case SECONDE:
        return info.amout;
    case THREE:
        return info.publicKey;
    default:
        break;
    }
    return QVariant();
}


bool DDNAccountsModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool DDNAccountsModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> DDNAccountsModel::roleNames() const
{
    QHash<int, QByteArray> hashData;
    hashData.insert(FIRST,"address");
    hashData.insert(SECONDE,"amount");
    hashData.insert(THREE,"pbkey" );
    return hashData;
}


QStringList DDNAccountsModel::userRoleNames()
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
