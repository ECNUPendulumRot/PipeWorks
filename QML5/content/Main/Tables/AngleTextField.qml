import QtQuick 2.15
import QtQuick.Controls 2.12

TextField {
    id: textField
    width: 60
    height: 30
    color: "#0d0d0d"
    font.pixelSize: 12
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.family: "Courier"
    font.weight: Font.Medium
    placeholderText: "0.00"

    implicitWidth: 60
    implicitHeight: 30

    selectByMouse: true

    background: bg
    Rectangle {
        id: bg
        color: "#00dddddd"
        border.width: 0
        anchors.fill: parent
    }
    states: [
        State {
            name: "selected"
            when: textField.activeFocus

            PropertyChanges {
                target: bg
                color: "#befefefe"
                border.color: "#0d267b"
                border.width: 2
            }

            PropertyChanges {
                target: textField
                font.pixelSize: 16
            }
        },
        State {
            name: "normal"
            when: !textField.activeFocus
        }
    ]
    transitions: [
        Transition {
            id: selectChange
            ParallelAnimation {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: bg
                        property: "border.color"
                        easing.bezierCurve: [0.755,0.05,0.855,0.06,1,1]
                        duration: 150
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: bg
                        property: "border.width"
                        easing.bezierCurve: [0.755,0.05,0.855,0.06,1,1]
                        duration: 150
                    }
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 50
                    }

                    PropertyAnimation {
                        target: bg
                        property: "color"
                        easing.bezierCurve: [0.755,0.05,0.855,0.06,1,1]
                        duration: 150
                    }
                }
            }
            to: "selected,normal"
            from: "selected,normal"
        }
    ]
}

/*##^##
Designer {
    D{i:0}D{i:1}D{i:6;transitionDuration:2000}D{i:17;transitionDuration:2000}D{i:28;transitionDuration:2000}
}
##^##*/
