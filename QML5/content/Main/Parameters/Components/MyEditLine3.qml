import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components 1.0
import QtQuick.Studio.Effects 1.0
import "../../../../../QML5/imports/QML5"
Rectangle {
    id: control
    width: 295
    height: 30
    color: "#00ffffff"
    border.color: "#ffffff"
    border.width: 0
    property alias textFieldText: textField.text
    property alias textFieldColor: textField.color

    property alias textFieldAnchorsleftMargin: textField.anchors.leftMargin
    property alias label6AnchorsleftMargin: label6.anchors.leftMargin
    property alias textFieldWidth: textField.width
    property alias label6Text: label6.text
    property alias label5Text: label5.text
    property alias editEnabled: control.enabled

    property string type : "editable"
    property string mapString

    signal dataChanged(string s, var text)

    Label {
        id: label5
        x: 5
        color: Constants.tableFontColor
        text: qsTr("前后枪间距")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
    }

    FixedTextField {
        id: textField
        width: 100
        height: 16

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: label5.left
        font.pixelSize: 12

        anchors.leftMargin: 105

        anchors.verticalCenterOffset: 0

        onAccepted: {
            textField.focus = false
            control.dataChanged(control.mapString, textField.text);
        }
    }

    Label {
        id: label6
        width: 70
        height: 18
        color: Constants.tableFontColor
        text: qsTr("毫米")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: textField.left
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.leftMargin: 110
        textFormat: Text.RichText
    }
    function clear(){
        textField.text=""
    }
}

/*##^##
Designer {
    D{i:0;height:30;width:295}D{i:1}D{i:2}D{i:3}
}
##^##*/

