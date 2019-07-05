import QtQuick 2.0

Item {
    property bool isReached: false
    property string iText: "生成主密鑰"
    property string iNum: "1"
    property bool isTheLast: false
    Row{
        anchors.fill: parent
        spacing: 10
        DDRectangle{
            height: parent.height
            width: height
            radius: height/2
            color:!isReached?backgroud_seleted:backgroud
            DDText{
                text:iNum
                width: parent.width/4
                height: parent.height
                anchors.fill: parent
            }
        }
        DDText{
            text:iText
            width: parent.width/4+20
            height: parent.height
        }
        DDRectangle{
            width: isTheLast?0:parent.width/2-20
            height: isTheLast?0:1
            color: line_color
            visible: !isTheLast
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
