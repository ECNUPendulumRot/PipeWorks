import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import "../../../../../QML5/imports/QML5"

Rectangle {
    id: rectangle6
    width: 140
    height: 30
    visible: true
    color: "#00ebebeb"
    property alias inputColor: textField.color
    property alias inputText: textField.text
    property alias text7Text: text7.text

    property string permission : "true"

    property alias row : textField.row
    property alias col : textField.col
    property alias value : textField.value

    signal dataAccepted(string value);

    Text {
        id: text7
        x: 0
        color: Constants.tableFontColor
        text: qsTr("地址")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        font.family: "Microsoft Yahei"
        minimumPointSize: 14
    }

    FixedTextField {
        id: textField
        x: 40
        width: 60
        height: 16
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        anchors.verticalCenterOffset: 0
        property int row
        property int col
        property string value
        onEditingFinished: rectangle6.dataAccepted(textField.text);

    }
    function clear(){
        textField.text=""
    }
    states: [
        State {
            name: "disabled"
            when: !rectangle6.enabled

            PropertyChanges {
                target: textField
                opacity: 0.5
            }
        }
    ]
}


