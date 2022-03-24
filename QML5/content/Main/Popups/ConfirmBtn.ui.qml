import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 60
    height: 20

    leftPadding: 4
    rightPadding: 4

    text: "My Button"
    property alias pressRecColor: pressRec.color
    property alias textItemColor: textItem.color
    property alias buttonBackgroundColor: buttonBackground.color
    property alias cvisible: control.visible

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 4
        border.color: "#d3d3d3"
        anchors.fill: parent
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            color: "#29000000"
            radius: 16
            verticalOffset: 0
            horizontalOffset: 0
            spread: 0.1
        }

        Rectangle {
            id: pressRec
            color: "#00959595"
            anchors.fill: parent
        }
    }

    contentItem: textItem
    Text {
        id: textItem
        text: control.text
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 11

        opacity: enabled ? 1.0 : 0.3
        color: "#202020"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.weight: Font.Medium
        font.family: "Courier"
    }
    states: [
        State {
            name: "pressed"
            when: control.pressed

            PropertyChanges {
                target: pressRec
                color: "#7a959595"
            }
        }
    ]
}
