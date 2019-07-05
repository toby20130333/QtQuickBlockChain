import QtQuick 2.0
import "../../../common" as Common
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    id:rootItem
    signal signalToStepX(bool isNext,var data);
    ColumnLayout{
        spacing: 10
        Layout.leftMargin: 40
        Common.DDText{
            text:"主秘钥"
            Layout.alignment: Qt.AlignLeft
            height: 25
        }
        TextField{
            text: "today pattern abuse lesson fossil wedding nuclear become spread elegant enrich heavy"
            Layout.alignment: Qt.AlignLeft
            readOnly: true
            Layout.maximumHeight: 40
            width: rootItem.width
            style: TextFieldStyle {
                     textColor: "#FFAF3B"
                     background: Rectangle {
                         radius: 1
                         implicitWidth: rootItem.width-40
                         implicitHeight: 40
                         border.color: line_color
                         border.width: 1
                         color: "transparent"
                     }
                 }
        }
        Common.DDCustomButton{
            btnText: "保存主秘钥"
            height: 35
            width: 100
            normalColor:scrollbar_color
            btnRadius:0
            Layout.alignment: Qt.AlignLeft
        }
        Common.DDText{
            text:"请牢记您的主密钥 （黄色单词组） 和交易密码 , 本系统无备份，丢失后无法找回"
            color: "#F44336"
            Layout.alignment: Qt.AlignLeft
            height: 25
        }
        Row{
            Layout.alignment: Qt.AlignCenter|Qt.AlignBottom
            height: 40
            spacing: 20
            Common.DDCustomButton{
                btnText: "重新生成主秘钥"
                height: 35
                width: 100
                normalColor:scrollbar_color
                btnRadius:0
                onClicked: {
                    signalToStepX(false,"");
                }
            }
            Common.DDCustomButton{
                btnText: "下一步 验证主秘钥"
                height: 35
                width: 100
                normalColor:scrollbar_color
                btnRadius:0
                onClicked: {
                    signalToStepX(true,"");
                }
            }
        }
    }
}
