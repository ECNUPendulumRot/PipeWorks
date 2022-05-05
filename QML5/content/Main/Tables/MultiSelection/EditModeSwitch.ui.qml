import QtQuick 2.15
import QtQuick.Controls 2.12

Switch {
    id: control
    text: qsTr("增量")
    font.family: "Microsoft Yahei"
    font.pixelSize: 12

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 25
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 12
        color: control.checked ? "#1c76c2" : "#1c76c2"
        border.color: control.checked ? "#045ba4" : "#045ba4"
        border.width:2

        Rectangle {
            x: control.checked ? parent.width - width : 0
            width: 25
            height: 25
            radius: 12
            color: control.down ? "#cccccc" : "#ffffff"
            border.color: control.checked ? (control.down ? "#045ba4" : "#045ba4") : "#045ba4"
            border.width:2
        }
    }

    contentItem: Text {
        text: control.checked?qsTr("绝对量"):qsTr("增量")
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#000000" : "#000000"
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }

}

