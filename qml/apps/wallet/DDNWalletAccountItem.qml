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
        width: 140
        horizontalAlignment: Text.AlignLeft
        height: parent.height
    }
    Common.DDText{
        id:addressId
        anchors.left:nickid.right
        anchors.leftMargin: 10
        text: ddnAddress
        anchors.right:amoutId.left
        width: 240
        horizontalAlignment: Text.AlignLeft
        height: parent.height
        elide: Text.ElideRight
    }
    Common.DDText{
        id:amoutId
        anchors.right:defaultId.left
        text: ddnAmount
        width: 140
        horizontalAlignment: Text.AlignLeft
        height: parent.height
    }
    Common.DDNButton{
        id:defaultId
        text: ddnOption
        width: 60
        height: parent.height-10
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:lockId.left
        anchors.rightMargin: 10
        btnColor: !am3.containsMouse?backgroud:backgroud_seleted
        MouseArea{
            id:am3
            anchors.fill: parent
            hoverEnabled: isHeader
        }
    }
    Common.DDNButton{
        id:lockId
        text: ddnLock
        width: 60
        visible: isHeader
        height: parent.height-10
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: delId.left
        anchors.rightMargin: 10
        btnColor: !am2.containsMouse?backgroud:backgroud_seleted
        MouseArea{
            id:am2
            anchors.fill: parent
            hoverEnabled: true
        }
    }
    Common.DDNButton{
        id:delId
        text:ddnDel
        width: 60
        height: parent.height-10
        visible: isHeader
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        btnColor: !am5.containsMouse?backgroud:backgroud_seleted
        MouseArea{
            id:am5
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
