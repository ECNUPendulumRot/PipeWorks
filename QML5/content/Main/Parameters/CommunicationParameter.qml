import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components 1.0
import "Components"
import QtQuick.Layouts 1.0
import "../../../../QML5/imports/QML5"
Item {
    id: rectangle
    width: myGroupTitle2.width
    height: myGroupTitle2.height

    MyGroupTitle2 {
        id: myGroupTitle2
        width: 530
        height: 195
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        label4FontpixelSize: 14
        label4Color: "#202020"
        label4Text: "通讯参数配置"

    }

    Item {
        id: content
        x: 43
        y: 25
        width: 445
        height: 146

        Text {
            id: text2
            x: 43
            y: 51
            height: 30
            color: Constants.tableFontColor
            text: qsTr("倾角仪")
            anchors.left: text1.left
            anchors.top: text1.bottom
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text3
            x: 43
            y: 81
            height: 30
            color: Constants.tableFontColor
            text: qsTr("采集卡")
            anchors.left: text2.left
            anchors.top: text2.bottom
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text4
            x: 43
            y: 111
            height: 30
            color: Constants.tableFontColor
            text: qsTr("手持盒")
            anchors.left: text1.left
            anchors.top: text3.bottom
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text5
            x: 43
            y: 141
            height: 30
            color: Constants.tableFontColor
            text: qsTr("电机")
            anchors.left: text1.left
            anchors.top: text4.bottom
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
        }

        MessageLine {
            id: angles
            x: 105
            y: 51
            anchors.left: qcode.left
            anchors.top: qcode.bottom
            text7Text: "倾角仪"
        }

        MessageLine {
            id: captureCard
            x: 105
            y: 81
            anchors.left: angles.left
            anchors.top: angles.bottom
            text7Text: "采集卡"
        }

        MessageLine {
            id: box
            x: 105
            y: 111
            anchors.left: captureCard.left
            anchors.top: captureCard.bottom
            text7Text: "手持盒"
        }

        MessageLine {
            id: motion
            x: 105
            y: 141
            anchors.left: box.left
            anchors.top: box.bottom
            anchors.topMargin: 0
            text7Text: "电机"
        }

        MessageLine {
            id: qcode1
            x: 245
            y: 21
            anchors.left: qcode.right
            anchors.top: qcode.top
            anchors.topMargin: 0
            text7Text: "波特率"
        }

        MessageLine {
            id: angles1
            x: 245
            y: 51
            anchors.left: qcode1.left
            anchors.top: qcode1.bottom
            anchors.topMargin: 0
            text7Text: "波特率"
        }

        MessageLine {
            id: captureCard1
            x: 245
            y: 81
            anchors.left: angles1.left
            anchors.top: angles1.bottom
            text7Text: "波特率"
        }

        MessageLine {
            id: box1
            x: 245
            y: 111
            anchors.left: captureCard1.left
            anchors.top: captureCard1.bottom
            text7Text: "波特率"
            anchors.topMargin: 0
        }

        MessageLine {
            id: motion1
            x: 245
            y: 141
            anchors.left: box1.left
            anchors.top: box1.bottom
            text7Text: "波特率"
            anchors.topMargin: 0
        }

        MessageLine {
            id: qcode2
            x: 385
            y: 21
            anchors.left: qcode1.right
            anchors.top: qcode1.top
            text7Text: "频率"
        }

        MessageLine {
            id: angles2
            x: 385
            y: 51
            anchors.left: qcode2.left
            anchors.top: qcode2.bottom
            anchors.topMargin: 0
            text7Text: "频率"
        }

        MessageLine {
            id: captureCard2
            x: 385
            y: 81
            anchors.left: angles2.left
            anchors.top: angles2.bottom
            anchors.topMargin: 0
            text7Text: "频率"
        }

        MessageLine {
            id: box2
            x: 385
            y: 111
            anchors.left: captureCard2.left
            anchors.top: captureCard2.bottom
            anchors.topMargin: 0
            text7Text: "频率"
        }

        MessageLine {
            id: motion2
            x: 385
            y: 141
            anchors.left: box2.left
            anchors.top: box2.bottom
            anchors.topMargin: 0
            text7Text: "频率"
        }

        Text {
            id: text1
            height: 30
            color: Constants.tableFontColor
            text: qsTr("Qrcode")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
        }

        MessageLine {
            id: qcode
            x: 105
            y: 21
            width: 140
            height: 30
            anchors.left: text1.right
            anchors.top: text1.top
            anchors.leftMargin: 20
        }
    }


    function refreshData(){
        getData()
        getColor()
    }

    function getData(){
        angles.inputText = comFTableModel.fixedTablePopData(0, "ComAdress");
        angles1.inputText = comFTableModel.fixedTablePopData(0, "ComBaudrate").toString();
        angles2.inputText = comFTableModel.fixedTablePopData(0, "ComFreq");

        box.inputText = comFTableModel.fixedTablePopData(1, "ComAdress");
        box1.inputText =   comFTableModel.fixedTablePopData(1, "ComBaudrate").toString();
        box2.inputText =  comFTableModel.fixedTablePopData(1, "ComFreq");

        captureCard.inputText =  comFTableModel.fixedTablePopData(2, "ComAdress");
        captureCard1.inputText =  comFTableModel.fixedTablePopData(2, "ComBaudrate").toString();
        captureCard2.inputText =  comFTableModel.fixedTablePopData(2, "ComFreq");

        motion.inputText =  comFTableModel.fixedTablePopData(3, "ComAdress");
        motion1.inputText =  comFTableModel.fixedTablePopData(3, "ComBaudrate").toString();
        motion2.inputText =  comFTableModel.fixedTablePopData(3, "ComFreq");


        qcode.inputText =  comFTableModel.fixedTablePopData(4, "ComAdress");
        qcode1.inputText =   comFTableModel.fixedTablePopData(4, "ComBaudrate").toString();
        qcode2.inputText = comFTableModel.fixedTablePopData(4, "ComFreq");
    }

    function  writeInData(){
        comFTableModel.callSetData(4,2,qcode.inputText);
        comFTableModel.callSetData(4,3,qcode1.inputText);
        comFTableModel.callSetData(4,4,qcode2.inputText);

        comFTableModel.callSetData(0,2,angles.inputText);
        comFTableModel.callSetData(0,3,angles1.inputText);
        comFTableModel.callSetData(0,4,angles2.inputText);

        comFTableModel.callSetData(2,2,captureCard.inputText);
        comFTableModel.callSetData(2,3,captureCard1.inputText);
        comFTableModel.callSetData(2,4,captureCard2.inputText);

        comFTableModel.callSetData(1,2,box.inputText);
        comFTableModel.callSetData(1,3,box1.inputText);
        comFTableModel.callSetData(1,4,box2.inputText);

        comFTableModel.callSetData(3,2,motion.inputText);
        comFTableModel.callSetData(3,3,motion1.inputText);
        comFTableModel.callSetData(3,4,motion2.inputText);
    }


    function clearData(){
        angles.inputText        = "";
        angles1.inputText       = "";
        angles2.inputText       = "";

        box.inputText           = "";
        box1.inputText          = "";
        box2.inputText          = "";

        captureCard.inputText   = "";
        captureCard1.inputText  = "";
        captureCard2.inputText  = "";

        motion.inputText        = "";
        motion1.inputText       = "";
        motion2.inputText       = "";


        qcode.inputText         = "";
        qcode1.inputText        = "";
        qcode2.inputText        = "";

    }

    function getColor(){
        qcode.inputColor = comFTableModel.callIsDirty(4,2)?"#cc5555":"#0d0d0d";
        qcode1.inputColor = comFTableModel.callIsDirty(4,3)?"#cc5555":"#0d0d0d";
        qcode2.inputColor = comFTableModel.callIsDirty(4,4)?"#cc5555":"#0d0d0d";

        angles.inputColor = comFTableModel.callIsDirty(0,2)?"#cc5555":"#0d0d0d";
        angles1.inputColor = comFTableModel.callIsDirty(0,3)?"#cc5555":"#0d0d0d";
        angles2.inputColor = comFTableModel.callIsDirty(0,4)?"#cc5555":"#0d0d0d";

        captureCard.inputColor = comFTableModel.callIsDirty(2,2)?"#cc5555":"#0d0d0d";
        captureCard1.inputColor = comFTableModel.callIsDirty(2,3)?"#cc5555":"#0d0d0d";
        captureCard2.inputColor = comFTableModel.callIsDirty(2,4)?"#cc5555":"#0d0d0d";

        box.inputColor = comFTableModel.callIsDirty(1,2)?"#cc5555":"#0d0d0d";
        box1.inputColor = comFTableModel.callIsDirty(1,3)?"#cc5555":"#0d0d0d";
        box2.inputColor = comFTableModel.callIsDirty(1,4)?"#cc5555":"#0d0d0d";

        motion.inputColor = comFTableModel.callIsDirty(3,2)?"#cc5555":"#0d0d0d";
        motion1.inputColor = comFTableModel.callIsDirty(3,3)?"#cc5555":"#0d0d0d";
        motion2.inputColor = comFTableModel.callIsDirty(3,4)?"#cc5555":"#0d0d0d";
    }

    function disableInput(item){
        if(item.permission === "true"){
            item.enabled = false;
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            disableInput(item.children[i]);
        return;
    }
}










/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}D{i:1}D{i:3}D{i:4}D{i:5}D{i:6}D{i:7}D{i:8}D{i:9}D{i:10}
D{i:11}D{i:12}D{i:13}D{i:14}D{i:15}D{i:16}D{i:17}D{i:18}D{i:19}D{i:20}D{i:21}D{i:22}
D{i:2}
}
##^##*/
