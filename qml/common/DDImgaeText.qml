/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.自定义进度条样式
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

Item {
    height: 65
    property url imageUrl: "footer_1.png"
    property var bigText: "1.2亿+企业"
    property var smallText: "千万家企业信息，随时搜索查询"
    DDImage{
        id:imgId
        source: imageUrl
        anchors.left:parent.left
        anchors.leftMargin: 2
        width: sourceSize.width
    }
    DDText{
        id: name
        text: bigText
        height: parent.height
        anchors.left:imgId.right
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 16
        horizontalAlignment: Text.AlignLeft
    }
}
