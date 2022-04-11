import QtQuick 2.15
import QtQuick.Controls 2.15
import "Components"
import QtQuick.Studio.Components 1.0
import QtQuick.Layouts 1.0
import "../../../../QML5/imports/QML5"
import "../Components"
Item {
    width: 1220
    height: 160

    id: control

    property int passLine: -1


    // todo : behaviour before the database is loaded

    property var colMapping : {
        "passName":           0,
        "showName":           1,
        "startAngle":         2,
        "endAngle":           3,
        "potFunc":            4,
        "potPercent":         5,
        "arcLeadSVPercent":   6,
        "arcLeadSWSPercent":  7,
        "arcLeadSOWPercent":  8,
        "arcLeadSTime":       9,
        "arcTrailSVPercent":  10,
        "arcTrailSWSPercent": 11,
        "arcTrailSOWPercent": 12,
        "arcTrailSTime":      13,
        "arcLeadOVPercent":   14,
        "arcLeadOWSPercent":  15,
        "arcLeadOOWPercent":  16,
        "arcLeadOTime":       17,
        "arcTrailOVPercent":  18,
        "arcTrailOWSPercent": 19,
        "arcTrailOOWPercent": 20,
        "arcTrailOTime":      21,
        "trimLeadMode":       22,
        "trimTrailMode":      23,
        "HRatioLead":         24,
        "HRatioTrail":        25,
        "startArcDistance":   26,
        "endArcDistance":     27,
        "flag":               28

    }

    GroupItem {
        x: 42
        y: 20

        GroupItem {
            id: groupItem
            x: 0
            y: 0



            MyGroupTitle2 {
                id: myGroupTitle2
                x: 0
                y: -10
                width: 363
                height: 144
                antialiasing: true
                rectangle9Color: "#fafafa"
                rectangle9X: 150
                label4Color: "#000000"
                label4Text: "前焊枪"
            }

            MyEditLine {
                id: hRatioLead
                x: 21
                y: -7
                textFieldWidth: 40
                mapString: "HRatioLead"
                label1AnchorsleftMargin: 50
                label1Text: ""
                textFieldAnchorsleftMargin: 72
                labelText: "电流值/毫米"

                onDataChanged: (s, text) => writeToBackend(s, text)
            }

            SelectComboBoxFix {
                id: trimLeadMode
                mapString: "trimLeadMode"
                defaultString:""
                x: 196
                y: hRatioLead.y
                controlWidth: 68
                controlAnchorsleftMargin: 72
                onDataChanged: (s, text) => writeToBackend(s, text)

            }
            GroupItem {
                id: groupItem3
                x: hRatioLead.x
                y: 26
                width: start1.width
                height: start1.height

                Rectangle {
                    id: start1
                    x: 0
                    y: 0
                    width: 155
                    height: 98
                    color: "#00ffffff"
                    border.color: "#808080"
                    border.width: 1
                    antialiasing: true
                }

                Label {
                    id: label
                    x: -15
                    y: 16
                    width: 14
                    height: 18
                    color: Constants.tableFontColor
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Microsoft YaHei UI'; font-size:12px; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">起</p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">弧</p></body></html>"
                    wrapMode: Text.WordWrap
                    font.pixelSize: 12
                    textFormat: Text.RichText
                }

                ColumnLayout {
                    anchors.verticalCenter: start1.verticalCenter
                    anchors.left: start1.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcLeadSVPercent
                        mapString : "arcLeadSVPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        labelText: "弧压百分比"
                        label1Text: "%"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadSWSPercent
                        mapString : "arcLeadSWSPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadSOWPercent
                        mapString : "arcLeadSOWPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadSTime
                        mapString : "arcLeadSTime"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "\u79d2"
                        labelText: "时间"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }
                }
            }
            GroupItem {
                id: groupItem1
                x: trimLeadMode.x
                y: groupItem3.y
                width: end1.width
                height: end1.height

                Rectangle {
                    id: end1
                    x: start1.x
                    y: start1.y
                    width: start1.width
                    height: start1.height
                    color: "#00ffffff"
                    border.color: "#808080"
                    border.width: 1
                    antialiasing: true
                }

                Label {
                    id: label1
                    x: label.x
                    y: label.y
                    width: 14
                    height: 18
                    color: Constants.tableFontColor
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Microsoft YaHei UI'; font-size:12px; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">收</p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">弧</p></body></html>"
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                }

                ColumnLayout {
                    anchors.verticalCenter: end1.verticalCenter
                    anchors.left: end1.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcLeadOVPercent

                        mapString : "arcLeadOVPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "弧压百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadOWSPercent

                        mapString: "arcLeadOWSPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadOOWPercent

                        mapString: "arcLeadOOWPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadOTime

                        mapString: "arcLeadOTime"
                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "\u79d2"
                        labelText: "时间"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }
                }
            }
        }

        GroupItem {
            x: 374
            y: 0


            MyGroupTitle2 {
                id: myGroupTitle3
                x: myGroupTitle2.x
                y: myGroupTitle2.y
                width: myGroupTitle2.width
                height: myGroupTitle2.height
                antialiasing: true
                rectangle9Color: "#fafafa"
                label4Text: "后焊枪"
                label4Color: "#000000"
                rectangle9X: 150
            }

            MyEditLine {
                id: hRatioTrail
                x: hRatioLead.x
                y: hRatioLead.y
                textFieldWidth: 40
                label1Text: ""
                label1AnchorsleftMargin: 50
                mapString: "HRatioTrail"
                textFieldAnchorsleftMargin: 72
                labelText: "电流值/毫米"

                onDataChanged: (s, text) => writeToBackend(s, text)
            }

            SelectComboBoxFix {
                id: trimTrailMode
                x: trimLeadMode.x
                y: trimLeadMode.y
                controlWidth: 68
                controlAnchorsleftMargin: 72
                mapString: "trimTrailMode"
                defaultString:""
                onDataChanged: (s, text) => writeToBackend(s, text)

            }

            //            MyEditLine {
            //                id: trimTrailMode
            //                x: trimLeadMode.x
            //                y: trimLeadMode.y

            //                mapString : "trimTrailMode"

            //                textFieldAnchorsleftMargin: 64
            //                label1AnchorsleftMargin: 50
            //                labelText: "跟踪状态"
            //                textFieldWidth: 40
            //                label1Text: ""

            //                onDataChanged: (s, text) => writeToBackend(s, text)
            //            }
            GroupItem {
                id: groupItem4
                x: hRatioTrail.x
                y: groupItem3.y
                width: start2.width
                height: start2.height

                Rectangle {
                    id: start2
                    x: start1.x
                    y: start1.y
                    width: start1.width
                    height: start1.height
                    color: "#00ffffff"
                    border.color: "#808080"
                    border.width: 1
                    antialiasing: true
                }

                Label {
                    id: label2
                    x: label.x
                    y: label.y
                    width: 14
                    height: 18
                    color: Constants.tableFontColor
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Microsoft YaHei UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12px;\">起</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:12px;\"><br /></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:12px;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12px;\">弧</span></p></body></html>"
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                }

                ColumnLayout {
                    anchors.verticalCenter: start2.verticalCenter
                    anchors.left: start2.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcTrailSVPercent

                        mapString: "arcTrailSVPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "弧压百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailSWSPercent

                        mapString: "arcTrailSWSPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailSOWPercent

                        mapString: "arcTrailSOWPercent"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailSTime

                        mapString : "arcTrailSTime"

                        textFieldAnchorsleftMargin: 72
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "\u79d2"
                        labelText: "时间"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }
                }
            }
            GroupItem {
                id: groupItem5
                x: trimTrailMode.x
                y: groupItem3.y
                width: end2.width
                height: end2.height

                Rectangle {
                    id: end2
                    x: end1.x
                    y: end1.y
                    width: end1.width
                    height: end1.height
                    color: "#00ffffff"
                    border.color: "#808080"
                    border.width: 1
                    antialiasing: true
                }

                Label {
                    id: label3
                    x: label.x
                    y: label.y
                    width: 14
                    height: 18
                    color: Constants.tableFontColor
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Microsoft YaHei UI'; font-size:12px; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">收</p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">弧</p></body></html>"
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                }

                ColumnLayout {
                    anchors.verticalCenter: end2.verticalCenter
                    anchors.left: end2.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcTrailOVPercent

                        mapString : "arcTrailOVPercent"

                        textFieldAnchorsleftMargin: 72
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "%"
                        labelText: "弧压百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailOWSPercent

                        mapString : "arcTrailOWSPercent"

                        textFieldAnchorsleftMargin: 72
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailOOWPercent

                        mapString : "arcTrailOOWPercent"

                        textFieldAnchorsleftMargin: 72
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailOTime

                        mapString : "arcTrailOTime"

                        textFieldAnchorsleftMargin: 72
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "\u79d2"
                        labelText: "时间"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }
                }
            }
        }

        GroupItem {
            id: groupItem2
            x: 748
            y: 0

            MyGroupTitle2 {
                id: myGroupTitle4
                x: 0
                y: myGroupTitle2.y
                width: 180
                height: myGroupTitle2.height
                rectangle9Color: "#fafafa"
                label4Text: "其它"
                rectangle9X: 68
                label4Color: "#000000"

            }

            ColumnLayout {
                x: 10
                y: -5
                width: 157
                height: 120
                spacing: -8





                SelectComboBoxFix {
                    id: potFunc
                    controlWidth: 68
                    controlAnchorsleftMargin: 78
                    labelText: "电位器功能"
                    defaultString: ""
                    cbxModel: ["不开启","主枪送丝","副枪送丝","小车行走"]
                    mapString: "potFunc"
                    onDataChanged: (s, text) => writeToBackend(s, text)
                }

                MyEditLine3 {
                    id: potPercent
                    width: 145

                    mapString : "potPercent"

                    textFieldAnchorsleftMargin: 80
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "%"
                    label5Text: "电位器百分比"

                    onDataChanged: (s, text) => writeToBackend(s, text)
                }


                MyEditLine3 {
                    id: startAngle

                    mapString : "startAngle"

                    width: 145
                    textFieldAnchorsleftMargin: 80
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "\u5ea6"
                    label5Text: "起始角"

                    onDataChanged: (s, text) => writeToBackend(s, text)
                }
                MyEditLine3 {
                    id: endAngle

                    mapString : "endAngle"

                    width: 145
                    textFieldAnchorsleftMargin: 80
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "\u5ea6"
                    label5Text: "终止角"

                    onDataChanged: (s, text) => writeToBackend(s, text)
                }

                MyEditLine3 {
                    id: startArcDistance

                    mapString : "startArcDistance"

                    width: 145
                    textFieldAnchorsleftMargin: 80
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "毫米"
                    label5Text: "起弧距离"

                    onDataChanged: (s, text) => writeToBackend(s, text)
                }

                MyEditLine3 {
                    id: endArcDistance

                    mapString : "endArcDistance"

                    width: 145
                    textFieldAnchorsleftMargin: 80
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "毫米"
                    label5Text: "收弧距离"

                    onDataChanged: (s, text) => writeToBackend(s, text)
                }
            }
        }
    }

    Label {
        id: label4
        x: 11
        y: 46
        color: "#202020"
        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Microsoft YaHei UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:14px;\">固</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:14px;\">有</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:14px;\">参</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:14px;\">数</span></p></body></html>"
        font.pixelSize: 16
        wrapMode: Text.WordWrap
        textFormat: Text.RichText
    }

    ///
    /// functions and signals
    ///
    function fixedTableRefreshData(i = control.passLine) {
        control.passLine = i;
        refreshData(control)
    }


    function writeToBackend(s, text){
        if(scheduler.isPdbLoaded()){
            passFTableModel.callSetData(control.passLine, colMapping[s], text)
            fixedTableRefreshData(control.passLine)
        }
    }

    function refreshData(item){
        if(item.type === "editable" ){ //&& item.editEnabled
            item.textFieldText = passFTableModel.fixedTablePopData(control.passLine, item.mapString);
            item.textFieldColor = passFTableModel.callIsDirty(control.passLine, colMapping[item.mapString]) ? "#cc5555":"#0d0d0d";
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            refreshData(item.children[i])
        return
    }


    function clear(){
        clearData(control)
    }

    function clearData(item){
        if(item.type === "editable"){
            item.clear();
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            clearData(item.children[i])
        return
    }

    function establishConnection(){
        initConnection(control);
    }

    function initConnection(item){
        if(item.type === "editable" && item.editEnabled){
            item.onDataChanged.connect(function(s, text){
                passFTableModel.callSetData(control.passLine, colMapping[s], item.textFieldText)
                fixedTableRefreshData()
            })
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            initConnection(item.children[i])
        return
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75;height:160;width:1206}
}
##^##*/

