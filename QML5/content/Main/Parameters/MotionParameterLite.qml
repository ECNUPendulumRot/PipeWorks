import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components 1.0
import QtQuick.Layouts 1.15
import "Components"

Item {
    id: rectangle
    property int i: 0

    property var mapping:{
        "carWeldBeforeACC"          :0,
        "carWeldBeforeSPEED"        :1,
        "carWeldBeforeSTOPACC"      :2,
        "carWeldingACC"             :3,
        "carWeldingSPEED"           :4,
        "carWeldingSTOPACC"         :5,
        "LeadWidthIncrement"        :6,
        "LeadWidthDecrement"        :7,
        "TrailWidthIncrement"       :8,
        "TrailWidthDecrement"       :9,
        "LeadWelBeforeUpACC"        :10,
        "LeadWelBeforeUpSPEED"      :11,
        "LeadWelBeforeUpSTOPACC"    :12,
        "TrailWelBeforeUpACC"       :13,
        "TrailWelBeforeUpSPEED"     :14,
        "TrailWelBeforeUpSTOPACC"   :15,
        "LeadWelBeforeDownACC"      :16,
        "LeadWelBeforeDownSPEED"    :17,
        "LeadWelBeforeDownSTOPACC"  :18,
        "TrailWelBeforeDownACC"     :19,
        "TrailWelBeforeDownSPEED"   :20,
        "TrailWelBeforeDownSTOPACC" :21,
        "LeadWelingUpACC"           :22,
        "LeadWelingUpSPEED"         :23,
        "LeadWelingUpChangeness"    :24,
        "TrailWelingUpACC"          :25,
        "TrailWelingUpSPEED"        :26,
        "TarilWelingUpChangeness"   :27,
        "LeadWelingDownACC"         :28,
        "LeadWelingDownSPEED"       :29,
        "LeadWelingDownChangeness"  :30,
        "TrailWelingDownACC"        :31,
        "TrailWelingDownSPEED"      :32,
        "TarilWelingDownChangeness" :33,
        "LeadWelBeforeOutACC"       :34,
        "LeadWelBeforeOutSPEED"     :35,
        "LeadWelBeforeOutSTOPACC"   :36,
        "TrailWelBeforeOutACC"      :37,
        "TrailWelBeforeOutSPEED"    :38,
        "TrailWelBeforeOutSTOPACC"  :39,
        "LeadWelBeforeInACC"        :40,
        "LeadWelBeforeInSPEED"      :41,
        "LeadWelBeforeInSTOPACC"    :42,
        "TrailWelBeforeInACC"       :43,
        "TrailWelBeforeInSPEED"     :44,
        "TrailWelBeforeInSTOPACC"   :45,
        "LeadWelingOutChangeness"   :46,
        "TarilWelingOutChangeness"  :47,
        "LeadWelingInChangeness"    :48,
        "TarilWelingInChangeness"   :49,
        "testOscFreq"               :50,
        "jogWeldFeedSpeedPercent"   :51,
        "pipeDiameter"              :52,
        "parameterInterval"         :53,
//        "arcStartDistance"          :52,
//        "pipeDiameter"              :53,
//        "arcEndDistance"            :54,
//        "parameterInterval"         :55,
//        "facingStartDistance"       :56,
//        "facingEndDistance"         :57
    }

    property var mapping2:{
        "gunInverted"               :0,
        "verInverted"               :1,
        "horInverted"               :2,
        "travInverted"              :3
    }

    property var parameterList: [
        "carWeldBeforeACC",
        "carWeldBeforeSPEED",
        "carWeldBeforeSTOPACC",
        "carWeldingACC",
        "carWeldingSPEED",
        "carWeldingSTOPACC",
        "LeadWidthIncrement",
        "LeadWidthDecrement",
        "TrailWidthIncrement",
        "TrailWidthDecrement",
        "LeadWelBeforeUpACC",
        "LeadWelBeforeUpSPEED",
        "LeadWelBeforeUpSTOPACC",
        "TrailWelBeforeUpACC",
        "TrailWelBeforeUpSPEED",
        "TrailWelBeforeUpSTOPACC",
        "LeadWelBeforeDownACC",
        "LeadWelBeforeDownSPEED",
        "LeadWelBeforeDownSTOPACC",
        "TrailWelBeforeDownACC",
        "TrailWelBeforeDownSPEED",
        "TrailWelBeforeDownSTOPACC",
        "LeadWelingUpACC",
        "LeadWelingUpSPEED",
        "LeadWelingUpChangeness",
        "TrailWelingUpACC",
        "TrailWelingUpSPEED",
        "TarilWelingUpChangeness",
        "LeadWelingDownACC",
        "LeadWelingDownSPEED",
        "LeadWelingDownChangeness",
        "TrailWelingDownACC",
        "TrailWelingDownSPEED",
        "TarilWelingDownChangeness",
        "LeadWelBeforeOutACC",
        "LeadWelBeforeOutSPEED",
        "LeadWelBeforeOutSTOPACC",
        "TrailWelBeforeOutACC",
        "TrailWelBeforeOutSPEED",
        "TrailWelBeforeOutSTOPACC",
        "LeadWelBeforeInACC",
        "LeadWelBeforeInSPEED",
        "LeadWelBeforeInSTOPACC",
        "TrailWelBeforeInACC",
        "TrailWelBeforeInSPEED",
        "TrailWelBeforeInSTOPACC",
        "LeadWelingOutChangeness",
        "TarilWelingOutChangeness",
        "LeadWelingInChangeness",
        "TarilWelingInChangeness",
        "testOscFreq",
        "jogWeldFeedSpeedPercent",
//        "arcStartDistance",
        "pipeDiameter",
//        "arcEndDistance",
        "parameterInterval",
//        "facingStartDistance",
//        "facingEndDistance"
    ]

    property var parameterList2: [
        "gunInverted",
        "verInverted",
        "horInverted",
        "travInverted"
    ]
    width: content.width
    height: content.height

    GroupItem {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        id: content
        width: 620
        height: 310

        MyGroupTitle2 {
            id: myGroupTitle2
            x: 0
            y: 0
            width: content.width
            height: content.height
            color: "#00ebebeb"
            rectangle9Color: "#fafafa"
            label4FontpixelSize: 14
            label4Color: "#202020"
            label4Text: "运动参数配置"
        }

        GroupItem {
            id: groupItem
            y: 35
            anchors.horizontalCenter: parent.horizontalCenter
            GroupItem {
                id: group3
                x: 40
                y: 20
                MyEditLine4 {
                    id: parameterInterval
                    x: 0
                    y: 0
                    width: 220


                    textFieldAnchorsleftMargin: 90
                    label12AnchorsleftMargin: 70
                    label12Text: "毫米"
                    label11Text: "前后枪间距"
                    textFieldWidth: 60


                }

                MyEditLine4 {
                    id: testOscFreq
                    x: 0
                    y: 30
                    width: 220

                    textFieldAnchorsleftMargin: 90
                    label12AnchorsleftMargin: 70
                    label12Text: "次/分钟"
                    label11Text: "试摆摆次"
                    textFieldWidth: 60

                }

                MyEditLine4 {
                    id: pipeDiameter
                    x: 260
                    y: 0
                    width: 220

                    textFieldAnchorsleftMargin: 90
                    label12AnchorsleftMargin: 70
                    label12Text: "毫米"
                    label11Text: "管子直径"
                    textFieldWidth: 60

                }


                //TODO
                MyEditLine4 {
                    id: feedPercent
                    x: 260
                    y: 30
                    width: 220


                    textFieldAnchorsleftMargin: 90
                    label12AnchorsleftMargin: 70
                    textFieldWidth: 60

                }
            }

            GroupItem {
                x: 300
                anchors.top: group3.top
                anchors.topMargin: 0
//                MyEditLine4 {
//                    id: arcStart
//                    x: 0
//                    y: 0
//                    width: 220

//                    textFieldAnchorsleftMargin: 90
//                    label12AnchorsleftMargin: 70
//                    label12Text: "毫米"
//                    label11Text: "填充起弧距离"
//                    textFieldWidth: 60

//                }

//                MyEditLine4 {
//                    id: arcEnd
//                    x: 0
//                    y: 30
//                    width: 220

//                    textFieldAnchorsleftMargin: 90
//                    label12AnchorsleftMargin: 70
//                    label12Text: "毫米"
//                    label11Text: "填充收弧距离"
//                    textFieldWidth: 60

//                }

//                MyEditLine4 {
//                    id: facingStart
//                    x: 0
//                    y: 60
//                    width: 220

//                    textFieldAnchorsleftMargin: 90
//                    label12AnchorsleftMargin: 70
//                    label12Text: "毫米"
//                    label11Text: "盖面起弧距离"
//                    textFieldWidth: 60

//                }

//                MyEditLine4 {
//                    id: facingEnd
//                    x: 0
//                    y: 90
//                    width: 220

//                    textFieldAnchorsleftMargin: 90
//                    label12AnchorsleftMargin: 70
//                    label12Text: "毫米"
//                    label11Text: "盖面收弧距离"
//                    textFieldWidth: 60
//                }
            }

            MyGroupTitle2 {
                id: myGroupTitle3
                x: 0
                y: 0
                width: 560
                height: 100
                rectangle9Color: myGroupTitle2.rectangle9Color
                label4FontpixelSize: 12
                label4Color: "#202020"
                label4Text: "其他参数"
            }
        }

        GroupItem {
            id: groupItem1
            anchors.top: groupItem.bottom
            anchors.horizontalCenter: groupItem.horizontalCenter
            anchors.topMargin: 30
            GroupItem {
                id: group4
                x: 40
                y: 20
                height: 60
                MyEditLine4 {
                    id: gunInverted
                    x: 0
                    y: 0
                    width: 220
                    textFieldAnchorsleftMargin: 90
                    label11Text: "焊枪反置"
                    label12AnchorsleftMargin: 70
                    textFieldWidth: 60
                    label12Text: ""
                    type: "editable2"
                }

                MyEditLine4 {
                    id: travInverted
                    x: 0
                    y: 30
                    width: 220
                    textFieldAnchorsleftMargin: 90
                    label11Text: "小车行走反置"
                    label12AnchorsleftMargin: 70
                    textFieldWidth: 60
                    label12Text: ""
                    type: "editable2"
                }
            }

            GroupItem {
                x: 300
                height: 60
                anchors.top: group4.top
                MyEditLine4 {
                    id: verInverted
                    x: 0
                    y: 0
                    width: 220
                    textFieldAnchorsleftMargin: 90
                    label11Text: "垂向运动反置"
                    label12AnchorsleftMargin: 70
                    textFieldWidth: 60
                    label12Text: ""
                    type: "editable2"
                }

                MyEditLine4 {
                    id: horInverted
                    x: 0
                    y: 30
                    width: 220
                    textFieldAnchorsleftMargin: 90
                    label11Text: "横向运动反置"
                    label12AnchorsleftMargin: 70
                    textFieldWidth: 60
                    label12Text: ""
                    type: "editable2"
                }
                anchors.topMargin: 0
            }

            MyGroupTitle2 {
                id: myGroupTitle8
                x: 0
                y: 0
                width: 560
                height: 100
                rectangle9Color: myGroupTitle2.rectangle9Color
                label4FontpixelSize: 12
                label4Color: "#202020"
                label4Text: "机头切换"
            }
        }
    }

    Component.onCompleted: {
        initMapString();
        initPermission();
    }


    function writeInData(item){
        if(item.editEnabled){
            if(item.type === "editable"){
                motionFTableModel.callSetData(mapping[item.mapString], 3, item.textFieldText)
            }
            else if(item.type === "editable2"){
                systemFTableModel.callSetData(mapping2[item.mapString], 3, item.textFieldText)
            }
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            writeInData(item.children[i])
        return
    }



    function refreshData(item){
        if(item.exist){
            if(item.type === "editable"){
                item.textFieldText = motionFTableModel.fixedTablePopData(mapping[item.mapString],"parmeterValue");
                item.textFieldColor = motionFTableModel.callIsDirty(mapping[item.mapString],3) ? "#cc5555":"#0d0d0d";
                return;
            }
            else if(item.type === "editable2"){
                item.textFieldText = systemFTableModel.fixedTablePopData(mapping2[item.mapString],"value");
                item.textFieldColor = systemFTableModel.callIsDirty(mapping2[item.mapString],3) ? "#cc5555":"#0d0d0d";
                return;
            }
        }
        for(var i = 0; i < item.children.length; i++)
            refreshData(item.children[i])
        return
    }

    function clearData(item){
        if(item.type === "editable"){
            item.textFieldText = "";
            return;
        }
        else if(item.type === "editable2"){
            item.textFieldText = "";
            return;
        }

        for(var i = 0; i < item.children.length; i++)
            clearData(item.children[i])
        return
    }

    function disableInput(item){
        if(item.permission === "false"){
            item.enabled = false;
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            disableInput(item.children[i]);
        return;
    }

    function initPermission() {
        parameterInterval.permission     = "true"
        testOscFreq.permission           = "true"
        pipeDiameter.permission          = "true"
        feedPercent.permission           = "true"
//        arcStart.permission              = "true"
//        arcEnd.permission                = "true"
//        facingStart.permission           = "true"
//        facingEnd.permission             = "true"

        gunInverted.permission           = "true"
        travInverted.permission          = "true"
        verInverted.permission           = "true"
        horInverted.permission           = "true"
    }

    function initMapString() {
        parameterInterval.mapString     = parameterList[53]
//        parameterInterval.mapString     = parameterList[55]
        testOscFreq.mapString           = parameterList[50]
        pipeDiameter.mapString          = parameterList[52]
//        pipeDiameter.mapString          = parameterList[53]
        feedPercent.mapString           = parameterList[51]
//        arcStart.mapString              = parameterList[52]
//        arcEnd.mapString                = parameterList[54]
//        facingStart.mapString           = parameterList[56]
//        facingEnd.mapString             = parameterList[57]

        gunInverted.mapString           = parameterList2[0]
        travInverted.mapString          = parameterList2[3]
        verInverted.mapString           = parameterList2[1]
        horInverted.mapString           = parameterList2[2]
    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
