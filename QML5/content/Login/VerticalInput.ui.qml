import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0

Item {
    id: item1
    width: 350
    height: 75

    property alias textAreaPlaceholderText: textArea.placeholderText
    property alias inputText: textArea
    property alias labelFontSize: name.font.pixelSize
    property alias inputFontSize: textArea.font.pixelSize
    property string title
    Text {
        id: name
        x: 0
        //width: 102
        width: 260
        height: 25
        text: item1.title
        anchors.top: parent.top
        font.pixelSize: 16
        font.styleName: "Regular"
        font.family: "Microsoft YaHei"
        textFormat: Text.RichText
        anchors.topMargin: 5
    }

    TextField {
        id: textArea
        height: 35
        //x: 2
        //y: 38
        color: "#232323"
        text: qsTr("")
        selectByMouse: true
        anchors {
            left: parent.left
            top: name.bottom
            right: parent.right
            leftMargin: 2
            rightMargin: 2
            topMargin: 7
        }
        font.pixelSize: 18
        font.family: "Microsoft YaHei"
        verticalAlignment: Text.AlignVCenter
        antialiasing: false
        placeholderTextColor: "#c1c1c1"
        leftPadding: 5

        background: rectangle
        Rectangle {
            id: rectangle
            opacity: 1
            color: "#00ffffff"
            radius: 4
            border.color: "#4f4f4f"
            border.width: 1
            anchors.fill: parent
            anchors.topMargin: 0
        }
        //placeholderText: qsTr("")
    }
    states: [
        State {
            name: "focus"
            when: textArea.activeFocus

            PropertyChanges {
                target: rectangle
                color: "#f2f2f2"
                border.color: "#1c76c2"
                border.width: 2
            }

            PropertyChanges {
                target: name
                font.pixelSize: 18
            }
        }
    ]
    transitions: [
        Transition {
            id: transition
            ParallelAnimation {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 149
                    }

                    PropertyAnimation {
                        target: rectangle
                        property: "border.width"
                        easing.bezierCurve: [0.613, 0.026, 0.491, 0.996, 1, 1]
                        duration: 157
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: rectangle
                        property: "color"
                        easing.bezierCurve: [0.358, 1.1, 0.476, 1.01, 1, 1]
                        duration: 149
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 149
                    }

                    PropertyAnimation {
                        target: rectangle
                        property: "border.color"
                        easing.bezierCurve: [0.506, 0.00284, 0.423, 0.994, 1, 1]
                        duration: 157
                    }
                }
            }
            to: "*"
            from: "*"
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:75;width:350}D{i:1}D{i:3}D{i:2}D{i:11;transitionDuration:2000}
}
##^##*/

