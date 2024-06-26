﻿import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Studio.Effects 1.0
import QtQuick.Studio.Components 1.0
import "../../../../QML5/imports/QML5"

Rectangle{
    id: rectangle
    width: 200
    height: 30
    color: "#00202020"
    border.color: "#ffffff"
    border.width: 0
    property alias controlWidth: control.width
    property alias controlAnchorsleftMargin: control.anchors.leftMargin
    property alias labelText: label.text
    property alias textFieldText: control.currentIndex
    property alias textFieldColor:content.color
    property alias cbxModel: control.model
    property string mapString
    property string type : "editable"

    property string defaultString
    signal dataChanged(string s, var text)

    Label {
        id: label
        x: 5
        text: qsTr("跟踪状态")
        color: Constants.tableFontColor
        font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    ComboBox {
        id: control
        width: 60
        height: 20
        editable: true
        anchors.verticalCenter: label.verticalCenter
        anchors.left: label.left
        padding: 0
        font.pixelSize: 12
        anchors.leftMargin: 64
        currentIndex: -1
        displayText: if(!(currentIndex + 1)) defaultString
        model: ["0:N", "1:H", "2:V", "3:B"]

        onCurrentIndexChanged: cmbBxCallSelect(rectangle.mapString, currentIndex)

        delegate: ItemDelegate {
            id: element
            width: control.width - 20
            height: control.height
            padding: 0
            highlighted: control.highlightedIndex === index

            contentItem: Item {

                anchors.fill: parent

                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#cecece"
                    border.width: 0
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    //radius: 8
                }

                Text {
                    text: modelData
                    color: "#202020"
                    //font: control.font
                    elide: Text.ElideRight
                    font.pixelSize: 11
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            background: Rectangle {
                id:deleBackground
                anchors.fill: parent
                color: element.pressed ? "#D2D2D2" : "transparent"
                border.width: 0
                radius: 4


                layer.enabled: true

            }
        }

        indicator: Canvas {
            id: canvas
            x: control.width - width - control.rightPadding
            y: control.topPadding + (control.availableHeight - height) / 2
            width: 8
            height: 6
            contextType: "2d"

            Connections {
                target: control
                function onPressedChanged() { canvas.requestPaint(); }
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = control.pressed ? "#E7E7E7" : "#202020";
                context.fill();
            }
        }

        contentItem: Text {
            id:content
            leftPadding: 4
            rightPadding: control.indicator.width + control.spacing

            text: control.displayText
            font: control.font
            color: "#202020"
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: control.width
            implicitHeight: control.height
            color: control.pressed ? "#D3D3D3" : "#E7E7E7"
            border.color: "#D3D3D3"
            border.width: control.visualFocus ? 2 : 1
            radius: 4
            layer.enabled: true
        }

        popup: Popup {
            id: popup
            y: control.height + 2
            implicitWidth: control.width
            implicitHeight: 83
            padding: 0

            contentItem: ListView {
                topMargin: 1
                leftMargin: 10
                clip: true
                implicitWidth: contentWidth
                implicitHeight: contentHeight
                spacing: 2
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                id:popBg
                //z:3
                anchors.fill: parent
                color: "#e7e7e7"
                border.color: "#D3D3D3"
                border.width: 0
                radius: 4


            }

            enter: Transition {
                NumberAnimation { property: "height"; running: false; easing.bezierCurve: [0.454,0.00593,0.476,1,1,1]; from: 0.0; to: popup.implicitHeight; duration: 100}
            }

            exit: Transition{
                NumberAnimation { property: "height"; easing.bezierCurve: [0.484,0.004,0.436,0.996,1,1]; from: popup.height; to: 0.0; duration: 200}
            }
        }

        function cmbBxParameterSelect(){
            if(currentIndex === -1)
                currentIndex = 0;
            else
                cmbBxCallSelect(currentIndex)
        }

        function cmbBxCallSelect(s, index){// write data into database
            dataChanged(s,index)
        }

    }
    function clear(){
        control.currentIndex= -1
    }
}



/*##^##
Designer {
    D{i:0;height:30;width:150}
}
##^##*/
