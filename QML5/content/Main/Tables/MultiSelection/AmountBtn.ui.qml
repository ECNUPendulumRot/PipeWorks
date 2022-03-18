import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control
    width: 30
    height: 30

    implicitWidth: buttonBackground.implicitWidth
    implicitHeight: buttonBackground.implicitHeight

    text: "My Button"
    property alias imageSource: image.source
    display: AbstractButton.IconOnly

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00000000"
        implicitWidth: 30
        implicitHeight: 30
        opacity: enabled ? 1 : 0.3
        radius: 2
        border.color: "#047eff"
        border.width: 0
        anchors.fill: parent
    }

    contentItem: image
    Image {
        id: image
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: parent.bottom
        source: "qrc:/qtquickplugin/images/template_image.png"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
}
