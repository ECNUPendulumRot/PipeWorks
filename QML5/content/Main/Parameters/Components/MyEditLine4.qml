import QtQuick 2.15
import QtQuick.Controls 2.15
//import MotionControl
import QtQuick.Studio.Components 1.0
import QtQuick.Layouts 1.0
import QtQuick.Studio.Effects 1.0
import "../../../../../QML5/imports/QML5"
Rectangle {
    id: control
    width: 295
    height: 30
    color: "#00ffffff"
    border.color: "#ffffff"
    border.width: 0
    property alias textFieldAnchorsleftMargin: textField.anchors.leftMargin
    property alias label12AnchorsleftMargin: label12.anchors.leftMargin
    property alias textFieldWidth: textField.width
    property alias textFieldText: textField.text
    property alias textFieldColor: textField.color
    property alias label12Text: label12.text
    property alias label11Text: label11.text
    property alias editEnabled: control.enabled

    property string type : "editable"
    property string mapString

    signal dataChanged(string s, var text)

    Label {
        id: label11
        x: 5
        color: Constants.tableFontColor
        text: qsTr("手动送丝百分比")
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
        anchors.left: label11.left
        font.pixelSize: 12
        anchors.leftMargin: 105

        anchors.verticalCenterOffset: 0

        onAccepted: {
            textField.focus = false
            control.dataChanged(control. mapString, textField.text)
        }
    }

    Label {
        id: label12
        width: 70
        height: 18
        color: Constants.tableFontColor
        text: qsTr("%")
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



