import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control
    width: 50
    height: 54

    rightPadding: 4

    text: "My Button"
    display: AbstractButton.IconOnly
    flat: false

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00000000"

        opacity: enabled ? 1 : 0.3
        radius: 2
        border.color: "#047eff"
        border.width: 0
        anchors.fill: parent
    }

    Image {
        id: poweroff
        x: 0
        y: 0
        opacity: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        source: "../../images/user.png"
        antialiasing: false
        mipmap: false
        sourceSize.height: 256
        sourceSize.width: 256
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        fillMode: Image.PreserveAspectFit
    }
    states: [
        State {
            name: "hover"
            when: control.hovered && !control.pressed

            PropertyChanges {
                target: poweroff
                opacity: 0.7
                //border.color: "#8c8c8c"
            }
        },
        State {
            name: "pressed"
            when: control.pressed

            PropertyChanges {
                target: buttonBackground
                color: "#b0b0b0"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3;height:54;width:50}D{i:1}D{i:2}
}
##^##*/

