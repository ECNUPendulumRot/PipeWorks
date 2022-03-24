import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick 2.0
Rectangle {
    id: wrapper
    width: 1366
    height: 16
    color: "#d4d4d4"

    property var dataMap: {"Friday":"星期五",
                           "Monday":"星期一",
                           "Tuesday" :"星期二",
                            "Wednesday":"星期三",
                            "Thursday":"星期四",
                            "Saturday":"星期六",
                            "Sunday":"星期日"}

    Text {
        id: connectionStatusTitle
        color: "#6e6e6e"
        text: qsTr("连接状态:")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        font.pixelSize: 10
        anchors.leftMargin: 12
    }

    Text {
        id: status
        color: "#282828"
        text: qsTr("已断开数据库连接")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: connectionStatusTitle.right
        font.pixelSize: 10
        anchors.leftMargin: 10
    }

    Rectangle {
        id: alertLight
        x: 1130
        width: 9
        height: alertLight.width

        radius: alertLight.width/2
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 1
    }

    Text {
        id: syncText
//        text: qsTr("已同步")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: alertLight.right
        anchors.verticalCenterOffset: 0
        font.pixelSize: 10
        anchors.leftMargin: 5
    }

    Text {
        id: time
        x: 1236
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        font.pixelSize: 10
        anchors.rightMargin: 22
        anchors.verticalCenterOffset: 0
    }
    Timer {
           id:timer
           interval: 500; running: true; repeat: true
           onTriggered: time.text =  Qt.formatDateTime(new Date(), "dddd yyyy-MM-dd hh:mm")
       }
    Timer {
           id:dbConnect
           interval: 500; running: true; repeat: true
           onTriggered: status.text= monitorDb()
       }
    Timer {
           id:syncDb
           interval: 500; running: true; repeat: true
           onTriggered: monitorSync()
       }


    function getData(){
        return dataMap[Qt.formatDateTime(new Date(), "dddd")]
    }

    function monitorDb(){
        if(scheduler.isPdbLoaded()){
            return "已建立数据库连接"
        }
        else
            return "已断开数据库连接"
    }
    function monitorSync(){
        var sync =  "#2fc350"
        var unsync =  "#f4f42f"
        var unconnect =  "#eee"
        if(scheduler.isPdbLoaded()){//db is load)
            if(scheduler.callIsDirty()){
                alertLight.color = unsync
                syncText.text = "未提交"
            }
            else{
                alertLight.color = sync
                syncText.text = "已同步"
            }

        }
        else{
            alertLight.color = unconnect
            syncText.text = "未连接数据库"
        }

    }

}


