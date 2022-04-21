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

    activeFocusOnTab: false

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 4
        anchors.fill: parent
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
        font.pixelSize: 14

        opacity: enabled ? 1.0 : 0.3
        color: "#202020"

        font.family:"Microsoft Yahei"

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter

    }

    states: [
        State {
            name: "pressed"
            when: control.pressed

            PropertyChanges {
                target: pressRec
                color: "#7a959595"
            }
        },
        State {
            name: "hover"
            when: control.hovered && !control.pressed

            PropertyChanges {
                target: pressRec
                color: "#3a959595"
            }
        }
    ]
}



/*##^##
Designer {
    D{i:0;height:24;width:70}D{i:3}D{i:1}D{i:4}
}
##^##*/

