import QtQuick 2.15
import QtQuick.Controls 2.15
//import MotionControl
import QtQuick.Studio.Components 1.0
import QtQuick.Layouts 1.0

Rectangle {
    id: rectangle8
    width: 662
    height: 231
    color: "#00ffffff"
    border.color: "#808080"
    border.width: 1
    property alias label4FontpixelSize: label4.font.pixelSize
    antialiasing: true
    property alias rectangle9Color: rectangle9.color
    property alias label4Color: label4.color
    property alias rectangle9X: rectangle9.x
    property alias label4Text: label4.text
    Rectangle {
        id: rectangle9
        x: 41
        y: -9
        width: label4.width + 10
        height: label4.height + 4
        color: "#ebebeb"
        border.color: "#00000000"
        Label {
            id: label4
            color: "#808080"
            text: qsTr("小车参数")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 13
            font.family: "Microsoft Yahei"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

/*##^##
Designer {
    D{i:0;height:132;width:165}
}
##^##*/

