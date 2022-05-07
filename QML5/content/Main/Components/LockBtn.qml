import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 42
    height: 28

    leftPadding: 4
    rightPadding: 4

    hoverEnabled: true
    checked: true
    checkable: true
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
        x: 12
        y: 5
        width: 26
        height: 18
        opacity: 0
        source: "../../images/unlock.png"
        antialiasing: false
        mipmap: false
        fillMode: Image.Stretch
    }

    Image {
        id: lock
        width: 20
        height: 20
        visible: true
        anchors.verticalCenter: parent.verticalCenter
        source: "../../images/lock.png"
        antialiasing: false
        mipmap: false
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
    states: [
        State {
            name: "locked"
            when: control.checked

            PropertyChanges {
                target: lock
                opacity: 1
            }

            PropertyChanges {
                target: unlock
                opacity: 0
            }

            PropertyChanges {
                target: control
                checked: true
            }
        },
        State {
            name: "unlocked"
            when: !control.checked

            PropertyChanges {
                target: lock
                opacity: 0
            }

            PropertyChanges {
                target: unlock
                opacity: 1
            }

            PropertyChanges {
                target: control
                checked: false
            }
        },
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
