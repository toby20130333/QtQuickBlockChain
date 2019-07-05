/*********************************************************************************
  *Copyright(C),2014-2016,www.chinabigdata.com
  *FileName(文件名):  dduiquickview
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期): 2017-05-18
  *FinishDate(完成日期): 2017-05-18
  *Description(描述):
     1. 完成加载qml窗口的功能，提供与C++交互的能力
     2.与其他模块或函数的接口、输出值、取值范围、含义及参数间的控制、顺序、独立及依赖关系

  *Others(其他内容说明):
       others
  *Function List(函数列表):
     1.主要函数列表，每条记录应包含函数名及功能简要说明

     2.
  *History(历史修订记录):
     1.Date: 修改日期
       Author:修改者
       Modification:修改内容简介

     2.

**********************************************************************************/

#ifndef DDUIQUICKVIEW_H
#define DDUIQUICKVIEW_H

#include <QQuickView>
#include <core/ddquickview.h>

#include "src/api/ddnhttpapi.h"
#include "src/model/ddntablemodel.h"
#include "src/model/ddntransdetails.h"
#include "src/model/ddnpeers.h"
#include "src/model/ddnaccounts.h"
#include "src/model/ddndelegates.h"
#include "src/api/ddnupdater.h"
#include "src/model/ddnmsgtransdetails.h"

class DDuiQuickView : public DDQuickView
{
    Q_OBJECT
public:
    explicit DDuiQuickView(QQuickView *parent = 0);
    virtual void registerCppModel();
    virtual void registerCppToQmlConnects();
private:
    DDNTableModel mTableModel;//区块model
    DDNTransDetailsModel mTransModel;//交易model
    DDNPeerDetailsModel mPeersModel;//节点model
    DDNAccountsModel mAccountsModel;//账户model
    DDNDelegatesModel mDelegateModel;//委托人
    DDNMsgDetailsModel mMsgModel;//历史消息
    DDNHttpApi ddnObject;
    DDNUpdater updater;
private:
    void moveCenter();
public slots:
    void slotTransQmlToOther(QVariant,QVariant);
    void slotCheckUpdater();
    void slotSaveIniUpdaterFile();
    QVariant notifyToUi(const QVariant &var=QVariant());
    void slotShowMsg(const QString &msg,const QString &title);
};

#endif // DDUIQUICKVIEW_H
