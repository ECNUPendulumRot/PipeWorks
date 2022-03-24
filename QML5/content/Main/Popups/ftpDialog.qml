import QtQuick 2.15
import QtQuick.Controls 2.15


Popup{

    id: control
    width:400
    height:200
    property alias cancelBtn: cancelBtn
    property alias confirmBtn: confirmBtn
    property alias ip: ipaddress.text
    property alias port: port.text
    property alias user: user.text
    property alias password: password.text

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
            x: 129
            y: 17
            text: "文件传输设置"
            font.pixelSize: 18
            anchors.verticalCenterOffset: -1
            font.family: "Courier"
            font.bold: true
        }

        TextField {
            id: ipaddress
            text: "localhost"
            x: 57
            y: 67
            width: 122
            height: 24
        }

        TextField {
            id: user
            text: "tzz"
            x: 57
            y: 110
            width: 122
            height: 24
        }

        TextField {
            id: port
            text: "21"
            x: 261
            y: 67
            width: 122
            height: 24
        }

        TextField {
            id: password
            text: "tzz0519"
            x: 261
            y: 110
            width: 122
            height: 24
        }

        Text {
            id: text2
            x: 15
            y: 73
            text: qsTr("IP地址")
            font.pixelSize: 12
        }

        Text {
            id: text3
            x: 207
            y: 73
            text: qsTr("端口")
            font.pixelSize: 12
        }

        Text {
            id: text4
            x: 15
            y: 116
            text: qsTr("用户名")
            font.pixelSize: 12
        }

        Text {
            id: text5
            x: 207
            y: 116
            text: qsTr("用户密码")
            font.pixelSize: 12
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


