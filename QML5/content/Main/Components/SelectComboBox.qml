import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Studio.Effects 1.0
import "../../../../QML5/imports/QML5"

ComboBox {
    id: control
    x: 50
    y: 50
    width: 300
    height: 30
    padding: 0
    font.pixelSize: 12
    currentIndex: -1
    displayText: if(!(currentIndex + 1)) "选择数据类型"
    model: ["边停时间", "摆宽", "摆动频率", "送丝速度", "电弧修正", "小车速度", "干伸高度值"]

    onCurrentIndexChanged: cmbBxCallSelect(indexMap[currentIndex])

    property var indexMap: {
        0:1,
        1:2,
        2:3,
        3:4,
        4:5,
        5:7,
        6:8
      }

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
                font.pixelSize: 10
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        background: Rectangle {
            id:deleBackground
            anchors.fill: parent
            color: element.pressed ? "#D2D2D2" : "transparent"
            border.width: 0
            radius: 8


            layer.enabled: true
            layer.effect: DropShadowEffect {
                color: "#3f000000"
                radius: 12
                spread: 0.1
                verticalOffset: 1.5
                horizontalOffset: 0
            }
        }
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding - 10
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
        leftPadding: 10
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: "#202020"
        verticalAlignment: Text.AlignVCenter
        anchors.left: parent.left
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 240
        implicitHeight: 30
        color: control.pressed ? "#D3D3D3" : "#E7E7E7"
        border.color: "#D3D3D3"
        border.width: control.visualFocus ? 2 : 1
        radius: 8

        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            color: "#3f000000"
            radius: 12
            spread: 0.2
            verticalOffset: 1.5
            horizontalOffset: 0
        }

    }

    popup: Popup {
        id: popup
        y: control.height + 2
        implicitWidth: control.width
        implicitHeight: 140
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
            radius: 8


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
            cmbBxCallSelect(indexMap[currentIndex])
    }

    function cmbBxCallSelect(index){
        if(scheduler.isPdbLoaded())
            scheduler.callAngleTable(index)
    }
}




/*##^##
Designer {
    D{i:0;height:30;width:170}
}
##^##*/
