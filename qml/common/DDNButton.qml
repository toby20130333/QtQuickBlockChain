import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "./style" as DDNStyle
import "../common" as Common

Button{
    id:loginBtn
    property color btnColor:backgroud
    property color textColor:seleted_color
    property int btnRadius: 0
    property bool isHover: false
    height: 40
    width: 100
    style:ButtonStyle {
        background: Rectangle {
            implicitWidth: loginBtn.width
            implicitHeight: loginBtn.height
            border.width: 0
            border.color: "#888"
            color:btnColor
            radius: btnRadius
        }
        label: Common.DDText{
            text:control.text
            color:textColor
        }
    }
}
