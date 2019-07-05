import QtQuick 2.0
import QtQml.Models 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import DDui.ddn 1.0
import DDui.style 1.0
import "./../../js/ddnobj.js" as DDNJs

TabView {
    id: tabView
    property var qmlArray: ["qrc:/qml/apps/market/DDNMarketView.qml",
    "qrc:/qml/apps/wallet/DDNWalletView.qml","qrc:/qml/apps/help/DDNMessageView.qml"]
    style: TabViewStyle {
        frameOverlap: 1
        frame: Rectangle {
            color: backgroud
        }
        tab: Rectangle{
            height: 0
            visible: false
        }
    }
    function createObjBYTab(index){
        var qmlfile;
        var obj;
        var itemTab;
//        if(index == 0){
//            tabView.currentIndex = index;
//            return;
//        }
        if(index >=qmlArray.length)return;
        qmlfile= qmlArray[index]
        console.log("qml file path "+qmlfile,index);
        createTabSourcecomp(qmlfile,index);
        console.log("------stackedpage-------add Index Tab: "+index)
        tabView.currentIndex = index;
        return;
    }
    function findIndex(index){
        var obj = tabView.getTab(index);
        console.log("found obj "+obj);
        if(obj === undefined){
            return false;
        }
        return true;
    }
    function createTabSourcecomp(qmlfile,index){
        var itemTab =  tabView.getTab(index);
        if(itemTab.sourceComponent == undefined){
           var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
            itemTab.sourceComponent = obj;
            console.log("this tab is empty "+index)
        }
    }
}
