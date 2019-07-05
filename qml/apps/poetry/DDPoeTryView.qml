import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../core" as DDCore

Rectangle{
    DDCore.DDTopBar {
        width: parent.width
        Layout.maximumHeight: 100
        Layout.minimumHeight: 100
        height: 100
        color: "#1e1e1e"
    }
    DDCore.DDBottomBar  {
        Layout.maximumHeight: 30
        Layout.minimumHeight: 30
        height: 30
        width: parent.width
        anchors.margins: 0
        anchors.bottom: parent.bottom
        color: "#1e1e1e"
    }
}
