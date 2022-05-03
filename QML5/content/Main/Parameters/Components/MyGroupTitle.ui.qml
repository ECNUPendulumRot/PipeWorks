import QtQuick 2.15
import QtQuick.Controls 2.15
//import MotionControl
import QtQuick.Studio.Components 1.0
import QtQuick.Layouts 1.0

Rectangle {
    id: rectangle
    width: 281
    height: 130
    color: "#00ffffff"
    border.color: "#808080"
    border.width: 1
    property alias rectangle1Color: rectangle1.color
    property alias labelFontpixelSize: label.font.pixelSize
    property alias labelColor: label.color
    property alias labelText: label.text

    Rectangle {
        id: rectangle1
        y: -9
        width: label.width + 10
        height: label.height + 4
        color: "#ebebeb"
        border.color: "#00000000"
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: label
            color: "#808080"
            text: qsTr("向外伸枪")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
            font.family: "Microsoft Yahei"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

/*##^##
Designer {
    D{i:0;height:360;width:352}
}
##^##*/
