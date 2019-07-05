import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import DDui.ddn 1.0
import "./../../../common/style" as DDNStyle
import "./../../../common/" as Common
import HttpClient 1.0

DDNStyle.DDTableStyleView {
    id:roowView
    property int scrollbarWidth : 10
    signal signalHeightClicked(int height);
    signal signalAddressClicked(string address)
    signal signalCommonToBlocksPage(int type,var values);
    itemDelegate: DDNStyle.DDTableTextItem{
        id:txtItem
        styleDatas:styleData
        handStylelist: [0,1,5,6]
        handTipslist: ["发文字号","fwgg","发布时间","fbjgmc","标题","分类","fwjg","scrq","ztfl","gwzl"]
        myTxtColor:txtItem.colorIndex(styleData.column,styleData.seleted)
        onSignalTextClicked: {
            console.log("click in trans "+address)
            if(idx == 1){
                signalHeightClicked(address)
            }else if(idx == 6){
                signalAddressClicked(address)
            }
            DDTextImpWidth.signalCommonToBlocksPage("trans","block",idx,address);
        }
    }
    rowDelegate: DDNStyle.DDRowDelegate{
        height:80
    }
    headerDelegate: DDNStyle.DDHeaderStyle{
        headerText: styleData.value
        columnIndx:styleData.column
    }
    TableViewColumn {
        id:checkedColumn
        role: "wh"
        title: "发文字号"
        width: roowView.width/10
    }
    TableViewColumn {
        id:comBoxId
        role: "fwgg"
        title: "简函类型"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "publishTime"
        title: "发布时间"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "fbjgmc"
        title: "部门"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "title"
        title: "内容"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "subjectName"
        title: "分类"
        width: roowView.width/10
    }

    TableViewColumn {
        role: "fwjg"
        title: "机关"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "scrq"
        title: "成文日期"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "ztfl"
        title: "安全生产"
        width: roowView.width/10
    }
    TableViewColumn {
        role: "gwzl"
        title: "通知"
        width: roowView.width/10
    }
    model: mMsgModel
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.transactions;
        for(var i=0;i<dataArr.length;i++){
            mTransModel.addObject(dataArr[i]);
        }
    }
    HttpClient{
        id:httpobj
        onSignalDataResult: {

        }
    }
    onVisibleChanged: {
        if(visible){
            httpobj.requestAllgdnpsData(1,20);
        }
    }
}
