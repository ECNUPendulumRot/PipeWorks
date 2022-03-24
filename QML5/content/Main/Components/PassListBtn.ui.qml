import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control

    property string type: "listBtn"
    property int col: 0
    property bool haveRead: false
    property bool flag: true
    width: 150

    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 3
    rightPadding: 3

    text: "My Button"
    property alias text1Text: text1.text
    state: ""

    autoExclusive: true
    checkable: true
    display: AbstractButton.TextOnly

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#00000000"
        implicitWidth: 66
        implicitHeight: 27
        opacity: enabled ? 1 : 0.3
        radius: 8
        border.color: "#047eff"
        border.width: 0
    }

    contentItem: textItem
    Text {
        id: textItem

        opacity: enabled ? 1.0 : 0.3
        color: "#6a6a6a"
        text: control.text
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 14

        Text {
            id: text1
            color: "#6a6a6a"
            anchors.fill: parent
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 25
        }
    }

    Rectangle {
        id: rectangle
        height: 2
        color: "#cecece"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -1
    }
    states: [
        State {
            name: "normal"
        },
        State {
            name: "checked"
            when: control.checked && !haveRead && flag
        },
        State {
            name: "readin"
            when: !control.checked && haveRead && flag

            PropertyChanges {
                target: textItem
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 30
            }

            PropertyChanges {
                target: buttonBackground
                opacity: 0.7
                color: "#c67171"
            }
        },
        State {
            name: "readinnoflag"
            when: !control.checked && haveRead && !flag

            PropertyChanges {
                target: textItem
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 30
            }

            PropertyChanges {
                target: buttonBackground
                opacity: 0.7
                color: "#6c81bd"
            }
        },
        State {
            name: "readinChecked"
            when: control.checked && haveRead && flag

            PropertyChanges {
                target: textItem
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 30
            }

            PropertyChanges {
                target: buttonBackground
                opacity: 0.7
                color: "#c67171"
                border.color: "#ff0404"
                border.width: 3
            }
        },
        State {
            name: "readinnoflagChecked"
            when: control.checked && haveRead && !flag

            PropertyChanges {
                target: textItem
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 30
            }

            PropertyChanges {
                target: buttonBackground
                opacity: 0.7
                color: "#6c81bd"
                border.width: 3
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:27;width:130}
}
##^##*/

