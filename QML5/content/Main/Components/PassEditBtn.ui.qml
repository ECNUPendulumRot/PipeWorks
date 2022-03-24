import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control
    width: 18
    height: 18

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    text: "My Button"
    property alias textItemFontpixelSize: textItem.font.pixelSize
    property alias textItemText: textItem.text
    property int pos
    property bool isCheck: false

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00000000"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 6
        border.color: "#6a6a6a"
    }

    contentItem: textItem
    Text {
        id: textItem

        opacity: enabled ? 1.0 : 0.3
        color: "#6a6a6a"
        text: "-"
        font.pixelSize: 23
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.Normal
    }

    states: [
        State {
            name: "hover"
            when: !checked && !control.down

            PropertyChanges {
                target: buttonBackground
                color: "#00000000"
                border.color: "#6a6a6a"
            }

            PropertyChanges {
                target: textItem
                color: "#6a6a6a"
            }
        },
        State {
            name: "press"
            when: !checked && control.down
            PropertyChanges {
                target: textItem
                color: "#dcdcdc"
            }

            PropertyChanges {
                target: buttonBackground
                color: "#6a6a6a"
                border.color: "#00000000"
            }
        },
        State {
            name: "check"
            when: checked && !control.down
            PropertyChanges {
                target: buttonBackground
                border.color: "#ffffff"
            }

            PropertyChanges {
                target: textItem
                color: "#ffffff"
            }
        },
        State {
            name: "checkPress"
            when: checked && control.down

            PropertyChanges {
                target: buttonBackground
                color: "#ffffff"
                border.color: "#8091C0"
            }

            PropertyChanges {
                target: textItem
                color: "#8091C0"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:18;width:18}
}
##^##*/

