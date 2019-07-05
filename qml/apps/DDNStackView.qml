import QtQuick 2.0
import QtQml.Models 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import DDui.ddn 1.0
import DDui.style 1.0
import "./../apps/blockchain" as DDNPage
import "./../js/ddnobj.js" as DDNJs

TabView {
    id: tabView
    Tab {
        title: "区块高度浏览"
        DDNPage.DDNMain{
            id:blockVId
            anchors.fill: parent
        }
    }
    Tab {
        title: "Red"
    }
    Tab {
        title: "Blue"
    }
    Tab {
        title: "Green"
    }
    Tab {
        title: "Green"
    }
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
        switch(index){
        case 0:{
            tabView.currentIndex = index;
            return;
        }
        case 1:{
            qmlfile= "qrc:/qml/apps/market/DDNMarketView.qml"
            createTabSourcecomp(qmlfile,index);
        }break;
        case 2:{
            qmlfile= "qrc:/qml/apps/wallet/DDNWalletView.qml"
            createTabSourcecomp(qmlfile,index);
        }break;
        case 3:{
            qmlfile= "qrc:/qml/apps/help/DDNMessageView.qml"
            createTabSourcecomp(qmlfile,index);
        }break;
        case 4:{
            qmlfile= "qrc:/qml/apps/help/DDNHelperView.qml"
            createTabSourcecomp(qmlfile,index);
        }break;
        }
        console.log("-------------add Index Tab: "+index)
        tabView.currentIndex = index;
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
    Connections{
        target: DDTextImpWidth
    }
}
