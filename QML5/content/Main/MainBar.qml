import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import "Components"
import "Parameters"


Rectangle {
    id: rectangle
    width: 1366
    height: 54
    color: "#fafafa"
    border.color: "#000000"
    border.width: 0
    Rectangle{
        width: parent.width
        height: 1
        color: "#7e7e7e"
        anchors.top: parent.top
        anchors.left: parent.left
    }

    property alias commParamBtn: commParamBtn
    property alias ctrlParamBtn: ctrlParamBtn
    property alias motionParamBtn: motionParamBtn

    MainIconBtn {
        id: mainIconBtn
        //x: 8
        width: 35
        height: 30
        anchors {
         verticalCenter: parent.verticalCenter
         left: parent.left
         leftMargin: 8
        }
    }

    Text {
        id: mainTitle
        text: qsTr("焊接参数管理系统")
        anchors{
          verticalCenter: parent.verticalCenter
          left: mainIconBtn.right
          leftMargin: 6
          //verticalCenterOffset: 1
        }
        font.pixelSize: 18
        font.family:"Microsoft Yahei"
    }

    MainBarParameterBtn {
        id: motionParamBtn
        anchors
        {
          left: mainTitle.right
          leftMargin: 30
          verticalCenter: parent.verticalCenter
          verticalCenterOffset: 0
        }
        textItemText: "运动参数配置"
        imageSource: "../images/motion.png"
    }


//    MotionParamBtn {
//        id: motionParamBtn
//        x: 216
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.verticalCenterOffset: 0


//    }

    MainBarParameterBtn {
        id: ctrlParamBtn
        anchors
        {
          left: motionParamBtn.right
          leftMargin: 25
          verticalCenter: parent.verticalCenter
          verticalCenterOffset: 0
        }
        textItemText: "控制参数配置"
        imageSource: "../images/control.png"
    }


    MainBarParameterBtn {
        id: commParamBtn
        anchors
        {
          left: ctrlParamBtn.right
          leftMargin: 25
          verticalCenter: parent.verticalCenter
          verticalCenterOffset: 0
        }
        textItemText: "通讯参数配置"
        imageSource: "../images/commmunication.png"
    }



//    CtrlParamBtn {
//        id: ctrlParamBtn
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.left: motionParamBtn.right
//        anchors.leftMargin: 25


//    }

//    CommParamBtn {
//        id: commParamBtn
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.left: ctrlParamBtn.right
//        anchors.leftMargin: 25

//    }


}


