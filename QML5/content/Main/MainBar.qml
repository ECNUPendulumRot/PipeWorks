import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import "Components"
import "Parameters"

Rectangle {
    id: rectangle
    width: 1366
    height: 54
    color: "#d1d1d1"
    border.color: "#ffffff"
    border.width: 0


    property alias commParamBtn: commParamBtn
    property alias ctrlParamBtn: ctrlParamBtn
    property alias motionParamBtn: motionParamBtn

    MainIconBtn {
        id: mainIconBtn
        x: 8
        width: 35
        height: 30
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: mainTitle
        text: qsTr("焊接参数管理系统")
        anchors.verticalCenter: mainIconBtn.verticalCenter
        anchors.left: mainIconBtn.right
        anchors.leftMargin: 6
        anchors.verticalCenterOffset: 1
        font.pixelSize: 16
    }

    MotionParamBtn {
        id: motionParamBtn
        x: 216
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0


    }

    CtrlParamBtn {
        id: ctrlParamBtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: motionParamBtn.right
        anchors.leftMargin: 25


    }

    CommParamBtn {
        id: commParamBtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ctrlParamBtn.right
        anchors.leftMargin: 25

    }


}


