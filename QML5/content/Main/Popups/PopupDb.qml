import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0

Popup{
    id: control
    clip: true
    property alias saveAsBtn: saveAsBtn
    property alias openBtn: openBtn
    property alias disconnectBtn: disconnectBtn
    property alias uploadBtn: uploadBtn
    property alias downloadBtn: downloadBtn
    property alias passBtn: passBtn
    property alias ftpBtn: ftpBtn

    rightPadding: 0
    leftPadding: 0
    bottomPadding: 0
    topPadding: 0
    rightMargin: 0
    leftMargin: 0
    bottomMargin: 0
    topMargin: 0

    width: 130
    height: 280


    implicitWidth: 130
    implicitHeight: 280

    background: bg

    Rectangle{
        id:bg
        color: "#e7e7e7"
        radius: 4
        border.color: "#8c8c8c"
        border.width: 1
        anchors.fill: parent

        DropShadowEffect {
            id: dropShadow
            color: "#3c000000"
            radius: 8
            spread: 0.2
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    DbBtn {
        id: openBtn
        //height: 48
        height: control.implicitHeight/7-2
        text: "打开"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 12
        bottomPadding: 2
        topPadding: 2
        highlighted: false
        flat: false
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2

        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        buttonBackgroundRadius: 0

        Rectangle {
            height: 1
            color: "#c8c8c8"
            border.color: "#343434"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
       }
    }

    DbBtn {
        id: saveAsBtn
        height: control.implicitHeight/7-2
        text: "另存为..."
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: openBtn.bottom
        font.pixelSize: 12
        bottomPadding: 2
        topPadding: 2
        font.capitalization: Font.MixedCase
        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        //buttonBackgroundRadius: 0

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
        id: uploadBtn
        height: control.implicitHeight/7-2
        text: "上传至中控"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: saveAsBtn.bottom
        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        buttonBackgroundRadius: 0
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
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
        height: control.implicitHeight/7-2
        text: "下载至本地"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: uploadBtn.bottom
        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        buttonBackgroundRadius: 0
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
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
        id: passBtn
        height: control.implicitHeight/7-2
        text: "上传显示焊道"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: downloadBtn.bottom
        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        buttonBackgroundRadius: 0
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
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
        height: control.implicitHeight/7-2
        text: "中控FTP设置"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: passBtn.bottom
        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        buttonBackgroundRadius: 0
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2

        Rectangle {
            height: 1
            color: "#c8c8c8"
            border.color: "#343434"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.bottomMargin: 0
        }
    }

    DbBtn {
        id: disconnectBtn
        height: control.implicitHeight/7-2
        text: "关闭工艺文件"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: ftpBtn.bottom
        textItemLeftPadding: 30
        textItemHorizontalAlignment: 1
        buttonBackgroundRadius: 0
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
//        Rectangle {
//            height: 1
//            color: "#c8c8c8"
//            border.color: "#343434"
//            border.width: 0
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.bottom: parent.bottom
//            anchors.leftMargin: 5
//            anchors.rightMargin: 5
//            anchors.bottomMargin: 0
//        }
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
    D{i:0;formeditorZoom:1.33}D{i:2}D{i:1}D{i:4}D{i:3}D{i:6}D{i:5}D{i:8}D{i:7}D{i:10}
D{i:9}D{i:12}D{i:11}D{i:14}D{i:13}D{i:15}
}
##^##*/
