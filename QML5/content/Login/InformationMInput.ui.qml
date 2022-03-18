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
        y: 8
        width: 102
        height: 25
        text: item1.title
        anchors.bottom: textArea.top
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
        anchors.bottomMargin: 3
        font.styleName: "Regular"
        textFormat: Text.RichText
    }

    TextField {
        id: textArea
        x: 2
        y: 38
        color: "#232323"
        selectByMouse: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        placeholderTextColor: "#c1c1c1"
        leftPadding: 5
        anchors.rightMargin: 2
        anchors.leftMargin: 2
        anchors.bottomMargin: 4
        anchors.topMargin: 36

        background: rectangle
        Rectangle {
            id: rectangle
            opacity: 1
            color: "#00ffffff"
            radius: 8
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
                border.color: "#0d267b"
                border.width: 2
            }

            PropertyChanges {
                target: name
                font.pixelSize: 16
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

