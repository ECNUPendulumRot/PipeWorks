import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Parameters"

Popup {
    id: motionPop
    width: 850
    height: 510

    modal: true
    closePolicy: Popup.NoAutoClose

    Overlay.modal: Rectangle {
        color: "#c0515151"
    }

    background: Rectangle {
        id: motionBgd
        color: "#ebebeb"
        border.width: 0
        anchors.fill: parent
    }

    ControlParameter {
        id: ctrlParameter
        y: 28
        anchors.horizontalCenterOffset: 7
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: groupItem
        x: 477
        width: 352
        height: 33
        anchors.right: ctrlParameter.right
        anchors.top: ctrlParameter.bottom
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
                            ctrlLoad();
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

    function ctrlLoad(){
        ctrlParameter.refreshData(ctrlParameter)
        //refreshColor(rectangle)
    }


    function write(){
        ctrlParameter.writeInData(ctrlParameter)
        ctrlParameter.refreshData(ctrlParameter)
    }

    function clear(){
        ctrlParameter.clearData(ctrlParameter)
    }

}
