import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../"

DDNStackedPage {
    id:rightPage
    qmlArray:["qrc:/qml/apps/wallet/dialog/DDNWalletStepOne.qml","qrc:/qml/apps/wallet/dialog/DDNWalletStepTwo.qml","qrc:/qml/apps/wallet/dialog/DDNWalletStepThree.qml"]
    Tab {
        DDNWalletStepOne{
            anchors.fill: parent
            onSignalToStepTwo: {
                rightPage.currentIndex = 1;
                rootPopUp.updateStepFlags(1);
            }
        }
    }
    Tab {
        DDNWalletStepTwo{
            anchors.fill: parent
            anchors.margins: 40
            onSignalToStepX: {
                if(isNext){
                    rightPage.currentIndex = 2;
                    rootPopUp.updateStepFlags(2);
                }else{
                    rightPage.currentIndex = 0;
                    rootPopUp.updateStepFlags(0);
                }
            }
        }
    }
    Tab {
        DDNWalletStepThree{
            anchors.fill: parent
            anchors.margins: 40
            onSignalToStepXX: {
                if(isNext){
                    console.log("check private key!!!!");
                    //rootPopUp.updateStepFlags(1);
                }else{
                    rightPage.currentIndex = 1;
                    rootPopUp.updateStepFlags(1);
                }
            }
        }
    }
}
