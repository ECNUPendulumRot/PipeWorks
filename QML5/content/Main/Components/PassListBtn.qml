import QtQuick 2.15
import QtQuick.Controls 2.12

Button {
    id: control

    property string type: "listBtn"
    property int col: 0
    property bool haveRead: false
    property bool flag: false
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
    property alias passEditBtnVisible: passEditBtn.visible
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
        radius: 2
        border.color: "#047eff"
        border.width: 0
    }

    PassEditBtn {
        id: passEditBtn
        x: 5
        y: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        textItemText: flag ? "√" : ""
        textItemFontpixelSize: 15
        anchors.leftMargin: 8
        onClicked: {
            if(haveRead)
                flag = !flag
        }
    }

    contentItem: textItem
    Text {
        id: textItem

        opacity: enabled ? 1.0 : 0.3
        color: "#000000"
        text: control.text
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 14

        Text {
            id: text1
            color: "#000000"
            anchors.fill: parent
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 35
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
            when: !control.checked && !haveRead
        },
        State {
            name: "checked"
            when: control.checked && !haveRead
        },
        State {
            name: "readin"
            when: !control.checked && haveRead

            PropertyChanges {
                target: textItem
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 35
            }

            PropertyChanges {
                target: buttonBackground
                //opacity: 0.7
                //color: "#c67171"
            }
        },
        State {
            name: "readinChecked"
            when: control.checked && haveRead

            PropertyChanges {
                target: textItem
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 40
            }

            PropertyChanges {
                target: buttonBackground
                //opacity: 0.7
                //color: "#c67171"
                border.color: "#045ba4"
                border.width: 3
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66;height:27;width:130}
}
##^##*/

