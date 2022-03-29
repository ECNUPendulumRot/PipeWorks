import QtQuick 2.15
import QtQuick.Controls 2.15


Popup{

    id: control
    width:400
    height:200
    property alias cancelBtn: cancelBtn
    property alias confirmBtn: confirmBtn
    property alias completeBtn: completeBtn
    property alias progressBarValue: progressBar.value
    property alias cvisibleProgress: progressBar.visible
    property alias errorMessage: errorMsg
    dim: true
    modal: true

    closePolicy: Popup.NoAutoClose

    Item {
        id:content
        anchors.fill: parent
        z: 1

        ConfirmBtn {
            id: cancelBtn
            x: 311
            y: 157
            width: 70
            height: 24
            text: "取消"
            anchors.rightMargin: 15
        }

        ConfirmBtn {
            id: confirmBtn
            x: 215
            y: 157
            width: 70
            height: 24
            text: "上传"
            pressRecColor: "#00101010"
            textItemColor: "#f6f6f6"
            buttonBackgroundColor: "#3b7ecc"
        }
        ConfirmBtn {
            id: completeBtn
            x: 215
            y: 157
            width: 70
            height: 24
            text: "完成"
            cvisible: false
            pressRecColor: "#00101010"
            textItemColor: "#f6f6f6"
            buttonBackgroundColor: "#3b7ecc"
        }

        Text {
            id: text1
            x: 47
            y: 25
            text: "您是否要将当前文件上传到中控？"
            font.pixelSize: 18
            anchors.verticalCenterOffset: -1
            font.family: "Courier"
            font.bold: true
        }

        ProgressBar {

            id: progressBar
            value: 0.0
            x: 18
            y: 91
            width: 365
            height: 19
            visible: false
        }

        Text {
            id: errorMsg
            x: 42
            y: 122
            text: qsTr("error")
            color: "#00ff00"
            visible: false
            font.pixelSize: 12
            function clear(){
                text = ""
                visible = false
            }
        }
    }

    background:rectangle
    Rectangle {
        id: rectangle
        radius: 5
        border.color: "#d3d3d3"
        border.width: 2
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#d0d0d0"
            }

            GradientStop {
                position: 0.52055
                color: "#dcdcdc"
            }

            GradientStop {
                position: 1
                color: "#d4d4d4"
            }

            orientation: Gradient.Horizontal
        }
    }

    Overlay.modal: Rectangle {
        color: "#c0515151"
    }


}


