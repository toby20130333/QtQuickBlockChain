import QtQuick 2.0
import "../../../common" as Common
import "../../poetry/" as Poetry

Common.DDRectangle {
    id:rootPopUp
    signal signalClosePopUpWindow2()
    DDNWalletNewAddressTopBar{
        id:topBar
        width: parent.width
        height: 100
        onSignalClosePopUpWindow: {
            signalClosePopUpWindow2()
        }
    }
    Rectangle{
        id:rootNav
        anchors.top: topBar.bottom
        anchors.topMargin: 0
        width: parent.width
        height: 40
        color: backgroud
        ListView{
            id:lineView
            anchors.fill: parent
            anchors.leftMargin: 30
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            boundsBehavior: Flickable.StopAtBounds
            interactive: false
            delegate: Common.DDNavIconText{
                width: (index == 3)?100:lineView.width/3
                height: 30
                isReached: iisReached
                iText: iiText
                iNum: iiNum
                isTheLast: iisTheLast
            }
            orientation:ListView.Horizontal
            model: ListModel{
                id:accountModel
            }
        }
    }
    DDNNewAddressPage{
        anchors.top: rootNav.bottom
        anchors.topMargin: 0
        width: parent.width
        anchors.bottom: parent.bottom
    }
    function updateStepFlags(step){
        for(var i = 0;i<accountModel.count;i++){
            if(accountModel.get(i).iiNum == step+1){
                accountModel.setProperty(i,"iisReached",true);
            }else{
                accountModel.setProperty(i,"iisReached",false);
            }
        }
    }
    Component.onCompleted: {
        accountModel.append({"iisReached":true,"iiText": "生成主密钥",
                                "iiNum": 1,"iisTheLast": false
                            });
        accountModel.append({"iisReached": false,"iiText": "验证主密钥",
                                "iiNum": 2,"iisTheLast": false
                            });
        accountModel.append({"iisReached": false,"iiText": "绑定地址",
                                "iiNum": 3,"iisTheLast": true
                            });
    }
}
