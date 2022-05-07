import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 42
    height: 28

    leftPadding: 4
    rightPadding: 4

    display: AbstractButton.IconOnly

    background: buttonBackground

    contentItem: icon
    property alias iconSource: icon.source

    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        implicitWidth: 66
        implicitHeight: 28
        opacity: enabled ? 1 : 0.3
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
        id: icon
        width: 34
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "../../images/zoomIn.png"
        smooth: true
        cache: true
        sourceSize.height: 50
        sourceSize.width: 50
        anchors.horizontalCenter: parent.horizontalCenter
        antialiasing: false
        mipmap: false
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

/*##^##
Designer {
    D{i:0;formeditorZoom:8}D{i:2}
}
##^##*/

