import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.1
import "./core" as DDCore
import "./apps/blockchain" as BlockChain
import DDui.style 1.0

DDCore.DDAbstractView {
    id:driverUi
    visible: true
    width: 1280
    height: 680
    bgMarign:8
    DDCore.DDuiShadowBg {
        id:bg
        width: driverUi.width
        height: driverUi.height
        bgmarigns: driverUi.bgMarign
        BlockChain.DDNMain{
            color: "#0C111B"
            anchors.fill:  parent
            anchors.margins: driverUi.bgMarign
        }
    }
}
