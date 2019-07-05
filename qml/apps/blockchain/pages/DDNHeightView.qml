import QtQuick 2.0
import QtQuick.Controls 1.4
import DDui.ddn 1.0
import "./../../../common/style" as DDNStyle
import "./../../../common/" as Common

Item {
    id:heightItem
    ScrollView{
        anchors.fill: parent
        style: Common.DDSideBarScrollView{}
        Column {
            Repeater {
                model: ListModel{
                    id:heightModel
                }
                DDNStyle.DDRowItem{
                    width: heightItem.width-10; height: 40
                    titleId: key
                    titleContents: value
                }
            }
        }
    }
    Connections {
        target: ddnObject
        onSignalData: {
            if(json!="" && type == 1){
                console.log("The height data changed!",type);
                heightModel.clear()
                setModel(json);
            }
        }
    }
    function setModel(json){
        var obj = JSON.parse(json); //由JSON字符串转换为JSON对象
        var ok = obj.success;
        if(!ok)return;
        var jsonObj = obj.block;
        for(var item in jsonObj){
            var jValue =jsonObj[item];//key所对应的value
            var values = jValue;
            if(isNumber(jValue)){
                if(item =="timestamp"){
                     values = DDTextImpWidth.getDateForString(jValue)
                }else if(item == "height"){
                    values = jValue+""
                }else if(item == "payloadLength"){
                    values = jValue+""
                }else{
                    values = jValue/100000000+"";
                }
                //console.log("found number : "+jValue);
            }else  if(isArray(jValue)){
                values = jValue[0];
            }else{
                //console.log("found Boolean : "+jValue);
                values =jValue+"";
            }
            heightModel.append({key:item,value:values});
        }
    }
    //判断是否为数字
    function isNumber(obj) {
        return typeof obj === 'number' && isFinite(obj)
    }
    //判断是否为数组
    function isArray(obj){
        return Object.prototype.toString.call(obj)=='[object Array]';
    }
}
