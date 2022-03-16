import QtQuick 2.15
import QtQuick.Controls 2.15
import "Components"
import QtQuick.Studio.Components 1.0
import QtQuick.Layouts 1.0
import "../../../../QML5/imports/QML5"
Item {
    width: 1220
    height: 160

    id: control

    property int passLine: -1


    // todo : behaviour before the database is loaded

    property var colMapping : {   "passName":           0,
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
                                  "flag":               24

                              }

    GroupItem {
        x: 42
        y: 20

        GroupItem {
            id: groupItem
            x: 0
            y: 0

            GroupItem {
                id: groupItem3
                x: 0
                y: -8
                width: 233
                height: 132

                Rectangle {
                    id: rec1
                    x: 21
                    y: 27
                    width: 155
                    height: 98
                    color: "#00ffffff"
                    border.color: "#808080"
                    border.width: 1
                    antialiasing: true
                }

                Label {
                    id: label
                    x: 5
                    y: 41
                    width: 14
                    height: 18
                    color: Constants.tableFontColor
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Microsoft YaHei UI'; font-size:12px; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">起</p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">弧</p></body></html>"
                    wrapMode: Text.WordWrap
                    font.pointSize: 9
                    textFormat: Text.RichText
                }

                ColumnLayout {
                    anchors.verticalCenter: rec1.verticalCenter
                    anchors.left: rec1.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcLeadSVPercent
                        mapString : "arcLeadSVPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        labelText: "弧压百分比"
                        label1Text: "%"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadSWSPercent
                        mapString : "arcLeadSWSPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadSOWPercent
                        mapString : "arcLeadSOWPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadSTime
                        mapString : "arcLeadSTime"

                        textFieldAnchorsleftMargin: 64
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
                x: 175
                y: -8
                width: 233
                height: 132

                Rectangle {
                    id: rectangle1
                    x: rec1.x
                    y: rec1.y
                    width: rec1.width
                    height: rec1.height
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
                    anchors.verticalCenter: rectangle1.verticalCenter
                    anchors.left: rectangle1.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcLeadOVPercent

                        mapString : "arcLeadOVPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "弧压百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadOWSPercent

                        mapString: "arcLeadOWSPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadOOWPercent

                        mapString: "arcLeadOOWPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcLeadOTime

                        mapString: "arcLeadOTime"
                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "\u79d2"
                        labelText: "时间"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }
                }
            }

            MyGroupTitle2 {
                id: myGroupTitle2
                x: 0
                y: -7
                width: 363
                height: 132
                antialiasing: true
                rectangle9Color: "#d4d4d4"
                rectangle9X: 30
                label4Color: "#202020"
                label4Text: "前焊枪"
            }

            MyEditLine {
                id: trimLeadMode

                mapString: "trimLeadMode"

                x: 196
                y: -8
                labelText: "跟踪状态"
                textFieldAnchorsleftMargin: 64
                label1AnchorsleftMargin: 50
                textFieldWidth: 40
                label1Text: ""

                onDataChanged: (s, text) => writeToBackend(s, text)
            }
        }

        GroupItem {
            x: 374
            y: 0
            GroupItem {
                id: groupItem4
                x: 0
                y: -8

                Rectangle {
                    id: rectangle2
                    x: rec1.x
                    y: rec1.y
                    width: rec1.width
                    height: rec1.height
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
                    anchors.verticalCenter: rectangle2.verticalCenter
                    anchors.left: rectangle2.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcTrailSVPercent

                        mapString: "arcTrailSVPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "弧压百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailSWSPercent

                        mapString: "arcTrailSWSPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailSOWPercent

                        mapString: "arcTrailSOWPercent"

                        textFieldAnchorsleftMargin: 64
                        label1AnchorsleftMargin: 50
                        textFieldWidth: 40
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailSTime

                        mapString : "arcTrailSTime"

                        textFieldAnchorsleftMargin: 64
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
                x: 175
                y: -8

                Rectangle {
                    id: rectangle3
                    x: rectangle1.x
                    y: rectangle1.y
                    width: rectangle1.width
                    height: rectangle1.height
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
                    anchors.verticalCenter: rectangle3.verticalCenter
                    anchors.left: rectangle3.left
                    anchors.leftMargin: 0
                    spacing: -5

                    MyEditLine {
                        id: arcTrailOVPercent

                        mapString : "arcTrailOVPercent"

                        textFieldAnchorsleftMargin: 64
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "%"
                        labelText: "弧压百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailOWSPercent

                        mapString : "arcTrailOWSPercent"

                        textFieldAnchorsleftMargin: 64
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "%"
                        labelText: "送丝百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailOOWPercent

                        mapString : "arcTrailOOWPercent"

                        textFieldAnchorsleftMargin: 64
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "%"
                        labelText: "摆宽百分比"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }

                    MyEditLine {
                        id: arcTrailOTime

                        mapString : "arcTrailOTime"

                        textFieldAnchorsleftMargin: 64
                        textFieldWidth: 40
                        label1AnchorsleftMargin: 50
                        label1Text: "\u79d2"
                        labelText: "时间"

                        onDataChanged: (s, text) => writeToBackend(s, text)
                    }
                }
            }

            MyGroupTitle2 {
                id: myGroupTitle3
                x: myGroupTitle2.x
                y: myGroupTitle2.y
                width: myGroupTitle2.width
                height: myGroupTitle2.height
                antialiasing: true
                rectangle9Color: "#d4d4d4"
                label4Text: "后焊枪"
                label4Color: "#202020"
                rectangle9X: 30
            }

            MyEditLine {
                id: trimTrailMode
                x: trimLeadMode.x
                y: trimLeadMode.y

                mapString : "trimTrailMode"

                textFieldAnchorsleftMargin: 64
                label1AnchorsleftMargin: 50
                labelText: "跟踪状态"
                textFieldWidth: 40
                label1Text: ""

                onDataChanged: (s, text) => writeToBackend(s, text)
            }
        }

        GroupItem {
            x: 748
            y: 0

            MyGroupTitle2 {
                id: myGroupTitle4
                x: 0
                y: myGroupTitle2.y
                width: 165
                height: myGroupTitle2.height
                rectangle9Color: "#d4d4d4"
                label4Text: "其他"
                rectangle9X: 15
                label4Color: "#202020"

            }

            ColumnLayout {
                x: 8
                y: 3
                width: 157
                height: 120
                spacing: 0

                MyEditLine3 {
                    id: startAngle

                    mapString : "startAngle"

                    width: 145
                    textFieldAnchorsleftMargin: 76
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
                    textFieldAnchorsleftMargin: 76
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "\u5ea6"
                    label5Text: "终止角"

                    onDataChanged: (s, text) => writeToBackend(s, text)
                }

                MyEditLine3 {
                    id: potFunc
                    width: 145

                    mapString : "potFunc"

                    textFieldAnchorsleftMargin: 76
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: ""
                    label5Text: "电位器功能"

                    onDataChanged: (s, text) => writeToBackend(s, text)

                }

                MyEditLine3 {
                    id: potPercent
                    width: 145

                    mapString : "potPercent"

                    textFieldAnchorsleftMargin: 76
                    label6AnchorsleftMargin: 50
                    textFieldWidth: 40
                    label6Text: "%"
                    label5Text: "电位器百分比"

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
        if(item.type === "editable" && item.editEnabled){
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
            item.textFieldText = "";
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
    D{i:0;formeditorZoom:0.9;height:160;width:1206}D{i:4}D{i:5}D{i:7}D{i:8}D{i:9}D{i:10}
D{i:6}D{i:3}D{i:12}D{i:13}D{i:15}D{i:16}D{i:17}D{i:18}D{i:14}D{i:11}D{i:19}D{i:20}
D{i:2}D{i:23}D{i:24}D{i:26}D{i:27}D{i:28}D{i:29}D{i:25}D{i:22}D{i:31}D{i:32}D{i:34}
D{i:35}D{i:36}D{i:37}D{i:33}D{i:30}D{i:38}D{i:39}D{i:21}D{i:41}D{i:43}D{i:44}D{i:45}
D{i:46}D{i:42}D{i:40}D{i:1}D{i:47}
}
##^##*/

