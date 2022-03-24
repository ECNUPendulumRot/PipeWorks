import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Parameters"

Popup {
    id: motionPop
    width: backgroundRec.width
    height: backgroundRec.height

    modal: true
    closePolicy: Popup.NoAutoClose

    Overlay.modal: Rectangle {
        color: "#c0515151"
    }

    background: backgroundRec

    Rectangle {
        id: backgroundRec
        width: 787
        height: 670
        color: "#ebebeb"
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }
    }

    MotionParameter {
        id: motionParameter
        y: 28
        width: 712
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: groupItem
        x: 411
        width: 352
        height: 33
        anchors.right: motionParameter.right
        anchors.top: motionParameter.bottom
        anchors.topMargin: 15
        anchors.rightMargin: 0

        MyButton {
            id: confirm
            text: "取消"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            buttonBackgroundColor: "#9c9c9c"
            textItemColor: "#e5e5e5"
            buttonBackgroundBordercolor: "#c7c7c7"
            z: -1

            onClicked: {
                    close();
            }

        }

        MyButton {
            id: cancel
            text: "撤销"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: confirm.left
            anchors.rightMargin: 15
            buttonBackgroundColor: "#9c9c9c"
            textItemColor: "#e5e5e5"
            buttonBackgroundBordercolor: "#c7c7c7"

            onClicked: {
                if(scheduler.isPdbLoaded()){
                    motionLoad();
                }
            }

        }

        MyButton {
            id: apply
            x: 20
            text: "保存"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: cancel.left
            anchors.rightMargin: 15
            buttonBackgroundColor: "#4870ca"
            textItemColor: "#e5e5e5"

            onClicked: {
                if(scheduler.isPdbLoaded())
                    write()
            }
        }
    }

    function motionLoad() {
        motionParameter.refreshData(motionParameter);
    }

    function write(){
        motionParameter.writeInData(motionParameter)
        motionParameter.refreshData(motionParameter)
    }

    function clear(){
        motionParameter.clearData(motionParameter)
    }

    function disable(){
        motionParameter.disableInput(motionParameter)
    }

}
