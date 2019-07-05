import QtQuick 2.1
import QtQuick.Window 2.1
import "../../core" as DDCore
import "../../js/ddnobj.js" as DDJs

DDCore.DDAbstractView {
    id:driverUi
    visible: true
    width: 370
    height: 550
    bgMarign:8
    property var ddnItem
    //max and normal window states
    function transToQml(showMax){
        if(showMax){
            bgMarign = 0;
        }else{
            bgMarign = 8;
        }
        ddnItem.anchors.margins=bgMarign;
    }
    DDCore.DDuiShadowBg{
        id:bg
        width: driverUi.width
        height: driverUi.height
        bgmarigns: driverUi.bgMarign
        DDPoeLoginView{
            id:loginUi
            color: backgroud
            anchors.fill:  parent
            anchors.margins: driverUi.bgMarign
        }
    }
    function changePageToDDN(){
        loginUi.visible = false;
        ddnItem = DDJs.createqmlObjects(bg,"qrc:/qml/apps/blockchain/DDNVerMain.qml",bgMarign);
        driverUi.width= 1280
        driverUi.height= 680
        driverUi.bgMarign=8
        ddnItem.anchors.margins=bgMarign;
        signalNotifyToUi(updaterVersion);
        signalTransQmlToOther("resize",[1280,680]);
    }
}
