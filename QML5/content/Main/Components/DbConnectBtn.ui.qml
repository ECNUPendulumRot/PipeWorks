import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Studio.Effects 1.0

Button {
    id: control
    width: 120
    height: 30

    text: "工艺文件"
    spacing: 0

    background: buttonBackground

    Rectangle {
        id: buttonBackground
        color: "#e7e7e7"
        opacity: enabled ? 1 : 0.3
        radius: 8
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

    contentItem: item1

    Item {
        id: item1
        anchors.fill: parent

        Image {
            id: dataDb
            x: 10
            y: 14
            width: 19
            height: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "../../images/data.png"
            antialiasing: true
            mipmap: true
            anchors.leftMargin: 8
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: arrow
            x: 176
            y: 14
            width: 18
            height: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            source: "../../images/arrow.png"
            antialiasing: true
            mipmap: true
            anchors.rightMargin: 6
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: textItem
            x: 29
            y: 0
            height: 30

            opacity: enabled ? 1.0 : 0.3

            color: "#161616"
            text: "工艺文件"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: dataDb.right
            anchors.right: arrow.left
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            anchors.leftMargin: 2
            anchors.rightMargin: 13
            fontSizeMode: Text.VerticalFit
            font.bold: false
            font.weight: Font.Light
            font.pixelSize: 14
            styleColor: "#121212"
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
            id: transition
            ParallelAnimation {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: buttonBackground
                        property: "color"
                        easing.bezierCurve: [0.645, 0.045, 0.355, 1, 1, 1]
                        duration: 657
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
    D{i:0;height:33;width:120}D{i:12;transitionDuration:2000}D{i:1}D{i:4}D{i:5}D{i:6}
D{i:3}
}
##^##*/

