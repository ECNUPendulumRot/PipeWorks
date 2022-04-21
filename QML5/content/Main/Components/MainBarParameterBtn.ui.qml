import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control

    leftPadding: 4
    rightPadding: 4

    text: "参数配置"

    //property string type: "accessable"
    property alias imageSource: image.source
    property alias textItemText: text1.text
    width: 100
    height: 45

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        width: parent.width
        height: parent.height
        radius: 4
        border.color: "#8c8c8c"
        border.width: 2
        anchors.fill: parent
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            color: "#3c000000"
            radius: 8
            samples: 17
            spread: 0.2
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    contentItem: itemContent

    Item {

        id: itemContent
        anchors.fill: parent

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

        Text {
            id: text1
            y: 21
            width: 50
            height: 24
            text: control.text
            anchors {
                bottom: parent.bottom
                bottomMargin: 0
                horizontalCenter: parent.horizontalCenter
            }
            font.pixelSize: 14
            font.family: "Microsoft Yahei"
            horizontalAlignment: Text.AlignHCenter
            //font.weight: Font.Medium
            //anchors.horizontalCenter: parent.horizontalCenter
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
                color: "#ffffff"
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
    D{i:0;formeditorZoom:1.25}
}
##^##*/

