import QtQuick 2.1
import QtQuick.Window 2.1
import "../../core" as DDCore

DDCore.DDAbstractView {
    id:driverUi
    visible: true
    width: 816
    height: 600
    bgMarign:10
    DDCore.DDuiShadowBg{
        id:bg
        width: driverUi.width
        height: driverUi.height
        bgmarigns: driverUi.bgMarign
        DDPoeTryView{
            color: "#ffffff"
            anchors.fill:  parent
            anchors.margins: driverUi.bgMarign
        }
    }
}
