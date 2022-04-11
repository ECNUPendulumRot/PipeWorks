import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0
import "../../../../../QML5/imports/QML5"

TextField {
    id: textField
    width: 100
    height: 20
    color: "#000000"

    font.pixelSize: 14
    horizontalAlignment: Text.AlignLeft
    property alias rectangle1Color: rectangle1.color
    property alias text: textField.text
    topPadding: 0
    bottomPadding: 0
    leftPadding: 5
    rightPadding: 0

    layer.enabled: true
    selectByMouse: true
    background: rectangle1

    onTextChanged: {
        textField.color = "#e5004f"
    }

    Rectangle {
        id: rectangle1
        color: "#ffffff"
        border.width: 1
        border.color: "#d2d2d2"
        anchors.fill: parent
    }
    states: [
        State {
            name: "focus"
            when: textField.activeFocus

            PropertyChanges {
                target: rectangle1
                border.color: "#1c76c2"
                border.width: 1
            }
        }
    ]
}


