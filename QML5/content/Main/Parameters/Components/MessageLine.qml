import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0

Rectangle {
    id: rectangle6
    width: 140
    height: 30
    visible: true
    color: "#00ebebeb"
    property alias inputColor: input.color
    property alias inputText: input.text
    property alias text7Text: text7.text
    property alias row : input.row
    property alias col : input.col
    property alias value : input.value
    signal dataAccepted(string value);
    Text {
        id: text7
        x: 0
        color: "#808080"
        text: qsTr("地址")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        minimumPointSize: 14
    }

    FixedTextField {
        id: input
        x: 40
        width: 60
        height: 16
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 12
        anchors.verticalCenterOffset: 0
        property int row
        property int col
        property string value
        onEditingFinished: rectangle6.dataAccepted(input.text);
    }
}


