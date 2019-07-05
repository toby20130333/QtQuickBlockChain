import QtQuick 2.0
import QtQml.Models 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import DDui.ddn 1.0
import DDui.style 1.0

import "./../../../js/ddnobj.js" as DDNJs

TabView {
    id: tabView
    Tab {
        title: "区块高度浏览"
        DDNBlockChainTabView{
            id:blocksView
            anchors.fill: parent
            width: tabView.width
            height: tabView.height
            Component.onCompleted: {
                ddnObject.requestDDNBlocksData(0,20,"height:desc",false);
            }
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
    function createObj(index){
        if(findIndex(index)){
            tabView.currentIndex = index;
            return;
        }
        var qmlfile;
        switch(index){
        case 0:{
            tabView.currentIndex = index;
            ddnObject.requestDDNBlocksData(0,20,"height:desc",false);
            return;
        }
        case 1:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNTransPage.qml"
            var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
            tabView.insertTab(index,"",obj);
            ddnObject.requestDDNTransactions(0,30);
        }break;
        case 2:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNPeersPage.qml"
            var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
            tabView.insertTab(index,"",obj);
            ddnObject.requestDDNPeers(0,20);
        }break;
        case 3:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNAccountPage.qml"
            var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
            tabView.insertTab(index,"",obj);
            ddnObject.requestDDNAccounts(0,30)
        }break;
        case 4:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNDelegaterPage.qml"
            var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
            ddnObject.requestDDNDelegates(0,30)
            tabView.insertTab(index,"",obj);
        }break;
        case 5:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNMsgPage.qml"
            var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
            ddnObject.requestDDNDelegates(0,30)
            tabView.insertTab(index,"",obj);
        }break;
        }
        console.log("-------------add Index Tab: "+index)
        tabView.currentIndex = index;
    }

    function createObjBYTab(index){
        var qmlfile;
        var obj;
        var itemTab;
        switch(index){
        case 0:{
            tabView.currentIndex = index;
            ddnObject.requestDDNBlocksData(0,30,"height:desc",false);
            return;
        }
        case 1:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNTransPage.qml"
            createTabSourcecomp(qmlfile,index);
            ddnObject.requestDDNTransactions(0,30);
        }break;
        case 2:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNPeersPage.qml"
            createTabSourcecomp(qmlfile,index);
            ddnObject.requestDDNPeers(0,20);
        }break;
        case 3:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNAccountPage.qml"
            createTabSourcecomp(qmlfile,index);
            ddnObject.requestDDNAccounts(0,30)
        }break;
        case 4:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNDelegaterPage.qml"
            createTabSourcecomp(qmlfile,index);
            ddnObject.requestDDNDelegates(0,30)
        }break;
        case 5:{
            qmlfile= "qrc:/qml/apps/blockchain/pages/DDNMsgPage.qml"
            var obj = DDNJs.createSpriteObjects(tabView,qmlfile);
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
        onSignalCommonToBlocksPage: {
            console.log("CommonToBlocksPage-----from:"+from+" to: "+to+" type: "+type,"value "+value);
            if(to=="block"){
                tabView.currentIndex = 0;
                topBar.setCurrentBtn(0)
                if(type == 1){//height
                    tabView.getTab(0).item.initHeightPage(value);
                }else if(type == 6 || type == 5){
                    tabView.getTab(0).item.initAddressPage(value)
                }else if(type == 0){
                    tabView.getTab(0).item.initTransDetailsPage(value)
                }
            }
        }
    }
}
