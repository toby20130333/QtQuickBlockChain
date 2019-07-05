import QtQuick 2.0
import "../../../common" as DDNCommon

DDNCommon.DDRectangle{
    signal signalClosePopUpWindow()
    color: backgroud
    DDNCommon.DDImgaeText{
        imageUrl:"qrc:/favicon.ico"
        bigText: "创建钱包地址"
        height: 65
        width: 200
        anchors.centerIn: parent
    }
    DDNCommon.DDCloseButton{
        id:close
        anchors.top: parent.top
        anchors.right: parent.right
        onSignalCloseThisPage: {
            signalClosePopUpWindow()
        }
    }
}
