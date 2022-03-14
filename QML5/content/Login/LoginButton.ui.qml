import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    text: "My Button"
    display: AbstractButton.IconOnly
    property alias textItemText: textItem.text
    width: 140
    height: 50

    Text {
        id: textItem

        opacity: enabled ? 1.0 : 0.3
        color: "#ffffff"
        text: control.text
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        z: 1
        textFormat: Text.RichText
        font.weight: Font.Medium
        font.pixelSize: 16
    }

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#b0b0b0"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 8
        border.color: "#707070"
        anchors.fill: parent
        z: 0
    }
    states: [
        State {
            name: "State1"
            when: control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#757575"
                border.color: "#5b5b5b"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:50;width:140}D{i:1}D{i:2}
}
##^##*/

