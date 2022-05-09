import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 42
    height: 28

    leftPadding: 4
    rightPadding: 4

    checkable: true
    checked: true
    display: AbstractButton.IconOnly

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        implicitWidth: 66
        implicitHeight: 28
        radius: 4
        border.color: "#d3d3d3"
        border.width: 1
        anchors.fill: parent
        layer.enabled: true
        layer.effect: DropShadowEffect {
            color: "#2d000000"
            radius: 8
            samples: 17
            spread: 0
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    Image {
        id: unlock
        anchors.centerIn: control
        width: 26
        height: 18
        source: control.checked ? "../../images/lock.png" : "../../images/unlock.png"
        fillMode: Image.PreserveAspectFit
    }
    states: [
        State {
            name: "hover"
            when: control.hovered && !control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#f2f2f2"
            }
        },

        State {
            name: "press"
            when: control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#d2d2d2"
            }
        }
    ]
}
