import QtQuick 2.15
import QtQuick.Controls 2.15


Popup{

    id: control
    width:400
    height:200
    property alias cancelBtn: cancelBtn
    property alias confirmBtn: confirmBtn
    property alias fileName: textField.text

    dim: true
    modal: true

    closePolicy: Popup.NoAutoClose

    Item {
        id:content
        anchors.fill: parent
        z: 1

        ConfirmBtn {
            id: cancelBtn
            x: 226
            width: 70
            height: 24
            text: "取消"
            anchors.verticalCenter: confirmBtn.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.rightMargin: 15
        }

        ConfirmBtn {
            id: confirmBtn
            y: 119
            width: 70
            height: 24
            text: "确定"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            pressRecColor: "#00101010"
            textItemColor: "#f6f6f6"
            buttonBackgroundColor: "#3b7ecc"
            anchors.rightMargin: 17
            anchors.bottomMargin: 7
        }

        Text {
            id: text1
            x: 88
            y: 38
            text: "请编辑您上传的文件名称"
            font.pixelSize: 18
            anchors.verticalCenterOffset: -1
            font.family: "Courier"
            font.bold: true
        }

        TextField {
            id: textField
            x: 74
            y: 88
            width: 253
            height: 24
            placeholderText: qsTr("文件名")
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


