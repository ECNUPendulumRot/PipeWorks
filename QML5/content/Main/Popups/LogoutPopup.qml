import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0


Popup {
    id: popup
    width: 100
    height: 70

    implicitWidth: 100
    implicitHeight: 70

    rightPadding: 0
    leftPadding: 0
    bottomPadding: 0
    topPadding: 0
    rightMargin: 0
    leftMargin: 0
    bottomMargin: 0
    topMargin: 0

    closePolicy: Popup.CloseOnPressOutside
    //modal: true
    clip:true


    z:3

    property alias closeBtn: close
    property alias logoutBtn: logout

    background:rectangle1
    Rectangle {
        id: rectangle1
        color: "#e7e7e7"
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        radius: 4
        border.color: "#8c8c8c"
        border.width: 1
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            radius: 8
            verticalOffset: 0
            horizontalOffset: 0
            color: "#3c000000"
            spread: 0.2
        }


    }

    DbBtn {
        id: close
        height: parent.height/2
        text: "修改密码"
        font.pixelSize: 12
        font.family: "Microsoft Yahei"
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: 2
            leftMargin: 2
            rightMargin:2
            bottomMargin:1
        }
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.top: parent.top
        //font.pointSize: 12
        //anchors.topMargin: 0
        z: 1
        //anchors.leftMargin: 4

        Rectangle {
            id: rectangle
            height: 1
            color: "#d2d2d2"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }

    DbBtn {
        id: logout
        text: "切换用户"
        font.pixelSize: 12
        font.family: "Microsoft Yahei"
        anchors{
            left: parent.left
            right: parent.right
            top: close.bottom
            bottom: parent.bottom
            topMargin: 1
            leftMargin: 2
            rightMargin:2
            bottomMargin:2
        }
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.top: closeBtn.bottom
//        anchors.bottom: parent.bottom
        font.pointSize: 12
//        anchors.bottomMargin: 0
        z: 1
        //anchors.leftMargin: 4
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}D{i:1}D{i:4}D{i:3}D{i:5}
}
##^##*/
