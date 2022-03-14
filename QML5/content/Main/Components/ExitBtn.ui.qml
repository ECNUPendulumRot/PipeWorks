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
        source: "../../images/power-off-red.png"
        antialiasing: true
        mipmap: true
        sourceSize.height: 256
        sourceSize.width: 256
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        fillMode: Image.PreserveAspectFit
    }
    states: [
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
    D{i:0;formeditorZoom:3;height:54;width:50}
}
##^##*/

