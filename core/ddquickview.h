/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.用于主要说明此程序文件完成的主要功能
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


#ifndef DDQuickView_H
#define DDQuickView_H

#include <QQuickView>
#include <QMouseEvent>
#include <QQmlContext>

#include <QPoint>
#include <QCursor>
#include <QRect>
#include <QPainter>
#include <QPaintEvent>
#include <QDebug>
#include <QEvent>
#include <QQuickItem>
#include <QSystemTrayIcon>
#include <QMenu>
#include <QAction>

#include "ddframelesshelper.h"

class DDQuickView : public QQuickView
{
    Q_OBJECT
public:
    explicit DDQuickView(QQuickView *parent = 0);
    ~DDQuickView();
    void setSourceAndRegsiterObj(const QUrl& url,bool regsiter=true);
    ///
    /// \brief registerCppModel
    /// must register some cpp model before setSource;
    ///
    virtual void registerCppModel(){}
    ///
    /// \brief registerCppToQmlConnects
    /// can register some connects between cpp and qml
    ///
    virtual void registerCppToQmlConnects(){}
    ///
    Q_INVOKABLE  void transQmlToOther(QVariant,QVariant);

    QObject *getQmlObj();
    QObject *getSystemTrayIcon();
protected:
    void mouseDoubleClickEvent(QMouseEvent *event);
    bool event(QEvent *);
private:
    QObject *mRootObj{nullptr};
    DDFramelessHelper *mHelper{nullptr};
    QSystemTrayIcon *mTrayIcon{nullptr};
    bool mIsMax{false};
private slots:
    void slotShowMaximized();
private:

    ///
    /// \brief showMaxAndNormalWindow
    /// \param showMax
    ///  可控制窗口正常和最大化的方法
    /// qml 可重写transToQml函数 实现业务逻辑
    ///
    void showMaxAndNormalWindow(bool showMax);
public slots:
    ///
    /// \brief slotRecevQmlReq
    /// \param var
    /// \param cmd
    /// 接受qml层的数据
    ///
    void slotRecevQmlReq(QVariant var, QVariant cmd);
    ///
    /// \brief slotRecevQmlMoveH
    /// \param var
    /// 接受qml处的 可移动窗口的高度
    ///
    void slotRecevQmlMoveH(QVariant var);
    ///
    /// \brief showTrayIcon
    /// 显示系统托盘图标
    ///
    void showTrayIcon();
    ///
    /// \brief setWindowResizable
    /// \param resizable
    /// 设置窗口可拉伸
    ///
    void setWindowResizable(bool resizable);
    ///
    /// \brief notifyToUi
    /// \param var
    /// \return
    /// 通知qml ui qml层可写入该函数进行逻辑处理
    ///
    QVariant notifyToUi(const QVariant &var=QVariant());
};

#endif // DDQuickView_H
