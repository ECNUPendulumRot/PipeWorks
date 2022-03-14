import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0

Rectangle {
    id: control
    width: 165
    height: 30
    color: "#00ffffff"
    property alias textFieldAnchorsleftMargin: textField.anchors.leftMargin
    property alias textFieldWidth: textField.width
    property alias textFieldText: textField.text
    property alias textFieldColor: textField.color
    property alias labelText: label.text
    property alias editEnabled: control.enabled

    property string type : "editable"
    property string mapString

    signal dataChanged(string s, var text)

    Label {
        id: label
        x: 8
        color: "#808080"
        text: qsTr("M4值")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.verticalCenterOffset: 0
    }

    FixedTextField {
        id: textField
        y: -54
        width: 100
        height: 16

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: label.left
        font.pixelSize: 12
        anchors.leftMargin: 45

        anchors.verticalCenterOffset: 0

        layer.enabled: true

        onAccepted: {
            textField.focus = false
            control.dataChanged(control.mapString, textField.text)
        }
    }
}

/*##^##
Designer {
    D{i:0;height:30;width:165}D{i:1}D{i:2}
}
##^##*/

