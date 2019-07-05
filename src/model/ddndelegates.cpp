#include "ddndelegates.h"
#include <QDebug>
#define UNIT 100000000

DDNDelegatesModel::DDNDelegatesModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    mObjDataList.clear();
}

void DDNDelegatesModel::initData(int count)
{
    if(count <0)return;
    for(int i=0;i<count;i++){
        DDNDelegatesInfo info;
        DDNDelegatesObject obj(info);
        addDataList(obj);
    }
}
#include <QDateTime>

void DDNDelegatesModel::addObject(const QJsonObject &obj)
{
    if(obj.isEmpty())return;
    DDNDelegatesInfo info;
    info.address = obj.value("address").toString();
    info.amout = QString::number(obj.value("balance").toDouble()/UNIT,'f',6).append(" DDN");
    info.username = omitName(obj.value("username").toString());
    info.approval = QString::number(obj.value("approval").toDouble()).append("%");
    info.productivity = QString::number(obj.value("productivity").toDouble()).append("%");
    DDNDelegatesObject objs(info);
    addDataList(objs);
}

void DDNDelegatesModel::addDataList(const QList<DDNDelegatesObject> &list)
{
    mObjDataList.append(list);
}

void DDNDelegatesModel::addDataList(const DDNDelegatesObject &listStu)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mObjDataList << listStu;
    endInsertRows();
}

void DDNDelegatesModel::addRowData(int row, const DDNDelegatesObject &data)
{
    if(row < 0 || row > mObjDataList.size()-1)return;
    mObjDataList.insert(row,data);
    insertRows(row,1,this->index(0,0).parent());
}

void DDNDelegatesModel::removeRowData(int row)
{
    if(row <0 || row > mObjDataList.size()-1)return;
    mObjDataList.removeAt(row);
    removeRows(row,1,this->index(0,0).parent());
}

int DDNDelegatesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjDataList.size();
    // FIXME: Implement me!
}

int DDNDelegatesModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 5;
    // FIXME: Implement me!
}

QVariant DDNDelegatesModel::data(const QModelIndex &index, int role) const
{
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    if (!index.isValid() || rowCount() < index.row() || index.row() < 0)
        return QVariant();
    DDNDelegatesObject obj = mObjDataList[index.row()];
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    DDNDelegatesInfo info = obj.getInfo();
    switch (role) {
    case FIRST:
        return info.username;
    case SECONDE:
        return info.address;
    case THREE:
        return info.approval;
    case FOUR:
        return info.productivity;
    case FIVE:
        return info.amout;
    default:
        break;
    }
    return QVariant();
}


bool DDNDelegatesModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool DDNDelegatesModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> DDNDelegatesModel::roleNames() const
{
    QHash<int, QByteArray> hashData;
    hashData.insert(FIRST,"username");
    hashData.insert(SECONDE,"address");
    hashData.insert(THREE,"approval" );
    hashData.insert(FOUR,"productivity");
    hashData.insert(FIVE,"amount" );
    return hashData;
}


QStringList DDNDelegatesModel::userRoleNames()
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

QString DDNDelegatesModel::omitName(const QString &username)
{
    QString omit = username;
    omit = omit.replace(omit.length()-3,omit.length(),"***");
    return omit;
}
