#include "DDNpeers.h"
#include <QDebug>
#define UNIT 100000000

DDNPeerDetailsModel::DDNPeerDetailsModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    mObjDataList.clear();
}

void DDNPeerDetailsModel::initData(int count)
{
    if(count <0)return;
    for(int i=0;i<count;i++){
        DDNPEERInfo info;
        DDNPEERObject obj(info);
        addDataList(obj);
    }
}
#include <QDateTime>

void DDNPeerDetailsModel::addObject(const QJsonObject &obj)
{
    if(obj.isEmpty())return;
    DDNPEERInfo info;
    info.ip = omitName(obj.value("ip").toString());
    info.port = obj.value("port").toDouble();
    info.status = obj.value("state").toInt();
    info.os = obj.value("os").toString();
    info.version = obj.value("version").toString();
    DDNPEERObject objs(info);
    addDataList(objs);
}

void DDNPeerDetailsModel::addDataList(const QList<DDNPEERObject> &list)
{
    mObjDataList.append(list);
}

void DDNPeerDetailsModel::addDataList(const DDNPEERObject &listStu)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mObjDataList << listStu;
    endInsertRows();
}

void DDNPeerDetailsModel::addRowData(int row, const DDNPEERObject &data)
{
    if(row < 0 || row > mObjDataList.size()-1)return;
    mObjDataList.insert(row,data);
    insertRows(row,1,this->index(0,0).parent());
}

void DDNPeerDetailsModel::removeRowData(int row)
{
    if(row <0 || row > mObjDataList.size()-1)return;
    mObjDataList.removeAt(row);
    removeRows(row,1,this->index(0,0).parent());
}

int DDNPeerDetailsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjDataList.size();
    // FIXME: Implement me!
}

int DDNPeerDetailsModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 5;
    // FIXME: Implement me!
}

QVariant DDNPeerDetailsModel::data(const QModelIndex &index, int role) const
{
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    if (!index.isValid() || rowCount() < index.row() || index.row() < 0)
        return QVariant();
    DDNPEERObject obj = mObjDataList[index.row()];
    //    qDebug()<<Q_FUNC_INFO<<role<<" index " <<index;
    DDNPEERInfo info = obj.getInfo();
    switch (role) {
    case FIRST:
        return info.ip;
    case SECONDE:
        return info.port;
    case THREE:
        return info.status==2?QStringLiteral("运行中"):"";
    case FOUR:
        return info.os;
    case FIVE:
        return info.version;
    default:
        break;
    }
    return QVariant();
}
QString DDNPeerDetailsModel::omitName(const QString &username)
{
    QString omit = username;
    QStringList lst = omit.split(".");
    if(lst.isEmpty())return "";
    QString last = lst.last();
    omit = omit.replace(omit.length()-last.length(),omit.length(),"***");
    return omit;
}

bool DDNPeerDetailsModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
    return true;
}

bool DDNPeerDetailsModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> DDNPeerDetailsModel::roleNames() const
{
    QHash<int, QByteArray> hashData;
    hashData.insert(FIRST,"ip");
    hashData.insert(SECONDE,"port");
    hashData.insert(THREE,"status" );
    hashData.insert(FOUR,"os" );
    hashData.insert(FIVE,"version" );
    return hashData;
}


QStringList DDNPeerDetailsModel::userRoleNames()
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
