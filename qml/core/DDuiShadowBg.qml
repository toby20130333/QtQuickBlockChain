/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.主要作用于边框阴影效果
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

import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../common" as DDCommon

DDCommon.DDRectangle {
    //最底层透明图层
    width: 480;
    height: 680;
    color: "transparent"
    property double bgmarigns: 8.0
    property int listViewActive: 0
    Item {
        //主体窗口
        id: container;
        anchors.centerIn: parent;
        width: parent.width;
        height: parent.height;
        DDCommon.DDRectangle {
            id: mainRect
            width: container.width-(2*rectShadow.radius);
            height: container.height - (2*rectShadow.radius);
            anchors.centerIn: parent;
            //以下省略
        }
    }
    DropShadow {//绘制阴影
        id: rectShadow;
        anchors.fill: source
        cached: true;
        horizontalOffset: 0;
        verticalOffset: 3;
        radius: bgmarigns;
        samples: 16;
        color: "#80000000";
        smooth: true;
        source: container;
    }
}

