import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 120
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

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#0d267b"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 8
        border.color: "#047eff"
        border.width: 0
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
        color: "#ffffff"
        text: "提交数据"
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Image {
        id: image
        width: 22
        height: 17
        anchors.verticalCenter: textItem.verticalCenter
        anchors.left: parent.left
        source: "../../images/Submit.png"
        antialiasing: true
        mipmap: true
        anchors.leftMargin: 10
        anchors.verticalCenterOffset: 0
        fillMode: Image.PreserveAspectFit
    }

    states: [
        State {
            name: "hover"
            when: control.hovered && !control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#122261"
                border.color: "#047eff"
            }

            PropertyChanges {
                target: textItem
                color: "#ffffff"
            }
        },
        State {
            name: "press"
            when: control.pressed
            PropertyChanges {
                target: textItem
                color: "#818ea7"
            }

            PropertyChanges {
                target: buttonBackground
                color: "#081750"
                border.color: "#00000000"
            }

            PropertyChanges {
                target: image
                opacity: 0.4
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33;height:40;width:100}D{i:1}D{i:3}D{i:4}
}
##^##*/

