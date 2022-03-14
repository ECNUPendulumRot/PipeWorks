import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control

    leftPadding: 4
    rightPadding: 4

    text: "My text"

    property string type: "accessable"
    property alias imageSource: image.source
    property alias textItemText: text1.text
    width: 96
    height: 40

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        width: parent.width
        height: parent.height
        radius: 4
        border.color: "#d3d3d3"
        border.width: 1
        anchors.fill: parent
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            color: "#3c000000"
            radius: 16
            spread: 0.2
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    contentItem: itemContent

    Item {

        id: itemContent
        anchors.fill: parent

        Text {
            id: text1
            y: 46
            width: 50
            height: 15
            text: control.text
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            anchors.bottomMargin: 3
            font.weight: Font.Medium
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            id: image
            width: 18
            height: 18
            anchors.top: parent.top
            source: "../../images/arrow.png"
            antialiasing: true
            mipmap: true
            anchors.topMargin: 3
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
    }
    states: [
        State {
            name: "normal"
        },
        State {
            name: "hover"
            when: control.hovered && !control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#f2f2f2"
            }
        },
        State {
            name: "press"
            when: control.pressed
            PropertyChanges {
                target: buttonBackground
                color: "#d2d2d2"
            }
        }
    ]
    transitions: [
        Transition {
            id: normalAndHover
            ParallelAnimation {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: buttonBackground
                        property: "color"
                        easing.bezierCurve: [0.548, -0.0111, 0.447, 1.01, 1, 1]
                        duration: 150
                    }
                }
            }
            to: "normal,hover"
            from: "normal,hover"
        }
    ]
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:4}D{i:5}D{i:3}
}
##^##*/

