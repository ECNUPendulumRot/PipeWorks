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
        Column {
            id: bar
            x: 0
            y: 30
            width: myTab.width
            spacing: 0
            MyTab {
                id: myTab
                width: 100
                text: "小车与其他"
                activeFocusOnTab: false
                onClicked: i = 0
                checked: true
                checkable: true
                textItemFontpixelSize: 12
                autoExclusive: true
            }

            MyTab {
                id: myTab1
                width: 100
                activeFocusOnTab: false
                onClicked: i = 1
                checkable: true
                textItemFontpixelSize: 12
                autoExclusive: true
            }

            MyTab {
                id: myTab2
                width: 100
                text: "前焊枪竖直运动"
                activeFocusOnTab: false
                onClicked: i = 2
                checkable: true
                textItemFontpixelSize: 12
                autoExclusive: true
            }

            MyTab {
                id: myTab3
                width: 100
                text: "后焊枪水平运动"
                activeFocusOnTab: false
                onClicked: i = 3
                checkable: true
                textItemFontpixelSize: 12
                autoExclusive: true
            }

            MyTab {
                id: myTab4
                width: 100
                text: "后焊枪竖直运动"
                activeFocusOnTab: false
                onClicked: i = 4
                checkable: true
                textItemFontpixelSize: 12
                autoExclusive: true
            }
        }

        BorderItem {
            id: border2
            x: 0
            y: 230
            width: 100
            height: 340
            radius: 0
            drawLeft: false
            drawTop: true
            drawBottom: false
            strokeWidth: 1
            strokeColor: "#c1c1c1"
        }

        BorderItem {
            id: border3
            x: 0
            y: 30
            width: 100
            height: 200
            radius: 0
            drawRight: false
            drawLeft: true
            drawTop: true
            drawBottom: false
            strokeWidth: 1
            strokeColor: "#c1c1c1"
        }

        StackLayout {
            id: stack
            x: 100
            y: 30
            width: 612
            height: 540
            currentIndex: rectangle.i

            Rectangle {
                id: rectangle3

                color: "#ebebeb"
                border.width: 0


                Rectangle {
                    id: motionelse
                    width: 560
                    height: 440
                    color: "#ebebeb"
                    border.color: "#ffffff"
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    GroupItem {
                        x: 0
                        y: 0
                        width: 560
                        height: 180
                        MyGroupTitle2 {
                            id: rectangle8
                            x: 0
                            y: 0
                            width: 560
                            height: 180
                            label4FontpixelSize: 12
                            label4Color: "#202020"

                        }

                        MyGroupTitle {
                            id: rectangle1
                            x: 40
                            y: 25
                            width: 220
                            height: 130
                            radius: 4
                            labelColor: "#202020"
                            labelText: "起弧前"
                        }

                        ColumnLayout {
                            id: col1
                            x: 168
                            y: -76
                            anchors.verticalCenter: rectangle1.verticalCenter
                            anchors.left: rectangle1.left
                            spacing: 0
                            MyEditLine {
                                id: carSpeedBefore

                                label1AnchorsleftMargin: 70
                                labelText: "运动速度"
                                textFieldAnchorsleftMargin: 70
                                label1Text: "毫米/分钟"
                                textFieldWidth: 60
                            }

                            MyEditLine {
                                id: carAccBefore


                                label1AnchorsleftMargin: 70
                                labelText: "运动加速度"
                                textFieldAnchorsleftMargin: 70
                                label1Text: "毫米/秒<sup>2<sup>"
                                textFieldWidth: 60


                            }

                            MyEditLine {
                                id: carStopAccBefore

                                label1AnchorsleftMargin: 70
                                textFieldAnchorsleftMargin: 70
                                textFieldWidth: 60



                            }
                            anchors.leftMargin: 10
                        }

                        MyGroupTitle {
                            id: rectangle2
                            x: 300
                            y: rectangle1.y
                            width: rectangle1.width
                            height: rectangle1.height
                            radius: 4
                            labelColor: "#202020"
                            labelText: "起弧后"
                        }

                        ColumnLayout {
                            x: 159
                            anchors.verticalCenter: rectangle2.verticalCenter
                            anchors.left: rectangle2.left
                            spacing: col1.spacing
                            MyEditLine {
                                id: carSpeed

                                label1AnchorsleftMargin: 70
                                labelText: "运动速度"
                                textFieldAnchorsleftMargin: 70
                                label1Text: "毫米/分钟"
                                textFieldWidth: 60


                            }

                            MyEditLine {
                                id: carAcc

                                label1AnchorsleftMargin: 70
                                labelText: "运动加速度"
                                textFieldAnchorsleftMargin: 70
                                label1Text: "毫米/秒<sup>2<sup>"
                                textFieldWidth: 60


                            }

                            MyEditLine {
                                id: carStopAcc


                                label1AnchorsleftMargin: 70
                                textFieldAnchorsleftMargin: 70
                                textFieldWidth: 60

                            }
                            anchors.leftMargin: col1.anchors.leftMargin
                        }
                    }

                    GroupItem {
                        id: groupItem
                        x: 0
                        y: 210
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
//                            MyEditLine4 {
//                                id: arcStart
//                                x: 0
//                                y: 0
//                                width: 220

//                                textFieldAnchorsleftMargin: 90
//                                label12AnchorsleftMargin: 70
//                                label12Text: "毫米"
//                                label11Text: "填充起弧距离"
//                                textFieldWidth: 60

//                            }

//                            MyEditLine4 {
//                                id: arcEnd
//                                x: 0
//                                y: 30
//                                width: 220

//                                textFieldAnchorsleftMargin: 90
//                                label12AnchorsleftMargin: 70
//                                label12Text: "毫米"
//                                label11Text: "填充收弧距离"
//                                textFieldWidth: 60

//                            }

//                            MyEditLine4 {
//                                id: facingStart
//                                x: 0
//                                y: 60
//                                width: 220

//                                textFieldAnchorsleftMargin: 90
//                                label12AnchorsleftMargin: 70
//                                label12Text: "毫米"
//                                label11Text: "盖面起弧距离"
//                                textFieldWidth: 60

//                            }

//                            MyEditLine4 {
//                                id: facingEnd
//                                x: 0
//                                y: 90
//                                width: 220

//                                textFieldAnchorsleftMargin: 90
//                                label12AnchorsleftMargin: 70
//                                label12Text: "毫米"
//                                label11Text: "盖面收弧距离"
//                                textFieldWidth: 60
//                            }
                        }

                        MyGroupTitle2 {
                            id: myGroupTitle3
                            x: 0
                            y: 0
                            width: 560
                            height: 100
                            label4FontpixelSize: 12
                            label4Color: "#202020"
                            label4Text: "其他参数"
                        }
                    }

                    GroupItem {
                        id: groupItem1
                        x: 0
                        y: 340
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
                            label4FontpixelSize: 12
                            label4Color: "#202020"
                            label4Text: "机头切换"
                        }
                    }
                }
            }
            Rectangle {
                id: rectangle14

                color: "#ebebeb"
                border.width: 0

                Rectangle {
                    id: motionleadH
                    width: 562
                    height: 491
                    color: "#ebebeb"
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    GroupItem {
                        x: 0
                        y: 0
                        MyEditLine {
                            id: lhwidthIncrement
                            x: item1.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次增加量"
                            label1Text: "毫米"
                            textFieldWidth: 60

                        }

                        MyEditLine {
                            id: lhwidthDecrement
                            x: item2.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次减少量"
                            label1Text: "毫米"
                            textFieldWidth: 60

                        }

                        MyGroupTitle2 {
                            id: myGroupTitle21
                            x: 0
                            y: 0
                            width: 562
                            height: 62
                            label4FontpixelSize: 12
                            label4Color: "#202020"
                            label4Text: "摆宽参数"

                    }
                    }

                    GroupItem {
                        x: 0
                        y: 86
                        MyGroupTitle2 {
                            id: myGroupTitle4
                            x: 0
                            y: 0
                            width: 562
                            height: 406
                            rectangle9X: 41
                            label4FontpixelSize: 12
                            label4Color: "#202020"
                            label4Text: "焊枪水平伸缩运动"
                        }

                        GroupItem {
                            x: 8
                            y: 17
                            Rectangle {
                                id: rectangle4
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle5
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧前")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item1
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle6
                                    radius: 4
                                    anchors.fill: parent
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: lhspeedOutBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60


                                }

                                MyEditLine {
                                    id: lhaccOutBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60


                                }

                                MyEditLine {
                                    id: lhstopAccOutBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60


                                }
                            }

                            Item {
                                id: item2
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle7
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向内缩枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: lhspeedInBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60


                                }

                                MyEditLine {
                                    id: lhaccInBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60

                                }

                                MyEditLine {
                                    id: lhstopAccInBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60

                                }
                            }
                        }

                        GroupItem {
                            x: 8
                            y: 210
                            Rectangle {
                                id: rectangle10
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle11
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label2
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧后")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item3
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle12
                                    radius: 4
                                    anchors.fill: parent
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: myEditLine8
                                    x: 10
                                    y: 20

                                    // default
                                    //mapString: "carWeldBeforeACC"

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60


                                }

                                MyEditLine {
                                    id: myEditLine9
                                    x: 10
                                    y: 50

                                    //default
                                    //mapString: "carWeldBeforeACC"

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60

                                }

                                MyEditLine {
                                    id: lhchangenessOut
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }

                            Item {
                                id: item4
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle13
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向内缩枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: myEditLine11
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60

                                }

                                MyEditLine {
                                    id: myEditLine12
                                    x: 10
                                    y: 50

                                    //mapString: "carWeldBeforeACC"

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lhchangenessIn
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60

                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: rectangle34

                color: "#ebebeb"
                border.width: 0

                Rectangle {
                    id: motionleadV
                    width: 562
                    height: 491
                    color: "#ebebeb"
                    border.color: "#000000"
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    GroupItem {
                        x: 0
                        y: 0
                        MyEditLine {
                            id: lvwidthIncrement
                            x: item9.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次增加量"
                            label1Text: "毫米"
                            textFieldWidth: 60
                        }

                        MyEditLine {
                            id: lvwidthDecrement
                            x: item10.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次减少量"
                            label1Text: "毫米"
                            textFieldWidth: 60
                        }

                        MyGroupTitle2 {
                            id: myGroupTitle23
                            x: 0
                            y: 0
                            width: 562
                            height: 62
                            label4Color: "#202020"
                            label4Text: "摆宽参数"
                            label4FontpixelSize: 12
                        }
                    }
                    GroupItem {
                        x: 0
                        y: 86
                        GroupItem {
                            x: 8
                            y: 17
                            Rectangle {
                                id: rectangle26
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle27
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label4
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧前")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item9
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle28
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向上抬枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: lvspeedUpBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60

                                }

                                MyEditLine {
                                    id: lvaccUpBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvstopAccUpBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60


                                }
                            }

                            Item {
                                id: item10
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle29
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向下压枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: lvspeedDownBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvaccDownBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvstopAccDownBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60
                                }
                            }
                        }

                        GroupItem {
                            x: 8
                            y: 210
                            Rectangle {
                                id: rectangle30
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle31
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label5
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧后")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item11
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle32
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向上抬枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: lvspeedUp
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvaccUp
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvchangenessUp
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }

                            Item {
                                id: item12
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle33
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向下压枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: lvspeedDown
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvaccDown
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: lvchangenessDown
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }
                        }

                        MyGroupTitle2 {
                            id: myGroupTitle6
                            x: 0
                            y: 0
                            width: 562
                            height: 406
                            label4Color: "#202020"
                            label4Text: "焊枪竖直抬压运动"
                            label4FontpixelSize: 12
                        }
                    }
                }
            }
            Rectangle {
                id: rectangle24

                color: "#ebebeb"
                border.width: 0

                Rectangle {
                    id: motiontrailH
                    width: 562
                    height: 491
                    color: "#ebebeb"
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    GroupItem {
                        x: 0
                        y: 0
                        MyEditLine {
                            id: thwidthIncrement
                            x: item5.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次增加量"
                            label1Text: "毫米"
                            textFieldWidth: 60
                        }

                        MyEditLine {
                            id: thwidthDecrement
                            x: item6.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次减少量"
                            label1Text: "毫米"
                            textFieldWidth: 60
                        }

                        MyGroupTitle2 {
                            id: myGroupTitle22
                            x: 0
                            y: 0

                            width: 562
                            height: 62
                            label4FontpixelSize: 12
                            label4Color: "#202020"
                            label4Text: "摆宽参数"
                        }
                    }
                    GroupItem {
                        x: 0
                        y: 86
                        MyGroupTitle2 {
                            id: myGroupTitle5
                            x: 0
                            y: 0
                            width: 562
                            height: 406
                            rectangle9X: 41
                            label4FontpixelSize: 12
                            label4Color: "#202020"
                            label4Text: "焊枪水平伸缩运动"
                        }

                        GroupItem {
                            x: 8
                            y: 17
                            Rectangle {
                                id: rectangle16
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle17
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label1
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧前")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item5
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle18
                                    radius: 4
                                    anchors.fill: parent
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: thspeedOutBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: thaccOutBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: thstopAccOutBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60
                                }
                            }

                            Item {
                                id: item6
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle19
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向内缩枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: thspeedInBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: thaccInBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: thstopAccInBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60
                                }
                            }
                        }

                        GroupItem {
                            x: 8
                            y: 210
                            Rectangle {
                                id: rectangle20
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle21
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label3
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧后")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item7
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle22
                                    radius: 4
                                    anchors.fill: parent
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: myEditLine10
                                    x: 10
                                    y: 20

                                    //mapString: "carWeldBeforeACC"

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: myEditLine13
                                    x: 10
                                    y: 50

                                    //mapString: "carWeldBeforeACC"

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: thchangenessOut
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }

                            Item {
                                id: item8
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle23
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向内缩枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: myEditLine14
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: myEditLine15
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    editEnabled: false
                                    exist: false
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: thchangenessIn
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: rectangle44

                color: "#ebebeb"
                border.width: 0

                Rectangle {
                    id: motiontrailV
                    width: 562
                    height: 491
                    color: "#ebebeb"
                    border.color: "#000000"
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    GroupItem {
                        x: 0
                        y: 0
                        MyEditLine {
                            id: tvwidthIncrement
                            x: item13.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次增加量"
                            label1Text: "毫米"
                            textFieldWidth: 60
                        }

                        MyEditLine {
                            id: tvwidthDecrement
                            x: item14.x + 18
                            y: 18

                            label1AnchorsleftMargin: 70
                            labelText: "单次减少量"
                            label1Text: "毫米"
                            textFieldWidth: 60
                        }

                        MyGroupTitle2 {
                            id: myGroupTitle24
                            x: 0
                            y: 0
                            width: 562
                            height: 62
                            label4Color: "#202020"
                            label4Text: "摆宽参数"
                            label4FontpixelSize: 12
                        }
                    }
                    GroupItem {
                        x: 0
                        y: 86
                        GroupItem {
                            x: 8
                            y: 17
                            Rectangle {
                                id: rectangle36
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle37
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label6
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧前")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item13
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle38
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向上抬枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: tvspeedUpBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvaccUpBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvstopAccUpBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60
                                }
                            }

                            Item {
                                id: item14
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle39
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向下压枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: tvspeedDownBefore
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvaccDownBefore
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvstopAccDownBefore
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    textFieldAnchorsleftMargin: 70
                                    textFieldWidth: 60
                                }
                            }
                        }

                        GroupItem {
                            x: 8
                            y: 210
                            Rectangle {
                                id: rectangle40
                                x: 32
                                y: 8
                                width: 500
                                height: 168
                                color: "#00ffffff"
                                border.color: "#808080"
                                border.width: 1
                            }

                            Rectangle {
                                id: rectangle41
                                x: 0
                                y: 64
                                width: 26
                                height: 60
                                color: "#ebebeb"
                                border.color: "#00000000"
                                Label {
                                    id: label7
                                    width: 14
                                    height: 18
                                    color: "#202020"
                                    text: qsTr("起弧后")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 12
                                    font.family: "Microsoft Yahei"
                                    wrapMode: Text.WordWrap
                                    anchors.verticalCenterOffset: -19
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 0
                                }
                            }

                            Item {
                                id: item15
                                x: 52
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle42
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向上抬枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: tvspeedUp
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvaccUp
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvchangenessUp
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }

                            Item {
                                id: item16
                                x: 292
                                y: 29
                                width: 220
                                height: 130
                                MyGroupTitle {
                                    id: rectangle43
                                    radius: 4
                                    anchors.fill: parent
                                    labelText: "向下压枪"
                                    labelFontpixelSize: 12
                                    labelColor: "#202020"
                                }

                                MyEditLine {
                                    id: tvspeedDown
                                    x: 10
                                    y: 20

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/分钟"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvaccDown
                                    x: 10
                                    y: 50

                                    label1AnchorsleftMargin: 70
                                    editEnabled: true
                                    labelText: "运动加速度"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米/秒<sup>2<sup>"
                                    textFieldWidth: 60
                                }

                                MyEditLine {
                                    id: tvchangenessDown
                                    x: 10
                                    y: 80

                                    label1AnchorsleftMargin: 70
                                    labelText: "单次改变量"
                                    textFieldAnchorsleftMargin: 70
                                    label1Text: "毫米"
                                    textFieldWidth: 60
                                }
                            }
                        }

                        MyGroupTitle2 {
                            id: myGroupTitle7
                            x: 0
                            y: 0
                            width: 562
                            height: 406
                            label4Color: "#202020"
                            label4Text: "焊枪竖直抬压运动"
                            label4FontpixelSize: 12
                        }
                    }
                }
            }
        }

        BorderItem {
            id: border1
            x: 100
            y: 30
            width: 612
            height: 540
            radius: 0
            drawLeft: false
            drawTop: true
            drawBottom: true
            strokeWidth: 1
            strokeColor: "#c1c1c1"
        }

        MyGroupTitle2 {
            id: myGroupTitle2
            x: 0
            y: 0
            width: 712
            height: 570
            color: "#00ebebeb"
            label4FontpixelSize: 14
            label4Color: "#202020"
            label4Text: "运动参数配置"
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
        carSpeedBefore.permission        = "false"
        carAccBefore.permission          = "false"
        carStopAccBefore.permission      = "false"
        carSpeed.permission              = "false"
        carAcc.permission                = "false"
        carStopAcc.permission            = "false"

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

        lhwidthIncrement.permission      = "false"
        lhwidthDecrement.permission      = "false"
        lhspeedOutBefore.permission      = "false"
        lhaccOutBefore.permission        = "false"
        lhstopAccOutBefore.permission    = "false"
        lhspeedInBefore.permission       = "false"
        lhaccInBefore.permission         = "false"
        lhstopAccInBefore.permission     = "false"
        lhchangenessOut.permission       = "false"
        lhchangenessIn.permission        = "false"

        lvwidthIncrement.permission      = "false"
        lvwidthDecrement.permission      = "false"
        lvspeedUpBefore.permission       = "false"
        lvaccUpBefore.permission         = "false"
        lvstopAccUpBefore.permission     = "false"
        lvspeedDownBefore.permission     = "false"
        lvaccDownBefore.permission       = "false"
        lvstopAccDownBefore.permission   = "false"
        lvspeedUp.permission             = "false"
        lvaccUp.permission               = "false"
        lvchangenessUp.permission        = "false"
        lvspeedDown.permission           = "false"
        lvaccDown.permission             = "false"
        lvchangenessDown.permission      = "false"

        thwidthIncrement.permission      = "false"
        thwidthDecrement.permission      = "false"
        thspeedOutBefore.permission      = "false"
        thaccOutBefore.permission        = "false"
        thstopAccOutBefore.permission    = "false"
        thspeedInBefore.permission       = "false"
        thaccInBefore.permission         = "false"
        thstopAccInBefore.permission     = "false"
        thchangenessOut.permission       = "false"
        thchangenessIn.permission        = "false"

        tvwidthIncrement.permission      = "false"
        tvwidthDecrement.permission      = "false"
        tvspeedUpBefore.permission       = "false"
        tvaccUpBefore.permission         = "false"
        tvstopAccUpBefore.permission     = "false"
        tvspeedDownBefore.permission     = "false"
        tvaccDownBefore.permission       = "false"
        tvstopAccDownBefore.permission   = "false"
        tvspeedUp.permission             = "false"
        tvaccUp.permission               = "false"
        tvchangenessUp.permission        = "false"
        tvspeedDown.permission           = "false"
        tvaccDown.permission             = "false"
        tvchangenessDown.permission      = "false"
    }

    function initMapString() {
        carSpeedBefore.mapString        = parameterList[1]
        carAccBefore.mapString          = parameterList[0]
        carStopAccBefore.mapString      = parameterList[2]
        carSpeed.mapString              = parameterList[4]
        carAcc.mapString                = parameterList[3]
        carStopAcc.mapString            = parameterList[5]

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

        lhwidthIncrement.mapString      = parameterList[6]
        lhwidthDecrement.mapString      = parameterList[7]
        lhspeedOutBefore.mapString      = parameterList[35]
        lhaccOutBefore.mapString        = parameterList[34]
        lhstopAccOutBefore.mapString    = parameterList[36]
        lhspeedInBefore.mapString       = parameterList[41]
        lhaccInBefore.mapString         = parameterList[40]
        lhstopAccInBefore.mapString     = parameterList[42]
        lhchangenessOut.mapString       = parameterList[46]
        lhchangenessIn.mapString        = parameterList[48]

        lvwidthIncrement.mapString      = parameterList[6]
        lvwidthDecrement.mapString      = parameterList[7]
        lvspeedUpBefore.mapString       = parameterList[11]
        lvaccUpBefore.mapString         = parameterList[10]
        lvstopAccUpBefore.mapString     = parameterList[12]
        lvspeedDownBefore.mapString     = parameterList[17]
        lvaccDownBefore.mapString       = parameterList[16]
        lvstopAccDownBefore.mapString   = parameterList[18]
        lvspeedUp.mapString             = parameterList[23]
        lvaccUp.mapString               = parameterList[22]
        lvchangenessUp.mapString        = parameterList[24]
        lvspeedDown.mapString           = parameterList[29]
        lvaccDown.mapString             = parameterList[28]
        lvchangenessDown.mapString      = parameterList[30]

        thwidthIncrement.mapString      = parameterList[8]
        thwidthDecrement.mapString      = parameterList[9]
        thspeedOutBefore.mapString      = parameterList[38]
        thaccOutBefore.mapString        = parameterList[37]
        thstopAccOutBefore.mapString    = parameterList[39]
        thspeedInBefore.mapString       = parameterList[44]
        thaccInBefore.mapString         = parameterList[43]
        thstopAccInBefore.mapString     = parameterList[45]
        thchangenessOut.mapString       = parameterList[47]
        thchangenessIn.mapString        = parameterList[49]

        tvwidthIncrement.mapString      = parameterList[8]
        tvwidthDecrement.mapString      = parameterList[9]
        tvspeedUpBefore.mapString       = parameterList[14]
        tvaccUpBefore.mapString         = parameterList[13]
        tvstopAccUpBefore.mapString     = parameterList[15]
        tvspeedDownBefore.mapString     = parameterList[20]
        tvaccDownBefore.mapString       = parameterList[19]
        tvstopAccDownBefore.mapString   = parameterList[21]
        tvspeedUp.mapString             = parameterList[26]
        tvaccUp.mapString               = parameterList[25]
        tvchangenessUp.mapString        = parameterList[27]
        tvspeedDown.mapString           = parameterList[32]
        tvaccDown.mapString             = parameterList[31]
        tvchangenessDown.mapString      = parameterList[33]
    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
