import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 120
    height: 30

    leftPadding: 4
    rightPadding: 4

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e3e3e3"

        opacity: enabled ? 1 : 0.3
        radius: 8
        border.color: "#d3d3d3"
        border.width: 1
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            radius: 8
            verticalOffset: 0
            horizontalOffset: 0
            color: "#52000000"
        }
    }

    contentItem: textItem
    Text {
        id: textItem

        leftPadding: 30
        opacity: enabled ? 1.0 : 0.3
        color: "#000000"
        text: "撤销修改"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        z: 0
    }

    Image {
        id: image
        y: 15
        width: 18
        height: 18
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        source: "../../images/Reset.png"
        anchors.leftMargin: 10
        antialiasing: true
        mipmap: true
        fillMode: Image.PreserveAspectFit
    }

    states: [
        State {
            name: "press"
            when: control.pressed
            PropertyChanges {
                target: buttonBackground
                color: "#d2d2d2"
                border.color: "#d3d3d3"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:30;width:120}D{i:1}D{i:3}D{i:4}
}
##^##*/

