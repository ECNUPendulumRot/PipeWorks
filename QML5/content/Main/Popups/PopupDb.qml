import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0

Popup{
    id: control
    clip: true
    property alias saveAsBtn: saveAsBtn
    property alias openBtn: openBtn
    width: 130
    height: 180
    property alias disconnectBtn: disconnectBtn
    property alias uploadBtn: uploadBtn
    property alias downloadBtn: downloadBtn
    property alias ftpBtn: ftpBtn
    rightPadding: 0
    leftPadding: 0
    bottomPadding: 0
    topPadding: 0
    rightMargin: 0
    leftMargin: 0
    bottomMargin: 0
    topMargin: 0

    implicitWidth: 130
    implicitHeight: 180


    closePolicy: Popup.CloseOnPressOutside
    //modal: true

    background: bg

    Rectangle{
        id:bg
        color: "#e7e7e7"
        radius: 8
        border.color: "#707070"
        border.width: 1
        anchors.fill: parent

        DropShadowEffect {
            id: dropShadow
            color: "#3c000000"
            radius: 16
            spread: 0.5
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    Item {
        id: buttons
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0


        DbBtn {
            id: openBtn
            height: control.implicitHeight/6
            text: "打开"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            textItemLeftPadding: 30
            textItemHorizontalAlignment: 1
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            buttonBackgroundRadius: 8
            anchors.topMargin: 0

            Rectangle {
                height: 1
                color: "#c8c8c8"
                border.color: "#343434"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 0

            }
        }

        DbBtn {
            id: saveAsBtn
            height: control.implicitHeight/6
            text: "另存为"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: openBtn.bottom
            textItemLeftPadding: 30
            textItemHorizontalAlignment: 1
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            buttonBackgroundRadius: 8

            Rectangle {
                height: 1
                color: "#c8c8c8"
                border.color: "#343434"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.leftMargin: 5
                anchors.rightMargin: 5
            }
        }

        DbBtn {
            id: disconnectBtn
            height: control.implicitHeight/6
            text: "关闭"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: ftpBtn.bottom
            textItemLeftPadding: 30
            textItemHorizontalAlignment: 1
            anchors.leftMargin: 1
            buttonBackgroundRadius: 8
            anchors.rightMargin: 1
            anchors.topMargin: 0
            Rectangle {
                height: 1
                color: "#c8c8c8"
                border.color: "#343434"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 0
            }
        }

        DbBtn {
            id: uploadBtn
            height: control.implicitHeight/6
            text: "上传至中控"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: saveAsBtn.bottom
            textItemLeftPadding: 30
            textItemHorizontalAlignment: 1
            anchors.leftMargin: 1
            buttonBackgroundRadius: 8
            anchors.rightMargin: 1
            anchors.topMargin: 0
            Rectangle {
                height: 1
                color: "#c8c8c8"
                border.color: "#343434"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 0
            }
        }

        DbBtn {
            id: downloadBtn
            height:control.implicitHeight/6
            text: "下载至本地"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: uploadBtn.bottom
            textItemLeftPadding: 30
            textItemHorizontalAlignment: 1
            anchors.topMargin: 0
            buttonBackgroundRadius: 8
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            Rectangle {
                height: 1
                color: "#c8c8c8"
                border.color: "#343434"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 0
            }
        }


        DbBtn {
            id: ftpBtn
            height:control.implicitHeight/6
            text: "FTP设置"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: downloadBtn.bottom
            textItemLeftPadding: 30
            textItemHorizontalAlignment: 1
            anchors.topMargin: -1
            buttonBackgroundRadius: 8
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            Rectangle {
                height: 1
                color: "#c8c8c8"
                border.color: "#343434"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 0
            }
        }



    }

    enter: Transition {
        NumberAnimation { property: "height"; easing.bezierCurve: [0.454,0.00593,0.476,1,1,1]; from: 0.0; to: control.implicitHeight; duration: 100}
    }

    exit: Transition{
        NumberAnimation { property: "height"; easing.bezierCurve: [0.484,0.004,0.436,0.996,1,1]; from: control.height; to: 0.0; duration: 100}
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}
}
##^##*/
