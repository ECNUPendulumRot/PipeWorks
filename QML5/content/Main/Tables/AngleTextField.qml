import QtQuick 2.15
import QtQuick.Controls 2.12

TextField {
    id: textField
    width: 60
    height: 30

    property alias backgroundColor: bg.color

    color: "#0d0d0d"
    font.pixelSize: 12
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.family: "Microsoft YaHei"
    font.weight: Font.Medium
    placeholderText: "0.00"

    implicitWidth: 60
    implicitHeight: 30

    selectByMouse: true

    property string type : "editable"

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

    function disable(){
        textField.activeFocusOnPress = false;
        textField.activeFocusOnTab = false;
    }

    function enable(){
        textField.activeFocusOnPress = true;
        textField.activeFocusOnTab = true;
    }
}

/*##^##
Designer {
    D{i:0}D{i:1}D{i:6;transitionDuration:2000}D{i:17;transitionDuration:2000}D{i:28;transitionDuration:2000}
}
##^##*/
