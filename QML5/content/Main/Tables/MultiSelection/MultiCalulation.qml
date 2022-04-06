import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0

Item {
    id: control
    width: 150
    height: 40

    signal addRequest(var n)
    signal minusRequest(var n)
    signal setRequest(var n)

    property alias addVisible: add.visible
    property alias minusVisible: minus.visible
    property alias changeVisible: change.visible

    TextField {
        id: textField
        width: 65
        height: 25
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
            color: "#00ffffff"
            radius: 4
            border.color: "#2e2e2e"
            border.width: 1
            anchors.fill: parent
            layer.enabled: true
            layer.effect: DropShadowEffect {
                id: dropShadow
                visible: true
                horizontalOffset: 0
                verticalOffset: 0.5
                color: "#3c000000"
                radius: 8
                spread: 0.1
                samples: textField.activeFocus ? 17 : 0
            }
        }

        onEditingFinished: focus = false
    }

    AmountBtn {
        id: add
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: textField.right
        anchors.leftMargin: 10
        imageSource: "../../../images/plus.png"
        anchors.verticalCenterOffset: 0
        onClicked: if(textField.text != "") control.addRequest(textField.text)
    }

    AmountBtn {
        id: minus
        x: 0
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: textField.left
        anchors.rightMargin: 10
        imageSource: "../../../images/minus.png"
        onClicked: if(textField.text != "") control.minusRequest(textField.text)
    }

    AmountBtn {
        id: change
        x: 0
        width: 25
        height: 25
        anchors.verticalCenter: add.verticalCenter
        anchors.left: add.left
        anchors.leftMargin: 0
        imageSource: "../../../images/check.png"
        visible: false
        onClicked: if(textField.text != "") control.setRequest(textField.text)
    }

    states: [
        State {
            name: "unfocus"
            when: !textField.activeFocus
        },
        State {
            name: "focus"
            when: textField.activeFocus

            PropertyChanges {
                target: texBg
                color: "#f5f5f5"
                border.width: 1
            }
        }
    ]

    function clear(){
        textField.text = "";
    }

//    Connections{
//        target: textField
//        function onAccepted(){
//            //console.log("aaaaaaaaaaaaaaaaaa")
//            control.setRequest(textField.text)
//        }
//        enabled: editMode.checked
//    }
}
