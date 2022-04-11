import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Parameters"

Popup {
    id: commPop
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
        x: 0
        y: 0
        width: 581
        height: 290
        color: "#ebebeb"
        border.width: 0

        MouseArea {
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }
    }

    CommunicationParameter {
        id: commParameter
        y: 28
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: groupItem
        x: 204
        width: 352
        height: 33
        anchors.right: commParameter.right
        anchors.top: commParameter.bottom
        anchors.topMargin: 15
        anchors.rightMargin: 0



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
                    commLoad();
                }
            }
        }
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
    }

    function commLoad(){
        commParameter.refreshData()
        //refreshColor(rectangle)
    }


    function write(){
        commParameter.writeInData()
        commParameter.refreshData()
    }

    function clear(){
        commParameter.clearData()
    }

    function disable(){
        commParameter.disableInput(commParameter)
    }

}
