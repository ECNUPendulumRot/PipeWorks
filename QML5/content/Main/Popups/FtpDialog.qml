import QtQuick 2.15
import QtQuick.Controls 2.15


Popup{

    id: control
    width:400
    height:350
    property alias cancelBtn: cancelBtn
    property alias confirmBtn: confirmBtn
    property alias ip: ipaddress.text
    property alias port: port.text
    property alias user: user.text
    property alias password: password.text

    property alias uploadName: uploadName.text
   // property alias downloadName: downloadName.text

    dim: true
    modal: true

    closePolicy: Popup.NoAutoClose

    Item {
        id:content
        anchors.fill: parent
        z: 1


        ConfirmBtn {
            id: confirmBtn

            x: 202
            y: 305

            width: 70
            height: 24
            text: "确定"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            pressRecColor: "#00101010"
            textItemColor: "#f6f6f6"
            buttonBackgroundColor: "#3b7ecc"

            anchors.rightMargin: 128

            anchors.bottomMargin: 21
        }

        ConfirmBtn {
            id: cancelBtn

            x: 311

            width: 70
            height: 24
            text: "取消"
            anchors.verticalCenter: confirmBtn.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.rightMargin: 15
        }


        Text {
            id: text1
            x: 129
            y: 17
            text: "文件传输设置"
            font.pixelSize: 20
            anchors.verticalCenterOffset: -1
            font.family: "Courier"
            font.bold: true
        }

        TextField {
            id: ipaddress
            text: ""
            anchors.verticalCenter: text2.verticalCenter

            x: 93
            width: 140
            height: 30
            font.pixelSize: 18
        }

        TextField {
            id: port
            text: ""
            anchors.verticalCenter: text2.verticalCenter

            x: 295
            width: 86
            height: 30
            font.pixelSize: 18
        }

        TextField {
            id: user
            text: ""
            anchors.verticalCenter: text4.verticalCenter

            x: 93
            width: 288
            height: 30
            font.pixelSize: 18
        }



        TextField {
            id: password
            text: ""
            anchors.verticalCenter: text5.verticalCenter

            x: 94
            width: 287
            height: 30
            font.pixelSize: 18
        }

        TextField {
            id: uploadName
            x: 94
            width: 287
            height: 30
            text: ""
            anchors.verticalCenter: text6.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: text2

            x: 16
            y: 85
            text: qsTr("IP地址")
            font.pixelSize: 18
        }

        Text {
            id: text3
            x: 257

            text: qsTr("端口")
            anchors.verticalCenter: text2.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: text4

            x: 16
            text: qsTr("用户名")
            anchors.top: text2.bottom
            font.pixelSize: 18
            anchors.topMargin: 40
        }

        Text {
            id: text5
            x: 16

            text: qsTr("用户密码")
            anchors.top: text4.bottom
            font.pixelSize: 18
            anchors.topMargin: 40
        }



        Text {
            id: text6
            x: 16
            text: qsTr("文件名")
            anchors.top: text5.bottom
            font.pixelSize: 18
            anchors.topMargin: 40
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


/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}D{i:2}D{i:3}D{i:4}D{i:5}D{i:6}D{i:7}D{i:8}D{i:9}D{i:10}
D{i:11}D{i:12}D{i:13}D{i:1}D{i:14}
}
##^##*/
