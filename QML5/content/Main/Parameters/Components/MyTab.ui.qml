import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control
    width: 100

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    text: "前焊枪水平运动"
    property alias textItemFontpixelSize: textItem.font.pixelSize

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#c1c1c1"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 0
        border.color: "#00000000"
        border.width: 0
    }

    contentItem: textItem
    Text {
        id: textItem
        text: control.text
        font.pixelSize: 12

        opacity: enabled ? 1.0 : 0.3
        color: "#808080"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    states: [
        State {
            name: "press"
            when: control.pressed
            PropertyChanges {
                target: buttonBackground
                color: "#808080"
                border.color: "#00000000"
            }

            PropertyChanges {
                target: textItem
                color: "#ebebeb"
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        },
        State {
            name: "down"
            when: control.checked
            PropertyChanges {
                target: textItem
                color: "#202020"
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            PropertyChanges {
                target: buttonBackground
                color: "#ebebeb"
                border.color: "#00000000"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:40;width:100}
}
##^##*/

