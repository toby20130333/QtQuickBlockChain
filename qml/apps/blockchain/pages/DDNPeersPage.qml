import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "./../../../common/style" as DDNStyle


DDNStyle.DDTableStyleView {
    id:roowView
    property int scrollbarWidth : 10
    Connections {
        target: ddnObject
        onSignalData: {
            if(json!="" && type == 6){
                console.log("The trans data changed!")
                roowView.setModel(json)
            }
        }
    }
    itemDelegate: DDNStyle.DDTableTextItem{
        id:txtItem
        styleDatas:styleData
        handStylelist: []
        myTxtColor:txtItem.colorIndex(styleData.column,styleData.seleted)
    }
    rowDelegate: DDNStyle.DDRowDelegate{
        height:40
    }
    headerDelegate: DDNStyle.DDHeaderStyle{
        headerText: styleData.value
        columnIndx:styleData.column
    }
    TableViewColumn {
        id:checkedColumn
        role: "ip"
        title: "节点IP"
        width: roowView.width/5
    }
    TableViewColumn {
        id:comBoxId
        role: "port"
        title: "端口"
        width: roowView.width/5
    }
    TableViewColumn {
        role: "status"
        title: "运行状态"
        width: roowView.width/5
    }
    TableViewColumn {
        role: "os"
        title: "操作系统"
        width: roowView.width/5
    }
    TableViewColumn {
        role: "version"
        title: "区块链版本"
        width: roowView.width/5-10
    }
    model: mPeersModel
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.peers;
        for(var i=0;i<dataArr.length;i++){
            mPeersModel.addObject(dataArr[i]);
        }
    }
}
