import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

Popup {
    id: popup
    width: 400
    height: 200

    implicitWidth: 400
    implicitHeight: 200

    property alias confirmBtn: confirmBtn
    property alias cancelBtn: cancelBtn
    property alias completeBtn: completeBtn

    property alias imageSource : image.source
    property alias title: titleText.text
    property alias text : textContent

    closePolicy: Popup.NoAutoClose

    Overlay.modal: Rectangle {
        color: "#c0515151"
    }
    modal: true

    background:bg
    Rectangle {
        id: bg
        radius: 5
        border.color: "#d3d3d3"
        border.width: 2
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#d0d0d0"
            }

            GradientStop {
                position: 0.52055
                color: "#dcdcdc"
            }

            GradientStop {
                position: 1
                color: "#d4d4d4"
            }

            orientation: Gradient.Horizontal
        }
    }

    Item {
        id: content
        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        ColumnLayout {
            id: column
            anchors.fill: parent

            Item {
                id: titleContent
                width: 200
                height: 200
                Layout.bottomMargin: 0
                Layout.topMargin: 0
                Layout.preferredHeight: 50
                Layout.fillWidth: true

                Image {
                    id: image
                    y: 0
                    width: 34
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "qrc:/qtquickplugin/images/template_image.png"
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: titleText
                    height: 35
                    text: qsTr("Text")
                    anchors.verticalCenter: image.verticalCenter
                    anchors.left: image.right
                    anchors.right: parent.right
                    font.pixelSize: 21
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.weight: Font.Medium
                    anchors.leftMargin: 10
                }
            }

            Text {
                id: textContent
                text: qsTr("Text")
                font.pixelSize: 14
                Layout.rightMargin: 10
                Layout.preferredHeight: 80
                Layout.leftMargin: 45
                Layout.fillWidth: true

                wrapMode: Text.Wrap
            }

            Item {
                id: buttonContent
                width: 200
                height: 200
                Layout.preferredHeight: 40
                Layout.fillWidth: true

                ConfirmBtn {
                    id: cancelBtn

                    width: 70
                    height: 24
                    text: "继续编辑"
                    anchors.verticalCenter: confirmBtn.verticalCenter
                    anchors.right: confirmBtn.left
                    anchors.rightMargin: 15
                }

                ConfirmBtn {
                    id: confirmBtn

                    width: 70
                    height: 24
                    text: "应用"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    pressRecColor: "#00101010"
                    textItemColor: "#f6f6f6"
                    buttonBackgroundColor: "#3b7ecc"
                }

                ConfirmBtn {
                    id: completeBtn
                    width: 70
                    height: 24
                    text: "完成"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    pressRecColor: "#00101010"
                    textItemColor: "#f6f6f6"
                    buttonBackgroundColor: "#3b7ecc"
                    visible: false
                }
            }
        }
    }

}
