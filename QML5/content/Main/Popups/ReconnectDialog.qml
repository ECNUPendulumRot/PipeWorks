import QtQuick 2.15
import QtQuick.Controls 2.15


Popup{

    id: control
    width:400
    height:200
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
            y: 119
            width: 70
            height: 24
            text: "更新并打开"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            pressRecColor: "#00101010"
            textItemColor: "#f6f6f6"
            buttonBackgroundColor: "#3b7ecc"
            anchors.rightMargin: 17
            anchors.bottomMargin: 7
        }

        ConfirmBtn {
            id: cancelBtn
            x: 68
            width: 70
            height: 24
            text: "直接关闭"
            anchors.verticalCenter: confirmBtn.verticalCenter
            anchors.right: editBtn.left
            anchors.rightMargin: 15
        }

        ConfirmBtn {
            id: editBtn
            x: 155
            width: 70
            height: 24
            text: "继续编辑"
            anchors.verticalCenter: confirmBtn.verticalCenter
            anchors.right: confirmBtn.left
            anchors.rightMargin: 15
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
            text: "一个数据库已经打开"
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
            text: "您可以选择:"
            font.pixelSize: 14
            font.family:"Microsoft Yahei"
        }

        Text {
            id: text4
            x: 70
            y: 84
            text: qsTr(" 1. 直接关闭：不保存当前数据库并打开新的数据库")
            font.pixelSize: 14
            font.family:"Microsoft Yahei"
        }

        Text {
            id: text5
            y: 105
            width: 238
            height: 20
            text: qsTr(" 2. 继续编辑：继续编辑当前数据库")
            anchors.left: text4.left
            font.pixelSize: 14
            font.family:"Microsoft Yahei"
        }

        Text {
            id: text6
            y: 126
            text: qsTr(" 3. 更新并打开：应用更改并打开新的数据库")
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


