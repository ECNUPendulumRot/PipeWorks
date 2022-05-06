import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 100
    height: 30

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    text: "My Button"
    font.pixelSize: 14

    property alias coverColor: cover.color
    property alias textItemColor: textItem.color
    property alias buttonBackgroundBordercolor: buttonBackground.border.color
    property alias buttonBackgroundColor: buttonBackground.color

    state: ""
    activeFocusOnTab: false
    background: buttonBackground
    Rectangle {
        id: buttonBackground
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: "#e7e7e7"
        radius: 4
        border.color: "#000000"
        border.width: 0
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            color: "#29000000"
            radius: 8
            samples: 17
            verticalOffset: 0
            horizontalOffset: 0
            spread: 0.1
        }

        Rectangle {
            id: cover
            color: "#00393939"
            radius: buttonBackground.radius
            border.width: 0
            anchors.fill: parent
        }
    }

    contentItem: textItem
    Text {
        id: textItem

        opacity: enabled ? 1.0 : 0.3
        color: "#202020"
        text: control.text
        font.family: "Microsoft Yahei"
        font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    states: [
        State {
            name: "hover"
            when: !control.pressed && control.hovered

            PropertyChanges {
                target: cover
                color: "#3a959595"
            }
        },
        State {
            name: "press"
            when: control.pressed

            PropertyChanges {
                target: cover
                color: "#7a959595"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5;height:30;width:100}
}
##^##*/

