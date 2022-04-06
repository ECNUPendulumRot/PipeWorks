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

//Switch {
//    id: control

//    implicitWidth: backgroundItem.implicitWidth
//    implicitHeight: backgroundItem.implicitHeight

//    readonly property int baseSize: 12

//    background: backgroundItem
//    Rectangle {
//        id: backgroundItem
//        color: "#00000000"
//        implicitWidth: control.baseSize * 6.0
//        implicitHeight: control.baseSize * 3.8
//    }

//    leftPadding: 4

//    indicator: switchHandle
//    Rectangle {
//        id: switchHandle
//        implicitWidth: control.baseSize * 4.8
//        implicitHeight: control.baseSize * 2.6
//        x: control.leftPadding
//        height: 25
//        color: "#e9e9e9"
//        radius: 4
//        border.width: 1
//        anchors.verticalCenter: parent.verticalCenter

//        Rectangle {
//            id: rectangle

//            width: control.baseSize * 2.6
//            height: switchHandle.height
//            color: "#e9e9e9"
//            radius: 4
//            anchors.verticalCenter: parent.verticalCenter
//        }
//    }
//    states: [
//        State {
//            name: "off"
//            when: !control.checked && !control.down

//            PropertyChanges {
//                target: rectangle
//                color: "#cccccc"
//            }

//            PropertyChanges {
//                target: switchHandle
//                color: "#00000000"
//                border.color: "#2e2e2e"
//            }
//        },
//        State {
//            name: "on"
//            when: control.checked && !control.down

//            PropertyChanges {
//                target: switchHandle
//                color: "#0d267b"
//                border.color: "#2e2e2e"
//            }

//            PropertyChanges {
//                target: rectangle
//                x: parent.width - width
//            }
//        },
//        State {
//            name: "off_down"
//            when: !control.checked && control.down

//            PropertyChanges {
//                target: rectangle
//                color: "#e9e9e9"
//            }

//            PropertyChanges {
//                target: switchHandle
//                color: "#00000000"
//                border.color: "#2e2e2e"
//            }
//        },
//        State {
//            name: "on_down"
//            when: control.checked && control.down

//            PropertyChanges {
//                target: rectangle
//                x: parent.width - width
//                color: "#cccccc"
//            }

//            PropertyChanges {
//                target: switchHandle
//                color: "#b0c4de"
//                border.color: "#2e2e2e"
//            }
//        }
//    ]
//}
