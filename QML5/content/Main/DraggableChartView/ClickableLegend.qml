import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

Button {
    id: control


    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    text: "legend"
    checkable: true

    //  added for extension
    //  used by indicator
    property color legendColor: "#ff0000"

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "transparent"
        anchors.fill: content
        border.width: 0
    }

    contentItem: content
    Item {
        id: content

        implicitWidth: wrapper.implicitWidth
        implicitHeight: wrapper.implicitHeight


        Item {
            id: wrapper
            implicitHeight: Math.max(indicator.height, legend.implicitHeight)
            implicitWidth: indicator.width + legend.leftPadding + legend.implicitWidth
            Rectangle {
                id: indicator

                implicitWidth: 40
                implicitHeight: 15

                color: control.legendColor
                radius: 0

                border.width: 0
            }

            Text {
                id: legend
                text: control.text
                font.pixelSize: 14
                color: "#000000"
                verticalAlignment: Text.AlignVCenter

                anchors.left: indicator.right
                anchors.verticalCenter: indicator.verticalCenter
                leftPadding: 5
            }
        }



        Rectangle {
            id: line
            implicitWidth: wrapper.implicitWidth - 4
            implicitHeight: 2

            opacity: 0
            visible: true
            color: "#000000"
            anchors.verticalCenter: wrapper.verticalCenter
            anchors.horizontalCenter: wrapper.horizontalCenter
        }
    }
    states: [
        State {
            name: "disabled"
        },

        State {
            name: "enabled"
            when: control.checked

            PropertyChanges {
                target: line
                opacity: 1
            }

        }
    ]
}

