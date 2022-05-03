import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control
    width: 40
    height: 25
    leftPadding: 4
    rightPadding: 4

    text: ""
    display: AbstractButton.IconOnly

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00000000"
        implicitWidth: 60
        implicitHeight: 25
        opacity: enabled ? 1 : 0.3
        radius: 2
        border.color: "#047eff"
        border.width: 0
        anchors.fill: parent
    }

    Image {
        id: mainIcon
        width: 33
        height: 22
        anchors.verticalCenter: parent.verticalCenter
        source: "../../images/DpLogoMain.png"
        antialiasing: false
        mipmap: false
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:30;width:35}D{i:1}D{i:2}
}
##^##*/

