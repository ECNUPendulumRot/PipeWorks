import QtQuick 2.12
import QtQuick.Controls 2.12

CheckBox {

    id: control
    width: 20
    height: control.width
    text: qsTr("CheckBox")
    activeFocusOnTab: false
    focus: false
    display: AbstractButton.IconOnly
    hoverEnabled: true
    indicator: indicatorRectangle


    Rectangle {
        id: indicatorRectangle
        x: 6
        y: 2
        color: "#00ffffff"
        implicitWidth: 26
        implicitHeight: 26
        radius: 4
        border.color: "#303030"
        border.width: 2
        anchors.fill: parent

        Image {
            id: check
            opacity: 1
            visible: false
            anchors.fill: parent
            source: "../images/check.png"
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: partialCheck
            width: 12
            height: 4
            visible: false
            color: "#202020"
            radius: 1
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    background: bg
    Rectangle {
        id: bg
        color: {
                if(control.hovered){
                   if(control.pressed) return "#c0c0c0"
                   else return "#ffffff"
                }
                else{
                   return "transparent"
               }
             }
        radius: 4
        border.width: 0
        anchors.fill: parent
    }
    states: [
        State {
            name: "checked"
            when: !control.tristate && control.checked

            PropertyChanges {
                target: check
                visible: true
            }
        },
        State {
            name: "unchecked"
            when: !control.tristate && !control.checked
            PropertyChanges {
                target: check
                visible: false
            }
        },
        State {
            name: "triChecked"
            when: control.tristate && control.checkState === Qt.Checked
            PropertyChanges {
                target: check
                visible: true
            }
        },
        State {
            name: "triUnchecked"
            when: control.tristate && control.checkState === Qt.Unchecked
            PropertyChanges {
                target: check
                visible: false
            }
        },
        State {
            name: "triPartiallyChecked"
            when: control.tristate && control.checkState === Qt.PartiallyChecked
            PropertyChanges {
                target: check
                visible: false
            }

            PropertyChanges {
                target: partialCheck
                visible: true
            }
        }
    ]
}
