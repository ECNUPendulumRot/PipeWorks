import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control
    width: 150
    height: 50

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    text: "My Button"
    property alias textItemLeftPadding: textItem.leftPadding
    property alias textItemHorizontalAlignment: textItem.horizontalAlignment
    property alias buttonBackgroundRadius: buttonBackground.radius

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00000000"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 2
        border.color: "#047eff"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
    }

    contentItem: textItem
    Text {
        id: textItem
        text: control.text
        anchors.fill: parent

        opacity: enabled ? 1.0 : 0.3
        color: "#000000"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.Medium
        font.pixelSize: 12
    }
    states: [
        State {
            name: "pressed"
            when: control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#afd3d3d3"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:30;width:128}
}
##^##*/

