import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml 2.15


Rectangle {
    id: widget

    signal webTableRequestFresh(int row, int column, string text )

    width: 360
    height: 770
    color: "#00ffffff"
    border.width: 0
    z: 1
    property var engToChn : {//cmd <------> table column name
        "angle"         :"角度\n(度)",
        "stayTime_Lead" :"前枪边停时间\n(秒)",
        "oscWidth_Lead" :"前枪摆宽\n(毫米)",
        "oscFreq_Lead"  :"前枪摆动频率\n(赫兹)",   //？
        "feedRate_Lead" :"前枪送丝速度\n(毫米/分钟²)",
        "Arc_Rate_Lead" :"前枪电弧修正\n(伏特)",
        "Arc_Rate_Trail":"后枪电弧修正\n(伏特)",
        "stayTime_Trail":"后枪边停时间\n(秒)",
        "oscWidth_Trail":"后枪摆宽\n(毫米)",
        "oscFreq_Trail" :"后枪摆动频率\n(赫兹)",
        "feedRate_Trail":"后枪送丝速度\n(毫米/分钟²)",
        "carACC"        :"小车加速度\n(毫米/分钟²)",
        "carSPEED"      :"小车速度\n(毫米/分钟²)",
        "leadTargetCur" :"前枪干伸高度值\n(毫米)",
        "trailTargetCur":"后枪干伸高度值\n(毫米)"
    }


    ListView {
        id: header

        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width
        implicitWidth: parent.width

        height: 35
        implicitHeight: 35

        orientation: ListView.Horizontal

        enabled: false

        model: ListModel{
            id:listModel

            Component.onCompleted: {
                for (var i = 0; i < view.columnCount; i++ )
                    listModel.append({"headerName": engToChn[angleRelatedTableModel.headerNameEng(i)]/*angleRelatedTableModel.columnCount()*/})
            }

        }

        delegate: Item {
            id: headerDelegate

            implicitWidth: header.width/header.count
            implicitHeight: 35

            Rectangle {

                id:hBottomLine
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#a0a0a0"
            }

            Rectangle {
                id:hTopLine
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: 1
                color: "#cecece"

                visible: false
            }

            Rectangle {
                id:hLeftLine
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 1
                color: "#cecece"

                visible: index === 0 ? false : true
            }

            Rectangle {
                id:hRightLine
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 1
                color: "#cecece"

                visible: index === header.count - 1 ? false : true
            }

            Text {
                text: headerName
                anchors.centerIn: parent

                font.pixelSize: 12
            }
        }
    }

    TableView {
        id: view

        property int columnCount : angleRelatedTableModel.columnCount();

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom

        //TODO : load model

        model: angleRelatedTableModel

        clip: true

        delegate: Item {
            id: tableDelegate

            implicitWidth: view.width/view.columnCount
            implicitHeight: 35

            Rectangle {

                id:bottomLine
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#cecece"
            }

            Rectangle {
                id:topLine
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: 1
                color: "#cecece"

                visible: row === 0 ? true:false
            }

            Rectangle {
                id:leftLine
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 1
                color: "#cecece"

                visible: column === 0 ? false : true
            }

            Rectangle {
                id:rightLine
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 1
                color: "#cecece"

                visible: column === view.columnCount - 1 ? false : true
            }

            AngleTextField {
                id:textField
                text: display
                color: isDirty ? "#cc5555":"#0d0d0d"
                readOnly: column === 0 ? true: false
                anchors.fill: parent
                onEditingFinished: {
                    angleRelatedTableModel.callSetData(row, column, text)
                    widget.webTableRequestFresh(row, column, text)
                    textField.focus = false
                }
            }

        }
        Component.onDestruction: view.columnCount = 0                      //tableDelegate.implicitWidth =  view.width/view.columnCount
    }
    //Component.onCompleted: view.columnCount = angleRelatedTableModel.columnCount();
}
