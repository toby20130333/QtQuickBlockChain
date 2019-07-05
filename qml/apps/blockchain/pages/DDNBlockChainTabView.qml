import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import DDui.ddn 1.0
import "../../../js/ddnobj.js" as DDNJs
import DDui.style 1.0
import "./../../../common" as Common

TabView {
    id: tabView
    Connections {
        target: ddnObject
        onSignalData: {
            if(json!="" && type == 0){
                console.log("The blocksview data changed!",type)
                tabView.setModel(json)
            }
        }
    }
    Tab {
        title: "区块高度浏览"
        DDNTableView{
            id:blocksView
            anchors.fill: parent
            anchors.margins: 1
            onSignalAddressClicked: {
                //请求高度的详细信息
               initAddressPage(address);
            }
            onSignalHeightClicked: {
                //根据地址查询区块某高度的信息
                initHeightPage(height)
            }
        }
    }
    style: TabViewStyle {
        frameOverlap: 1
        frame: Rectangle {
            color:backgroud
            border.color: backgroud_seleted
        }
        tab: Rectangle {
            color: !styleData.selected ? backgroud
                                      :backgroud_seleted
            implicitWidth: Math.max(DDTextImpWidth.getWidth(text.text,text.font.pixelSize) + 34, 100)
            implicitHeight: 35
            Rectangle { height: 1 ; width: parent.width ; color: backgroud_seleted}
            Rectangle { height: parent.height ; width: 1; color: backgroud_seleted}
            Rectangle { x: parent.width -1; height: parent.height ; width: 1; color: backgroud_seleted}
            Common.DDText  {
                id: text
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                text: styleData.title
                anchors.fill: parent
                color: !styleData.selected ?seleted_color
                                           :text_color
            }
            Rectangle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -4
                anchors.rightMargin: 1
                implicitWidth: 16
                implicitHeight: 16
                radius: width/2
                color: control.hovered ? "#eee": "#00ffffff"
                border.color: control.hovered ?"gray":"#00ffffff"
                Image { id:closeImg;anchors.centerIn: parent ; source: ""}
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        closeImg.source =(styleData.index==0)?"":DDTextImpWidth.imageAbsPath("delete.png")
                    }
                    onExited: {
                        closeImg.source = "";
                    }
                    onClicked: {
                        if(styleData.index==0)return;
                        tabView.removeTab(styleData.index);
                    }
                }
            }
        }
    }
    function initAddressPage(address){
        //qrc:/qml/apps/blockchain/pages/DDNAddressView.qml
        createTab("某账号信息","qrc:/qml/apps/blockchain/pages/DDNAddressView.qml")
        ddnObject.requestDDNAccountsDetails(address);
    }
    function initHeightPage(height){
        createTab("区块某高度","qrc:/qml/apps/blockchain/pages/DDNHeightView.qml");
        ddnObject.requestDDNBlockDetails(height);
    }
    function initTransDetailsPage(transId){
        createTab("区块某交易","qrc:/qml/apps/blockchain/pages/DDNTransDetalsPage.qml");
        ddnObject.requestDDNTransDetails(transId);
    }

    function createTab(title,qmlfile){
        if(findThisTitle(title)){
            console.log("ffffffffind it ");
            return;
        }
        var cmpObj = DDNJs.createSpriteObjects(tabView,qmlfile);
        tabView.insertTab(tabView.count,title,cmpObj);
        tabView.currentIndex = tabView.count-1;
        var tabObj = tabView.getTab(tabView.count-1);
        if(tabObj){
            console.log(" tabObj "+tabObj.item)
            //tabObj.item.expandFirst(0);
        }
    }
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.blocks;
        for(var i=0;i<dataArr.length;i++){
            mTableModel.addObject(dataArr[i]);
        }
    }
    function findThisTitle(title){
        for(var i = 0;i< tabView.count;i++){
            if(tabView.getTab(i).title == title){
                console.log(" found this idx ",i);
                tabView.currentIndex = i;
                return true;
            }
        }
        return false;
    }
}
