import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import QtQuick.Dialogs 1.3
import "Components"
import "Tables"
import "Popups"
import "Parameters"
//import ModelCraft 1.0

Rectangle {
    id: root
    color: "#ffffff"
    border.color: "#ffffff"
    border.width: 1
    width: 1366
    height: 768

    //property var angleTableContainer : null
    
    Rectangle {
        id: webEngineWrapper
        color: "#858585"
        border.width: 0
        anchors.left: passListView.right
        anchors.right: angleTableWrapper.left
        anchors.top: mainBar.bottom
        anchors.bottom: fixedTableWrapper.top
        anchors.leftMargin: 0
        anchors.topMargin: 0

        WebChart {
            id: angleWebContainer
            anchors.fill:parent

            lock: lockBtn.checked
            onWebCallBack: (row, col, value) => refreshModelData(row, col,value)
        }
    }


    Rectangle {
        id: angleTableWrapper
        //x: 1062
        width: 300
        color: "#fafafa"
        border.width: 0
        anchors.right: parent.right
        anchors.top: mainBar.bottom
        anchors.bottom: fixedTableWrapper.top
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow6
            color: "#38000000"
            radius: 8
            horizontalOffset: -1
            spread: 0.1
            verticalOffset: 0
        }

        Loader {
            id: angleTableContainer
            anchors.fill : parent
            anchors.leftMargin : 10
            anchors.topMargin : 10
            anchors.rightMargin : 10
            anchors.bottom : parent.bottom

            source: ""
        }
    }

    Rectangle {
        id: fixedTableWrapper
        x: 241
        y: -110
        height: 160
        color: "#fafafa"
        anchors.left: passListView.right
        anchors.right: parent.right
        anchors.bottom: statusBar.top
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow4
            color: "#2e000000"
            radius: 8
            spread: 0.2
            verticalOffset: -2
            horizontalOffset: 0
        }
        FixedTable {
            id: fixedTable
            x: 0
            y: 0
            width: 1206
            height: 160
        }
    }

    PassListView {
        id: passListView
        width: 160

        color: "#fafafa"
        border.width: 0
        anchors.left: parent.left
        anchors.top: mainBar.bottom
        anchors.bottom: statusBar.top
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow2
            color: "#38000000"
            radius: 8
            horizontalOffset: 1
            spread: 0.2
            verticalOffset: 0
        }
        z: 2
        anchors.topMargin: 0
        anchors.leftMargin: 0

        onPassListRequestRefreshcombobx: selectCombobx.cmbBxParameterSelect()

        onPassListRequestFixTableRefresh: i => fixedTable.fixedTableRefreshData(i)

    }

    StatusBar {
        id: statusBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        z: 3
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow3
            color: "#2a000000"
            radius: 8
            spread: 0.2
            //verticalOffset: -2
            horizontalOffset: 0
        }
    }

    MainBar {
        id: mainBar
        height: 60
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow
            color: "#2a000000"
            radius: 6
            spread: 0.2
            verticalOffset: 4
            horizontalOffset: 0
        }
        z: 3
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        motionParamBtn.onClicked: motionPop.open()
        ctrlParamBtn.onClicked: ctrlPop.open()
        commParamBtn.onClicked: commPop.open();

    }


    DbConnectBtn {
        id: dbConnectBtn
        width: 120
        height: 33
        anchors.verticalCenter: selectCombobx.verticalCenter
        anchors.horizontalCenter: passListView.horizontalCenter
        layer.effect: DropShadowEffect {
            id: dropShadow1
            visible: true
            color: "#52000000"
            radius: 25
            horizontalOffset: 0
            verticalOffset: 0
            spread: 0.3
        }
        z: 2

        onClicked: {
            popupDb.open();
        }

    }

    SelectComboBox {
        id: selectCombobx
        x: 190
        y: 72
        width: 170
        z: 3
    }

    LockBtn {
        id: lockBtn
        x: 1373
        anchors.verticalCenter: selectCombobx.verticalCenter
        anchors.right: webEngineWrapper.right
        anchors.rightMargin: 35
        z: 3



        layer.enabled: true
        layer.effect: DropShadowEffect {
            id: dropShadow5
            color: "#2d000000"
            radius: 16
            spread: 0.3
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    CancelBtn {
        id: myButton2
        //y: 681
        anchors.bottom: myButton3.top
        anchors.horizontalCenter: myButton3.horizontalCenter
        anchors.bottomMargin: 20
        z: 3

        onClicked:{
            if(scheduler.isPdbLoaded()){
                scheduler.revertData();
                fixedTable.fixedTableRefreshData();
                passListView.refreshPassFlag();
                commPop.commLoad();
                ctrlPop.ctrlLoad();
                motionPop.motionLoad();
            }

        }
    }

    SubmitBtn {
        id: myButton3

        anchors{
          right: parent.right
          bottom: parent.bottom
          rightMargin:40
          bottomMargin: 50
        }
        z: 3

        onClicked:{
            if(scheduler.isPdbLoaded()){
                scheduler.submitData();
                fixedTable.fixedTableRefreshData();
                passListView.refreshPassFlag();
                commPop.commLoad();
                ctrlPop.ctrlLoad();
                motionPop.motionLoad();
            }
        }

    }

    ExitBtn {
        id: exitBtn
        //x: 1317
        //y: 8
        width: 50
        anchors{
          right: mainBar.right
          verticalCenter: mainBar.verticalCenter
        }
        //anchors.right: mainBar.right
        //anchors.top: mainBar.top
        //anchors.bottom: mainBar.bottom
        antialiasing: true
        z: 4

        onClicked: logoutPopup.open();
    }


    LogoutPopup{
        id:logoutPopup
        x: exitBtn.x - (logoutPopup.width - exitBtn.width)
        y: exitBtn.y + exitBtn.height
        z:3

        closeBtn.onClicked: Qt.quit()
        logoutBtn.onClicked: userLogout()
    }

    PopupDb {
        id: popupDb
        x: dbConnectBtn.x  + 25
        y: dbConnectBtn.y + dbConnectBtn.height + 1
        z: 2

        property var fileUrl

        openBtn.onClicked:{
            popupDb.close();
            if(scheduler.isPdbLoaded()){
                reconnectDialog.open();
            }
            else
                fileDialog.open();
        }

        disconnectBtn.onClicked:{
            popupDb.close();
            disconnect();
        }

        uploadBtn.onClicked: {
            if(!scheduler.isPdbLoaded())
                console.log("no file");
            else{
                popupDb.close();
                uploadDialog.open()
            }
        }

        saveAsBtn.onClicked: {
            if(scheduler.isPdbLoaded()){
                popupDb.close();
                saveDialog.open();
            }
        }

        downloadBtn.onClicked: {
            popupDb.close();
            downloadFile.open();
        }

        ftpBtn.onClicked:{
            popupDb.close();
            getFTPConfig();
            ftpDialog.open();
        }

    }

    ReconnectDialog {
        id: reconnectDialog

        x: (root.width - reconnectDialog.width)/2
        y: (root.height - reconnectDialog.height)/2

        cancelBtn.onClicked: {
            disconnect();
            fileDialog.open();
            reconnectDialog.close();
        }


        editBtn.onClicked: {
            reconnectDialog.close()
        }

        confirmBtn.onClicked: {
            scheduler.submitData()
            disconnect();
            reconnectDialog.close()
            fileDialog.open();
        }
    }


    CommPopup {
        id: commPop

        x: (root.width - commPop.width)/2
        y: (root.height - commPop.height)/2
    }

    CtrlPopup {
        id: ctrlPop

        x: (root.width - ctrlPop.width)/2
        y: (root.height - ctrlPop.height)/2
    }

    MotionPopup {
        id: motionPop

        x: (root.width - motionPop.width)/2
        y: (root.height - motionPop.height)/2
    }

    FileDialog {
        id: fileDialog
        nameFilters:["Datase files(*.db)"]
        folder: shortcuts.home
        onAccepted: {
            popupDb.fileUrl = fileUrl
            //console.log(popupDb.fileUrl)
            mainLoadDb(fileUrl)
        }
    }

    FileDialog {
        id: downloadFile
        selectFolder : true
        nameFilters:["Datase files(*.db)"]
        folder: shortcuts.home
        onAccepted: {
            downloadfile(fileUrl)
            downloadDialog.open()
        }
    }

    UploadDialog{
        id:uploadDialog
        x: (root.width - reconnectDialog.width)/2
        y: (root.height - reconnectDialog.height)/2

        cancelBtn.onClicked: {
            cvisibleProgress = false
            progressBarValue = 0.0
            completeBtn.cvisible = false;
            confirmBtn.cvisible = true;
            uploadDialog.close()}

        confirmBtn.onClicked: {
            uploadFile(ftpDialog.uploadName)
        }

        completeBtn.onClicked: {
            cvisibleProgress = false
            progressBarValue = 0.0
            completeBtn.cvisible = false;
            confirmBtn.cvisible = true;
            uploadDialog.close()
        }
    }

    DownloadDialog{
        id:downloadDialog
        x: (root.width - reconnectDialog.width)/2
        y: (root.height - reconnectDialog.height)/2
        cancelBtn.onClicked: {
            progressBarValue = 0.0
            completeBtn.cvisible = false;
            downloadDialog.close()
        }
        completeBtn.onClicked: {
            progressBarValue = 0.0
            completeBtn.cvisible = false;
            downloadDialog.close()
            if(!scheduler.isPdbLoaded()){
                var downloadFileUrl = downloadFile.fileUrl
                var downloadFlieName = "/" + ftpDialog.downloadName
                var totalUrl = downloadFileUrl+downloadFlieName
                popupDb.fileUrl = totalUrl
                mainLoadDb(totalUrl)
            }
        }
    }

    FtpDoalog {
        id:ftpDialog
        x: (root.width - reconnectDialog.width)/2
        y: (root.height - reconnectDialog.height)/2

        cancelBtn.onClicked: ftpDialog.close()

        confirmBtn.onClicked: {
            ftpConfig(ip, port, user, password)
            setFTPConfig()
            ftpDialog.close()
        }

    }

    FileDialog {
        id:saveDialog
        x: (root.width - reconnectDialog.width)/2
        y: (root.height - reconnectDialog.height)/2

        selectExisting: false
        nameFilters: [ "database files (*.db)" ]

        onAccepted: {
            console.log(fileUrl)
            scheduler.saveToFile(fileDialog.fileUrl, saveDialog.fileUrl);

        }
    }

    MouseArea {
        anchors.fill: parent
        z: -10
        onClicked: forceActiveFocus()
    }

    ///
    /// signals and functions
    ///

    Connections {
        target: scheduler
        onModelDataReady: s => {
            console.log(s)
            refreshAngleTable(s)}
    }

    Connections {
        target: downloader
        onUpProgress: (bytesSent, bytesTotal)=> {
            uploadDialog.progressBarValue = bytesSent/bytesTotal
            if(bytesSent/bytesTotal === 1.0){
                uploadDialog.completeBtn.cvisible = true;
                uploadDialog.confirmBtn.cvisible = false;
                          }
            }
    }

    Connections {
        target: downloader
        onDownProgress: (bytesSent, bytesTotal)=> {
            downloadDialog.progressBarValue = bytesSent/bytesTotal
            if(bytesSent/bytesTotal === 1.0){

                downloadDialog.completeBtn.cvisible = true;
                          }
            }
    }

    function mainLoadDb(file){

        scheduler.callParamDb(file);

        fixedTable.establishConnection()

        angleWebContainer.connectToModel();

        passListView.passListInitialize();

        fixedPopupInitialize();
    }

//    function createAngleTable(){
//        var component = Qt.createComponent("Tables/AngleTable.qml");
//        if (component.status === Component.Ready) {
//            angleTableContainer = component.createObject(angleTableWrapper);
//            angleTableContainer.anchors.fill = angleTableWrapper
//            angleTableContainer.anchors.leftMargin = 10
//            angleTableContainer.anchors.topMargin = 10
//            angleTableContainer.anchors.rightMargin = 10
//            angleTableContainer.anchors.bottom =  angleTableWrapper.bottom
//        }
//        angleTableContainer = Qt.createQmlObject(
//                    'import QtQuick 2.15
//                     import QtQuick.Controls 2.15
//                     import "Tables"
//                     import ModelCraft 1.0

//                     AngleTable {
//                        id : angleTable
//                        anchors.fill: parent
//                        anchors.leftMargin: 10
//                        anchors.topMargin: 10
//                        anchors.rightMargin: 10
//                        anchors.bottom: parent.bottom
//                     }
//                     ',
//                    angleTableWrapper)
//    }

    function destroyAngleTable(){
//        angleTableContainer.destroy();
//        angleTableContainer = null;
//        angleTableContainer.visible = false;
        //angleTableContainer.item.destroy();
        angleTableContainer.source = "";

    }

    /// refresh angletable and webview
    function refreshAngleTable(s){
        if(angleTableContainer.source !== ""){
            destroyAngleTable();
            console.log(angleTableContainer.source)
        }

        //createAngleTable();

        angleTableContainer.source = "Tables/AngleTable.qml"
        angleWebContainer.refreshWebTable(s)
    }

    function disconnect(){
        if(scheduler.isPdbLoaded()){
            destroyAngleTable();
            scheduler.callCloseDataBase();
            passListView.clear();
            fixedTable.clear();
            commPop.clear();
            ctrlPop.clear();
            motionPop.clear();
        }
    }

    function fixedPopupInitialize(){
        ctrlPop.ctrlLoad();
        commPop.commLoad();
        motionPop.motionLoad();
    }

    function userLogout(){
        disconnect();
        root.destroy()
        window.minimumWidth = 0
        window.minimumHeight = 0
        window.flags = Qt.FramelessWindowHint | Qt.Window
        window.w = 800
        window.h = 600

    }
    
    function refreshModelData(row, col, value){
        angleRelatedTableModel.callSetData(row, col, value)
    }

    function disable(){
        //ctrlPop.disable();
        //commPop.disable();
        motionPop.disable();
        mainBar.ctrlParamBtn.visible = false;
        mainBar.commParamBtn.visible = false;
    }

    function uploadFile(fileName){
        uploadDialog.cvisibleProgress = true;
        var uploadUrl = downloader.toLocal(popupDb.fileUrl)
        downloader.put(uploadUrl, fileName);
    }

    function downloadfile(fileUrl){
        var downloadFileUrl = downloader.toLocal(fileUrl)
        var downloadFlieName = "/" + ftpDialog.downloadName
        //console.log(downloadFlieName)
        downloader.get(downloadFlieName,  downloadFileUrl+downloadFlieName)
        uploadDialog.close()
    }

    function ftpConfig(ip, port, user, password){
        downloader.setHostPort(ip, port)
        downloader.setUserInfo(user, password)
    }

    function getFTPConfig(){
        downloader.readConfig()
        ftpDialog.ip = downloader.getIP()
        ftpDialog.port = downloader.getPort()
        ftpDialog.user = downloader.getUser()
        ftpDialog.password = downloader.getPassword()
        ftpDialog.uploadName = downloader.getUploadName();
        ftpDialog.downloadName = downloader.getDownloadName();
    }

    function setFTPConfig(){
        downloader.setIP(ftpDialog.ip)
        downloader.setPort(ftpDialog.port)
        downloader.setUser(ftpDialog.user)
        downloader.setPassword(ftpDialog.password)
        downloader.setUploadName(ftpDialog.uploadName)
        downloader.setDownloadName(ftpDialog.downloadName)
        downloader.writeConfig()
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:768;width:1366}D{i:2}D{i:1}D{i:5}D{i:3}D{i:8}D{i:6}
D{i:9}D{i:11}D{i:13}D{i:15}D{i:17}D{i:18}D{i:20}D{i:21}D{i:22}D{i:23}D{i:24}D{i:25}
D{i:26}D{i:27}D{i:28}D{i:29}D{i:30}D{i:31}D{i:32}D{i:33}D{i:34}D{i:35}D{i:36}D{i:37}
}
##^##*/
