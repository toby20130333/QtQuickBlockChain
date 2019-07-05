import QtQuick 2.0
import QtQuick.Controls 1.4
import "../../common" as DDNCommon

Item {
    signal signalAddressChanged(string address)
    signal openDialog(int openType)
    Column{
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        Item{
            width: parent.width
            height: 40
            DDNCommon.DDText{
                id:amoutId
                anchors.left:parent.left
                text: "余额:0"
                width: 140
                horizontalAlignment: Text.AlignLeft
                height: parent.height
            }
            DDNCommon.DDNButton{
                id:changeAmountId
                text: "转账"
                width: 60
                height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:amoutId.right
                anchors.leftMargin: 10
                btnColor: !am3.containsMouse?backgroud:backgroud_seleted
                MouseArea{
                    id:am3
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        openDialog(0)
                    }
                }
            }
            DDNCommon.DDNButton{
                text: "+创建钱包地址"
                width: 120
                height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                btnColor: !am2.containsMouse?backgroud:backgroud_seleted
                MouseArea{
                    id:am2
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        openDialog(1)
                    }
                }
            }
        }
        Item{
            width: parent.width
            height: 40
            DDNCommon.DDText{
                id:defaultId
                text: "默认钱包:"
                horizontalAlignment: Text.AlignLeft
                width: 100
                height: parent.height
                anchors.left:parent.left
            }
            DDNCommon.DDComboBox{
                id: control
                model: ["DHF3tqAsmSKzK2g2MMgAxVTH","ADHF3tqAsmNbfw2MMgAxVTH"
                ,"CCDHF3tqAsmNbfw2MMgAxVTH"]
                anchors.left:defaultId.right
                anchors.right: addressId.left
                anchors.rightMargin: 20
                height: parent.height
                addIcon:false
                onActivated: {
                    //if(control.displayText == currentText)return;
                    control.displayText = currentText;
                    signalAddressChanged(currentText)
                }
            }
            DDNCommon.DDNButton{
                id:addressId
                text: "+导入钱包地址"
                width: 120
                height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                btnColor: !am.containsMouse?backgroud:backgroud_seleted
                MouseArea{
                    id:am
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        openDialog(2)
                    }
                }
            }
        }
    }
}
