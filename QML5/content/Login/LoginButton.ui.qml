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
        font.family: "Microsoft Yahei"
    }

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#1c76c2"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 8
        border.color: "#1c76c2"
        anchors.fill: parent
        z: 0
    }
    states: [
        State {
            name: "hover"
            when: (control.hovered && !control.pressed) || control.activeFocus

            PropertyChanges {
                target: buttonBackground
                color: "#4c8fc7"
                border.color: "#045ba4"
                border.width: 3
            }
        },
        State {
            name: "pressed"
            when: control.pressed

            PropertyChanges {
                target: textItem
                color: "#b0b0b0"
            }

            PropertyChanges {
                target: buttonBackground
                color: "#1c76c2"
                border.color: "#d1d1d1"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:50;width:140}
}
##^##*/

