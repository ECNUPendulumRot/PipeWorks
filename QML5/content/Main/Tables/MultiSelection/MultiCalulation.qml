import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: control
    width: 120
    height: 40

    signal addRequest(var n)
    signal minusRequest(var n)

    TextField {
        id: textField
        width: 65
        height: 30
        color: "#d90a0a0a"
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("")

        validator: RegularExpressionValidator {
            regularExpression: /[0-9]+(\.[0-9]*)?$/
        }

        selectByMouse: true

        background: texBg
        Rectangle {
            id: texBg
            color: "#ffffff"
            radius: 4
            border.color: "#d3d3d3"
            border.width: 1
            anchors.fill: parent
        }
    }

    AmountBtn {
        id: add
        x: 91
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        imageSource: "../images/plus.png"
        anchors.verticalCenterOffset: 0
        onClicked: control.addRequest(textField.text)
    }

    AmountBtn {
        id: minus
        x: 0
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        imageSource: "../images/minus.png"
        onClicked: control.minusRequest(textField.text)
    }


}
