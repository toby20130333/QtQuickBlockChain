import QtQuick 2.0
import "../../common" as Common
Rectangle {
    property string ddnNick: "名称"
    property string ddnAddress: "钱包地址"
    property string ddnAmount: "余额(DDN)"
    property string ddnOption: "操作"
    property string ddnLock: "锁仓"
    property string ddnDel: "删除"
    property bool isHeader: false
    border.color: line_color
    color: backgroud
    Common.DDText{
        id:nickid
        anchors.left:parent.left
        anchors.leftMargin: 10
        text: ddnNick
        width: 160
        font.pixelSize: isHeader?14:12
        horizontalAlignment: Text.AlignLeft
        height: parent.height
    }
    Common.DDText{
        id:addressId
        anchors.left:nickid.right
        anchors.leftMargin: 10
        text: ddnAddress
        font.pixelSize: isHeader?14:12
        width: 100
        horizontalAlignment: Text.AlignLeft
        height: parent.height
        elide: Text.ElideRight
    }
    Common.DDText{
        id:amoutId
        anchors.left:addressId.right
        text: ddnAmount
        width: 100
        horizontalAlignment: Text.AlignLeft
        height: parent.height
        font.pixelSize: isHeader?14:12
    }
    Common.DDText{
        id:defaultId
        text: ddnOption
        anchors.left: amoutId.right
        anchors.leftMargin: 10
        height: parent.height-10
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:lockId.left
        anchors.rightMargin: 10
        font.pixelSize: isHeader?14:12
    }
    Common.DDText{
        id:lockId
        text: ddnLock
        width:180
        height: parent.height-10
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: delId.left
        anchors.rightMargin: 10
        font.pixelSize: isHeader?14:12
    }
    Common.DDText{
        id:delId
        text:ddnDel
        width: 140
        height: parent.height-10
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: isHeader?14:12
    }
}
