import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick 2.0
Rectangle {
    id: wrapper
    width: 1366
    height: 40
    color: "#ffffff"
    property alias curFilename: curruntFileName.text

    Text {
        id: connectionStatusTitle
        color: "#000000"
        text: qsTr("工艺数据连接状态:")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 15
        font.pixelSize: 14
    }

    Rectangle {
        id: connectionLight
        color: "#ff0000"
        width: statusText.height + 5
        height: width
        radius: width/2
        anchors.left: connectionStatusTitle.right
        anchors.leftMargin: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
    }

    Text {
        id: statusText
        color: "#000000"
        font.pixelSize: 14
        text: qsTr("未连接")
        anchors.left: connectionLight.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter

    }

    Text {
        id: curruntFileName
        color: "#000000"
        font.pixelSize: 14
        anchors.verticalCenterOffset: 0
        text: qsTr("当前工艺文件:")
        anchors.left: connectionLight.right
        anchors.leftMargin: 208
        anchors.verticalCenter: parent.verticalCenter
        width: 300
        elide: Text.ElideMiddle
        MouseArea{
                        property bool entered: false
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered: {
                            entered = true
                        }

                        onExited: {
                            entered = false
                        }

                        ToolTip{
                            visible: parent.entered
                            text: curruntFileName.text
                            delay: 1500
                        }
                    }

    }

    Rectangle {
        id: syncLight
        color: "#ff0000"
        width: syncText.height + 5
        height: width
        radius: width/2
        anchors.left: connectionLight.right
        anchors.leftMargin: 546
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 2
    }

    Text {
        id: syncText
        color: "#000000"
        font.pixelSize: 14
        text: qsTr("未打开工艺文件")

        anchors.left: syncLight.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
    }

    Text {
        id: datetimeText
        font.pixelSize: 14
        //x: 1236
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
    }
    Timer {
           id:timer
           interval: 500; running: true; repeat: true
           onTriggered: datetimeText.text =  Qt.formatDateTime(new Date(), "dddd yyyy-MM-dd hh:mm")
       }
    Timer {
           id:dbConnect
           interval: 500; running: true; repeat: true
           onTriggered:  monitorDb()
       }
    Timer {
           id:syncDb
           interval: 1000; running: true; repeat: true
           onTriggered: monitorSync()
       }


//    function getData(){
//        return dataMap[Qt.formatDateTime(new Date(), "dddd")]
//    }

    function monitorDb(){
        if(scheduler.isPdbLoaded()){
            connectionLight.color = "#00ff00"
            statusText.text= "连接成功"
        }
        else{
            connectionLight.color = "#ff0000"
            statusText.text= "未连接"
        }
    }

    function monitorSync(){
        var sync =  "#00ff00"
        var unsync =  "#f4f42f"
        var unconnect =  "#ff0000"
        if(scheduler.isPdbLoaded()){//db is load)
            if(scheduler.callIsDirty()){
                syncLight.color = unsync
                syncText.text = "修改后的数据未提交"
            }
            else{
                syncLight.color = sync
                syncText.text = "数据已提交保存"
            }
        }
        else{
            syncLight.color = unconnect
            syncText.text = "未打开工艺文件"
        }

    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:16;width:1366}D{i:1}D{i:2}D{i:3}D{i:6}D{i:5}D{i:4}
D{i:7}D{i:8}D{i:9}D{i:10}D{i:11}D{i:12}
}
##^##*/
