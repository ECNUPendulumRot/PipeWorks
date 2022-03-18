import QtQuick 2.15
import QtQuick.Controls 2.12

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
    property alias wrapperColor: wrapper.color

    property alias textItemColor: textItem.color

    property alias buttonBackgroundBordercolor: buttonBackground.border.color
    width: 75
    height: 30

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00ffffff"
        implicitWidth: 80
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 4
        border.color: "#202020"
        border.width: 2
        anchors.fill: parent

        Rectangle {
            id: wrapper
            opacity: 0
            visible: true
            color: "#5f4df056"
            radius: 4
            border.width: 0
            anchors.fill: parent
        }
    }

    contentItem: textItem
    Text {
        id: textItem
        text: control.text
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 13

        opacity: enabled ? 1.0 : 0.3
        color: "#202020"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Courier"
    }
    states: [
        State {
            name: "hover"
            when: control.hovered && !control.pressed

            PropertyChanges {
                target: wrapper
                opacity: 0.304
            }
        },
        State {
            name: "press"
            when: control.pressed

            PropertyChanges {
                target: wrapper
                opacity: 1
            }
        }
    ]
}
