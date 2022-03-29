﻿import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import QtQuick.Dialogs 1.3
import "Components"
import "Tables"
import "Popups"
import "Parameters"
import "../Login"
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

        PopupDb {
            id: popupDb

            x: 25
            y: parent.height + 1

            property var fileUrl
            closePolicy: Popup.CloseOnReleaseOutsideParent

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

        onClicked: {
            if(popupDb.opened)
                popupDb.close();
            else
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

        InfoDialog {
            id: dbCancelDialog

            parent: Overlay.overlay
            x: (parent.width - dbCancelDialog.width)/2
            y: (parent.height - dbCancelDialog.height)/2

            text.text: "这个操作将不可被撤销，请确认是否撤销所有修改"
            title: "您确定要撤销所有修改吗"
            text.color: "#202020"
            imageSource: "../images/information.png"

            cancelBtn.onClicked: dbCancelDialog.close()

            confirmBtn.onClicked: {
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

        onClicked:if(scheduler.callIsDirty()) dbCancelDialog.open()


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

        InfoDialog {
            id: dbSubmitDialog

            parent: Overlay.overlay
            x: (parent.width - dbSubmitDialog.width)/2
            y: (parent.height - dbSubmitDialog.height)/2

            text.text: "这个操作将不可被撤销，请确认是否提交修改"
            title: "您确定要提交吗"
            text.color: "#202020"
            imageSource: "../images/information.png"

            cancelBtn.onClicked: dbSubmitDialog.close()

            confirmBtn.onClicked:{
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

        onClicked: if(scheduler.callIsDirty()) dbSubmitDialog.open()
    }

    ExitBtn {
        id: exitBtn
        x: 1316
        //x: 1317
        //y: 8
        width: 42
        height: 37
        anchors.rightMargin: 8
        anchors{
          right: mainBar.right
          verticalCenter: mainBar.verticalCenter
        }
        //anchors.right: mainBar.right
        //anchors.top: mainBar.top
        //anchors.bottom: mainBar.bottom
        antialiasing: true
        z: 4

        LogoutPopup{
            id:logoutPopup
            x: exitBtn.x - (logoutPopup.width - exitBtn.width)
            y: exitBtn.y + exitBtn.height
            z:3

            closePolicy: Popup.CloseOnReleaseOutsideParent

            closeBtn.onClicked: {
                logoutPopup.close();
                pwPopup.open();

            }

            logoutBtn.onClicked:{
                logoutPopup.close();
                userLogout()
            }
        }

        onClicked: {
            if(logoutPopup.opened)
                logoutPopup.close();
            else
                logoutPopup.open();
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
        x: (root.width - uploadDialog.width)/2
        y: (root.height - uploadDialog.height)/2

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


    FtpDialog {
        id:ftpDialog
        x: (root.width - ftpDialog.width)/2
        y: (root.height - ftpDialog.height)/2

        cancelBtn.onClicked: ftpDialog.close()

        confirmBtn.onClicked: {
            ftpConfig(ip, port, user, password)
            setFTPConfig()
            ftpDialog.close()
        }

    }

    FileDialog {
        id:saveDialog

        selectExisting: false
        nameFilters: [ "database files (*.db)" ]

        onAccepted: {
            console.log(fileUrl)
            scheduler.saveToFile(fileDialog.fileUrl, saveDialog.fileUrl);

        }
    }

    Popup {
        id: pwPopup

        x: (root.width - pwPopup.width)/2
        y: (root.height - pwPopup.height)/2

        width: 400
        height: 500

        modal: true

        closePolicy: Popup.NoAutoClose

        Overlay.modal: Rectangle {
            color: "#c0515151"
        }

        background: bg
        Rectangle {
            id:bg
            anchors.fill: parent
            color: "transparent"
            border.width: 0
        }

        InformationManagemet {
            id: im
            anchors.centerIn: parent
            radius: 8
            z: 1
            back.onClicked: pwPopup.close();
            confirm.onClicked:{
                if(userVerify()){
                    if(pwVerify()){
                        if(pwUpdate(inputID.inputText.text,inputOldPw.inputText.text,inputNewPw.inputText.text)){
                            errorMsg.text = "密码修改成功！";
                            pwPopup.close();
                        }
                        else
                            errorMsg.text = "密码修改失败，请检查是否符合规范";
                    }
                }
            }
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

    function createAngleTable(){
        angleTableContainer.source = "Tables/AngleTable.qml"
    }

    function destroyAngleTable(){
        angleTableContainer.source = "";
    }

    /// refresh angletable and webview
    function refreshAngleTable(s){
        if(angleTableContainer.source !== ""){
            destroyAngleTable();
            console.log(angleTableContainer.source)
        }
        createAngleTable();

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
