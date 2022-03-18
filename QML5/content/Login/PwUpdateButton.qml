import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0




Button {
    id: control

    leftPadding: 4
    rightPadding: 4

    display: AbstractButton.IconOnly
    property alias textItemText: textItem.text
    width: 100
    height: 30
    Text {
        id: textItem
        color: "#808080"
        text: "修改密码"
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        z: 1
        textFormat: Text.RichText
        font.weight: Font.Medium
        font.pixelSize: 16
    }

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 8
        border.color: "#e7e7e7"
        anchors.fill: parent
        z: 0
    }
    states: [
        State {
            name: "hover"
            when: (control.hovered && !control.pressed) || control.activeFocus

            PropertyChanges {
                target: textItem
                color: "#2b2ed9"
            }
        }

    ]

}




/*##^##
Designer {
    D{i:0;height:50;width:140}D{i:1}D{i:2}
}
##^##*/

