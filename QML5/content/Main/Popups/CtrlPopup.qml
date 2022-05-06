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

    background: backgroundRec
    Rectangle {
        id: backgroundRec
        color: "#d0d0d0"
        radius: 5
        border.width: 0
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }
    }

    ControlParameter {
        id: ctrlParameter
        y: 28
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
            id: apply
            x: 20
            text: "保存"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: cancel.left
            anchors.rightMargin: 15
            buttonBackgroundColor: "#3b7ecc"
            textItemColor: "#f6f6f6"
            coverColor: "#00101010"

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

            onClicked: {
                        if(scheduler.isPdbLoaded()){
                            ctrlLoad();
                        }
                    }
        }


        MyButton {
            id: confirm
            text: "取消"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            z: -1

            onClicked: {
                close();
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

    function disable(){
        ctrlParameter.disableInput(ctrlParameter)
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
