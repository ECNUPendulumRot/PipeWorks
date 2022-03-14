import QtQuick 2.15
import QtQuick.Controls 2.15

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

    dim:false
    modal: true
    clip:true


    z:3

    property alias closeBtn: close
    property alias logoutBtn: logout

    background:rectangle1
    Rectangle {
        id: rectangle1
        color: "#e9e9e9"
        anchors.fill: parent
    }

    DbBtn {
        id: close
        height: popup.height/2
        text: "关闭"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        z: 1
        anchors.leftMargin: 0

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
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: close.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        z: 1
        anchors.leftMargin: 0
    }


}
