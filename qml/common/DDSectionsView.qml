import QtQuick 2.0
import com.ddui.DDTextImpWidth 1.0

ListView {
    id:viewId
    anchors.fill: parent
    model: onlySectionsModel
    delegate: nameDelegate
    focus: true
    boundsBehavior: Flickable.StopAtBounds
    property string currentSetcion: "工商信息查询"
    property var imgArra: ["doc.png","ppt.png","xsl.png","pdf.png"]
    property bool onlyExpand: true
    property bool useAnimation: true
    property ListModel onlySectionsModel
    property var txtColorArr: ["#1E88E5","#99ABB4"]
    property var bgColorArr: ["#1E88E5","#99ABB4"]
    property int sectionFontSize: 16
    property int sectionHeight: 40
    property int sectionDuration: 400
    property int sectionRadius: 4

    Component {
        id: nameDelegate
        Rectangle{
            width:viewId.width
            height: canVisible?sectionHeight-6:0
            visible: canVisible
            color: txtMa.containsMouse?bgColorArr[0]:"transparent"
            Behavior on height {
                enabled: useAnimation
                NumberAnimation { duration: sectionDuration+100 }
            }
            Behavior on visible {
                enabled: useAnimation
                NumberAnimation { duration: sectionDuration }
            }
            DDTextItem {
                id:textItem
                text: name;
                font.pixelSize: sectionFontSize-2
                width:viewId.width-60
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignLeft
                height:parent.height
                visible: parent.visible
                color: txtColorArr[0]
            }
            DDImage {
                id: expandId
                source: DDTextImpWidth.imageAbsPath("delete.png")
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea{
                id:txtMa
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    textItem.color = txtColorArr[0]
                }
                onExited: {
                    textItem.color = txtColorArr[1]
                }
                onClicked: {
                    console.log("clicke text is :"+name)
                }
            }
        }
    }
    section {
        property: "team"
        criteria: ViewSection.FullString
        delegate: Item{
            id:itemId
            width: parent.width
            height: sectionHeight
            property bool isExpand: true
            Rectangle {
                id:sectionRect
                color: (currentSetcion == section)?bgColorArr[0]:bgColorArr[0]
                radius: sectionRadius
                anchors.fill: parent
                anchors.margins: 1
                DDImage {
                    id: expandId2
                    source: getSectionIcon(section)
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
                DDTextItem {
                    id:sectionText
                    font.pixelSize: sectionFontSize
                    text: section
                    width:viewId.width-60
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignLeft
                    height: parent.height
                    color:  (currentSetcion != section)?(deleteMa.containsMouse?txtColorArr[0]:txtColorArr[1]):"#FFFFFF"
                }
               DDImage {
                    id: expandId
                    source: DDTextImpWidth.imageAbsPath("back_normal.png")
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    states: [
                        State {
                            name: "rotated"
                            PropertyChanges { target: expandId; rotation: -90}
                        },State {
                            name: "normal"
                            PropertyChanges {
                                target: expandId
                                rotation: 0
                            }
                        }
                    ]
                    transitions: Transition {
                        RotationAnimation { duration: 300; direction: RotationAnimation.Numerical }
                    }
                    state:(currentSetcion == section && itemId.isExpand )?"rotated":"normal"
                }
                MouseArea{
                    id:deleteMa
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        currentSetcion = section;
                        if(onlyExpand){
                            itemId.isExpand = updateSections(section,true);
                        }else{
                            itemId.isExpand = updateOnlySection(section);
                        }
                        // console.log("--------111---------"+section+ "expand "+itemId.isExpand);
                    }
                }
            }
        }
    }
//    Component.onCompleted: {
//        updateSections("工商信息查询",true);
//    }
    function updateSections(section,expand){
        var visb  = false;
        for(var i = 0;i<onlySectionsModel.count;i++){
            if(onlySectionsModel.get(i).team == section){
                //console.log("find this sections");
                visb = onlySectionsModel.get(i).canVisible;
                onlySectionsModel.setProperty(i,"canVisible",!visb);
            }else{
                onlySectionsModel.setProperty(i,"canVisible",!expand);
            }
        }
        return !visb;
    }
    function updateOnlySection(section){
        var visb  = false;
        for(var i = 0;i<onlySectionsModel.count;i++){
            if(onlySectionsModel.get(i).team == section){
                //console.log("find this sections");
                visb = onlySectionsModel.get(i).canVisible;
                onlySectionsModel.setProperty(i,"canVisible",!visb);
            }
        }
        return !visb;
    }
    function getSectionIcon(section){
        switch(section){
        case "工商信息查询":
            return DDTextImpWidth.imageAbsPath(imgArra[0]);
        case "Qt大佬组":
            return DDTextImpWidth.imageAbsPath(imgArra[1]);
        case "信息查询":
            return DDTextImpWidth.imageAbsPath(imgArra[2]);
        case "裁判文书查询":
            return DDTextImpWidth.imageAbsPath(imgArra[3]);
        }
    }
}
