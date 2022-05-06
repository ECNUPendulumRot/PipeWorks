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
        color: "#d0d0d0"
        radius: 5
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }
    }

    Rectangle {
        id: motionParameter
        y: 28
        width: motionContent.width
        height: motionContent.height
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        MotionParameter {
            id: motionContent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Item {
        id: groupItem
        width: 352
        height: 33
        anchors.right: motionParameter.right
        anchors.top: motionParameter.bottom
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
                    motionLoad();
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

    property var objectMotionLite : null

    function motionLoad() {
        motionParameter.children[0].refreshData(motionParameter);
    }

    function write(){
        motionParameter.children[0].writeInData(motionParameter)
        motionParameter.children[0].refreshData(motionParameter)
    }

    function clear(){
        motionParameter.children[0].clearData(motionParameter)
    }

    function disable(){
        motionParameter.children[0].destroy()
        objectMotionLite = Qt.createQmlObject(
                    'import QtQuick 2.15
                     import QtQuick.Controls 2.15
                     import "../Parameters"

                     MotionParameterLite {
                         id: motionContent
                         y: 28
                         width: 712
                         anchors.horizontalCenter: parent.horizontalCenter
                     }
                     ',
                    motionParameter)
        backgroundRec.width = 695
        backgroundRec.height = 450
        motionParameter.y = 8
        motionParameter.width = 620
        motionParameter.height = 350
        groupItem.anchors.topMargin = 40

        //motionParameter.disableInput(motionParameter)
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
