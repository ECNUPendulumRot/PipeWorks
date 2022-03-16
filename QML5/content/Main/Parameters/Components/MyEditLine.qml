import QtQuick 2.15
import QtQuick.Controls 2.15
//import MotionControl
import QtQuick.Studio.Components 1.0
import QtQuick.Studio.Effects 1.0
import "../../../../../QML5/imports/QML5"
Rectangle {
    id: control
    enabled: true
    x: 496
    y: 538
    width: 260
    height: 30
    color: "#00202020"
    border.color: "#ffffff"
    border.width: 0
    property alias textFieldRectangle1Color: textField.rectangle1Color
    property alias textFieldAnchorsleftMargin: textField.anchors.leftMargin
    property alias textFieldWidth: textField.width
    property alias textFieldText: textField.text
    property alias textFieldColor: textField.color
    property alias label1AnchorsleftMargin: label1.anchors.leftMargin
    property alias label1Text: label1.text
    property alias labelText: label.text
    property alias editEnabled: control.enabled

    property string mapString


    property string type : "editable"

    signal dataChanged(string s, var text)

    Label {
        id: label
        x: 5
        color: Constants.tableFontColor
        text: qsTr("运动减速度")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
    }

    FixedTextField {
        id: textField
        width: 80
        height: 16
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: label.left
        font.pixelSize: 12
        rectangle1Color: "#ffffff"
        anchors.leftMargin: 70
        anchors.verticalCenterOffset: 0

        onAccepted: {
            textField.focus = false
            control.dataChanged(control.mapString, textField.text);
        }
    }

    Label {
        id: label1
        width: 65
        height: 48
        color: Constants.tableFontColor
        text: qsTr("毫米/秒<sup>2<sup>")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: textField.left
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.leftMargin: 90
        textFormat: Text.RichText
    }
    function clear(){
        textField.text=""
    }
}




/*##^##
Designer {
    D{i:0;height:30;width:260}D{i:1}D{i:2}D{i:3}
}
##^##*/
