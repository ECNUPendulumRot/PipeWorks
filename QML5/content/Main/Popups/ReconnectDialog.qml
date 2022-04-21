import QtQuick 2.15
import QtQuick.Controls 2.15


Popup{

    id: control
    width:400
    height:250
    property alias cancelBtn: cancelBtn
    property alias editBtn: editBtn
    property alias confirmBtn: confirmBtn

    dim: true
    modal: true

    closePolicy: Popup.NoAutoClose

    Item {
        id:content
        anchors.fill: parent
        z: 1

        ConfirmBtn {
            id: confirmBtn
            //y: 119
            width: 80
            height: 25
            text: "保存后打开"
            anchors.right: editBtn.left
            anchors.rightMargin: 15
            //anchors.bottom: parent.bottom
            anchors.verticalCenter: cancelBtn.verticalCenter
            //anchors.bottomMargin: 10
            pressRecColor: "#00101010"
            textItemColor: "#f6f6f6"
            buttonBackgroundColor: "#3b7ecc"
        }
        ConfirmBtn {
            id: editBtn
            x: 155
            width: 80
            height: 25
            text: "继续编辑"
            anchors.verticalCenter: confirmBtn.verticalCenter
            anchors.right: cancelBtn.left
            anchors.rightMargin: 15
        }

        ConfirmBtn {
            id: cancelBtn
            x: 68
            width: 80
            height: 25
            text: "不保存"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
        }



        Image {
            id: caution
            x: 14
            y: 8
            width: 37
            height: 33
            source: "../../images/caution.png"
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text1
            x: 64
            text: "一个工艺文件已经打开"
            anchors.verticalCenter: caution.verticalCenter
            font.pixelSize: 18
            anchors.verticalCenterOffset: -1
            font.family:"Microsoft Yahei"
            font.bold: true
        }

        Text {
            id: text3
            x: 64
            y: 58
            text: "你可以选择:"
            font.pixelSize: 14
            font.family:"Microsoft Yahei"
        }

        Text {
            id: text4
            x: 70
            y: 84
            text: qsTr(" 1. 保存后打开：保存更改并打开新的工艺文件")

            font.pixelSize: 14
            font.family:"Microsoft Yahei"
        }

        Text {
            id: text5
            y: 105
            width: 238
            height: 20
            text: qsTr(" 2. 继续编辑：继续编辑当前工艺文件")
            anchors.left: text4.left
            font.pixelSize: 14
            font.family:"Microsoft Yahei"
        }

        Text {
            id: text6
            y: 126

            text: qsTr(" 3. 不保存：放弃当前修改，打开新的工艺文件")

            anchors.left: text5.left
            font.pixelSize: 14
            font.family:"Microsoft Yahei"
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


