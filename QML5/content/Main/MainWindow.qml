import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.15
import "Components"
import "Tables"
import "Popups"
import "Parameters"
import "DraggableChartView"
import "../Login"
//import ModelCraft 1.0

Rectangle {
    id: root
    color: "#ffffff"
    border.color: "#ffffff"
    border.width: 1
    width: 1366
    height: 768
    property var errorMap: { "OperationCanceledError":"连接超时，请确保网络通常与连接正确",
                                "AuthenticationRequiredError":"FTP用户信息错误，请检查FTP设置",
                                "ContentNotFoundError" :"工艺文件在中控端没有找到，请检查FTP设置",
                                "otherError":"出现了预料之外的错误",
                                "downloadConflict":"当前文件已存在且已打开，无法完成下载，请关闭当前文件后再执行下载",
                                "ContentOperationNotPermittedError":"远程端不允许这个操作，请检查本地与中控的FTP设置",
                                "ConnectionRefusedError":"远程端拒绝连接，请检查中控端设定",
                                "HostNotFoundError":"Host没有找到，请检查FTP设置",
                                "TimeoutError" : "连接超时,请检查网络连接",
                                "TemporaryNetworkFailureError" : "由于与网络断开连接，连接中断，但系统已开始漫游到另一个接入点。请重新提交请求，并在重新建立连接后立即处理。",
                                "RemoteHostClosedError" : "远程服务器在接收和处理整个回复之前提前关闭了连接，请重新尝试",
                                "ContentAccessDenied" :  "对远程内容的访问被拒绝，确认中控端下该文件的读写权限，或者可能是远程端提前终止了用户连接",
                                "ContentConflictError" : "由于与资源的当前状态冲突，请求无法完成",
                                "ProtocolUnknownError" : "网络访问 API 无法接受请求，因为协议未知，请检查协议",
                                "UnknownContentError" :  "检测到与远程内容相关的未知错误"
       }

    Rectangle {
        id: webEngineWrapper
        color: "#f9f9f9"
        border.width: 0
        anchors.left: passListView.right
        anchors.right: angleTableWrapper.left
        anchors.top: mainBar.bottom
        anchors.bottom: fixedTableWrapper.top
        anchors.leftMargin: 0
        anchors.topMargin: 0

//        WebChart {
//            id: angleChart
//            anchors.fill:parent

//            lock: lockBtn.checked
//            onWebCallBack: (row, col, value) => refreshModelData(row, col,value)
//        }
        DraggableChart {
            id: angleChart

            anchors.fill: parent

            locked: lockBtn.checked
            backgroundColor: webEngineWrapper.color
            // plotRec: Qt.rect(webEngineWrapper.x, webEngineWrapper.y, webEngineWrapper.x + webEngineWrapper.width, webEngineWrapper.y + webEngineWrapper.height)

        }
    }

    Rectangle {
        id: angleTableWrapper
        //x: 1062
        width: 300
        color: "#dbdbdb"
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
        color: "#cbcbcb"
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

            color: "#cbcbcb"

            width: 1206
            height: 160
        }
    }

    PassListView {
        id: passListView
        width: 160

        color: "#dcdcdc"
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

        color: "#d4d4d4"
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
        function getCurruntName(){
            curFilename = "工艺文件名:" + downloader.toLocal(fileDialog.curruntFileUrl)
        }
        function clearCurruntName(){
             curFilename = "工艺文件名:"
        }
    }

    MainBar {
        id: mainBar
        height: 50
        color: "#CBCBCB"

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
            radius: 8
            spread: 0
            samples: 17
            horizontalOffset: 0
            verticalOffset: 0


        }
        z: 2

        PopupDb {
            id: popupDb

            x: 25
            y: parent.height + 1

            //property var fileUrl
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

                if(scheduler.isPdbLoaded())
                    disconnectDialog.open();
            }

            InfoDialog {
                id: disconnectDialog

                parent: Overlay.overlay
                x: (parent.width - disconnectDialog.width)/2
                y: (parent.height - disconnectDialog.height)/2
                title: "确定要关闭工艺文件吗?"
                text.text: "未保存的修改将会被放弃，确定要继续吗？"
                text.color: "#202020"

                imageSource: "../images/caution.png"

                cancelBtn.text: "取消"
                confirmBtn.text: "确定"
                cancelBtn.onClicked: disconnectDialog.close()

                confirmBtn.onClicked: {
                    disconnect();
                    disconnectDialog.close()

                }
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
                popupDb.close();
                if(scheduler.isPdbLoaded())
                    saveAsDialog.open();
            }
            InfoDialog {
                id: saveAsDialog

                parent: Overlay.overlay
                x: (parent.width - saveAsDialog.width)/2
                y: (parent.height - saveAsDialog.height)/2
                title: "你确定要保存吗？"
                text.text: "如果还有未提交的修改，保存的副本将不包含未提交的修改，你确定要继续吗?"
                text.color: "#202020"

                imageSource: "../images/caution.png"

                cancelBtn.text: "取消"
                confirmBtn.text: "确定"
                cancelBtn.onClicked: saveAsDialog.close()

                confirmBtn.onClicked: {
                    saveDialog.open();
                    saveAsDialog.close();
                }
            }

            downloadBtn.onClicked: {
                popupDb.close();
                downloadFile.open();
            }

//            passBtn.onClicked:{
//                if(scheduler.isPdbLoaded()){
//                    popupDb.close();
//                    onePassDialog.open();
//                }
//            }

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
        anchors.left: passListView.right
        anchors.leftMargin: 15
        anchors.top: mainBar.bottom
        anchors.topMargin: 15

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
            radius: 8
            samples: 17
            spread: 0
            verticalOffset: 0
            horizontalOffset: 0
        }
        onToggled: {console.log("lock changed!"); angleChart.locked = checked}
    }

    CancelBtn {
        id: revokeButton

        anchors{
          right: submitSingleButton.right
          bottom: submitSingleButton.top
          bottomMargin: 10
        }
        //anchors.bottom: submitButton.top
        //anchors.horizontalCenterOffset: 0
        //anchors.horizontalCenter: submitButton.horizontalCenter
        //anchors.bottomMargin: 62
        z: 3
        onClicked:if(scheduler.isPdbLoaded() && scheduler.callIsDirty()) dbCancelDialog.open()

        InfoDialog {
            id: dbCancelDialog

            parent: Overlay.overlay
            x: (parent.width - dbCancelDialog.width)/2
            y: (parent.height - dbCancelDialog.height)/2

            text.text: "所有已经修改但还未提交的数据将被丢弃，确定要撤销所有修改吗？"
            title: "放弃未提交的数据修改？"
            text.color: "#202020"
            imageSource: "../images/information.png"

            cancelBtn.onClicked: dbCancelDialog.close()

            confirmBtn.onClicked: {
                if(scheduler.isPdbLoaded()){
                    scheduler.revertData();
                    fixedTable.fixedTableRefreshData();
                    passListView.refreshPassList();
                    commPop.commLoad();
                    ctrlPop.ctrlLoad();
                    motionPop.motionLoad();

                    dbCancelDialog.close()
                }
            }
        }
    }

    SubmitBtn {
        id: submitSingleButton
        btnText: "上传选中焊道"
        anchors{
          right: submitButton.right
          bottom: submitButton.top
          bottomMargin: 10
        }
        z: 3
        imgSrc: "../images/SubmitOne.png"

        onClicked:{
            if(scheduler.isPdbLoaded()){
                popupDb.close();
                onePassDialog.open();
            }
        }
    }

    ExitBtn {
        id: exitBtn
        //x: 1316
        //x: 1317
        //y: 8
        width: 42
        height: 37

        anchors{
          right: mainBar.right
          rightMargin: 8
          verticalCenter: mainBar.verticalCenter
        }
        //anchors.right: mainBar.right
        //anchors.top: mainBar.top
        //anchors.bottom: mainBar.bottom
        antialiasing: false
        z: 4

        LogoutPopup{
            id:logoutPopup
            x: exitBtn.x - (logoutPopup.width - exitBtn.width)
            y: exitBtn.y + exitBtn.height
            z:3

            closePolicy: Popup.CloseOnReleaseOutsideParent

            logoutBtn.onClicked:{
                logoutPopup.close();
                if(scheduler.isPdbLoaded() && scheduler.callIsDirty())
                    logoutDialog.open();
                else
                    userLogout();
            }
        }

        onClicked: {
            if(logoutPopup.opened)
                logoutPopup.close();
            else
                logoutPopup.open();
        }

        InfoDialog {
            id: logoutDialog

            parent: Overlay.overlay
            x: (parent.width - logoutDialog.width)/2
            y: (parent.height - logoutDialog.height)/2

            text.text: "未提交的数据将会丢失，确定要切换用户吗？"
            title: "你的修改未提交保存！"
            text.color: "#202020"
            imageSource: "../images/caution.png"

            cancelBtn.onClicked: logoutDialog.close()

            cancelBtn.text:"取消"
            confirmBtn.text:"确定"
            confirmBtn.onClicked:{
                userLogout();
            }
        }
    }

    SubmitBtn {
        id: submitButton
        btnText: "提交数据"

        anchors{
          right: parent.right
          bottom: parent.bottom
          rightMargin: 30
          bottomMargin: 60
        }
        z: 3
        imgSrc: "../images/SubmitThree.png"

        onClicked: if(scheduler.isPdbLoaded() && scheduler.callIsDirty()) dbSubmitDialog.open()

        InfoDialog {
            id: dbSubmitDialog

            parent: Overlay.overlay
            x: (parent.width - dbSubmitDialog.width)/2
            y: (parent.height - dbSubmitDialog.height)/2

            text.text: "一旦提交修改，操作不可撤销，请确认是否提交数据？"
            title: "确定要提交数据吗？"
            text.color: "#202020"
            imageSource: "../images/information.png"

            cancelBtn.onClicked: dbSubmitDialog.close()

            confirmBtn.onClicked:{
                if(scheduler.isPdbLoaded()){
                    scheduler.submitData();
                    fixedTable.fixedTableRefreshData();
                    passListView.refreshPassList();
                    commPop.commLoad();
                    ctrlPop.ctrlLoad();
                    motionPop.motionLoad();

                    dbSubmitDialog.close()
                }
            }
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

//        confirmBtn.onClicked: {
//            scheduler.submitData()
//            disconnect();
//            reconnectDialog.close()
//            fileDialog.open();
//        }
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
        property var curruntFileUrl
        onAccepted: {
            fileDialog.curruntFileUrl = fileUrl
            //popupDb.fileUrl = fileUrl
            //console.log(popupDb.fileUrl)
            mainLoadDb(fileUrl)

        }
        function clear(){
            curruntFileUrl = ""

        }
    }

    FileDialog {
        id: downloadFile
        //selectFolder : true
        nameFilters:["Datase files(*.db)"]
        //folder: shortcuts.home
        onAccepted: downloadfile()
        selectExisting: false
    }

    UploadDialog{
        id:uploadDialog
        x: (root.width - uploadDialog.width)/2
        y: (root.height - uploadDialog.height)/2

        cancelBtn.onClicked: {
            uploadDialog.clear()
           }

        confirmBtn.onClicked: {
            uploadDialog.cvisibleProgress = true;
            uploadFile()
            title = "正在传输中..."
            confirmBtn.visible = false
        }

        completeBtn.onClicked: {
            uploadDialog.clear()

        }
        function clear(){
            uploadDialog.progressBar.indeterminate = true;
            cvisibleProgress = false
            progressBarValue = 0.0
            completeBtn.cvisible = false;
            confirmBtn.cvisible = true;
            title = "你是否要将当前文件上传到中控？"
            uploadDialog.close()
        }
    }

    DownloadDialog{
        id:downloadDialog
        x: (root.width - reconnectDialog.width)/2
        y: (root.height - reconnectDialog.height)/2
        cancelBtn.onClicked: {
            downloadDialog.clear()

        }
        completeBtn.onClicked: {
            downloadDialog.clear()

        }
        function clear(){
            downloadDialog.progressBar.indeterminate = true;
            progressBarValue = 0.0
            completeBtn.cvisible = false;
            title = "正在下载文件中..."
            downloadDialog.close()
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

    InfoDialog {
        id: errorDialog

        x: (parent.width - errorDialog.width)/2
        y: (parent.height - errorDialog.height)/2

        //text.text: "本操作将不可被撤销，请确认是否撤销所有修改"
        title: "出现了错误"
        text.color: "#202020"
        imageSource: "../images/information.png"
        confirmBtn.text: "确定"
        confirmBtn.onClicked: {
            errorDialog.close()
            closeDialog()
                        }

        cancelBtn.visible: false

    }

    InfoDialog {
        id: onePassDialog

        x: (parent.width - onePassDialog.width)/2
        y: (parent.height - onePassDialog.height)/2

        text.text: "把当前选中焊道数据上传至中控，且该操作不可撤销，请确认是否上传数据？"
        title: "你是否要上传当前选中的焊道数据？"
        text.color: "#202020"
        imageSource: "../images/information.png"
        confirmBtn.text: "确定"
        confirmBtn.onClicked: {
            if(scheduler.isPdbLoaded()){
                pushSelectedTableToRemote()
                //scheduler.pushSelectedTable(passListView.currentIndex, ftpDialog.downloadName);
                onePassDialog.close();
                onePassComplete.open();
            }
        }

        cancelBtn.onClicked: {
            onePassDialog.close();
        }
    }

    InfoDialog {
        id: onePassComplete

        x: (parent.width - onePassDialog.width)/2
        y: (parent.height - onePassDialog.height)/2

        text.text: ""
        title: "正在上传中..."
        text.color: "#202020"
        imageSource: "../images/information.png"
        cancelBtn.text: "取消"
        cancelBtn.onClicked: {
            onePassComplete.close()
            onePassComplete.clear()
        }

        completeBtn.onClicked: {
            onePassComplete.close()
            onePassComplete.clear()
        }
        confirmBtn.visible: false
        completeBtn.text: "完成"
        function clear(){
            title =  "正在上传中..."
            completeBtn.visible = false
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

//    Connections {
//        target: downloader
//        onUpProgress: (bytesSent, bytesTotal)=> {
//            uploadDialog.progressBarValue = bytesSent/bytesTotal
//            if(bytesSent/bytesTotal === 1.0){
//                uploadDialog.completeBtn.cvisible = true;
//                uploadDialog.confirmBtn.cvisible = false;
//                uploadDialog.title = "传输完成"
//            }
//        }
//    }

    Connections {
        target: downloader
        onFinishUpload:  {
            uploadDialog.progressBar.indeterminate = false;
            uploadDialog.progressBarValue = 1.0
            uploadDialog.completeBtn.cvisible = true;
            uploadDialog.confirmBtn.cvisible = false;
            uploadDialog.title = "传输完成"

        }
    }

//    Connections {
//        target: downloader
//        onDownProgress: (bytesSent, bytesTotal)=> {
//            downloadDialog.progressBarValue = bytesSent/bytesTotal
//            if(bytesSent/bytesTotal === 1.0){

//                downloadDialog.completeBtn.cvisible = true;
//                downloadDialog.title = "传输完成"
//                          }
//            }
//    }

    Connections {
        target: downloader
        onFinishDownload:  {
            downloadDialog.progressBar.indeterminate = false;
            downloadDialog.progressBarValue = 1.0
            downloadDialog.completeBtn.cvisible = true;
            downloadDialog.title = "传输完成"
                          }

    }

    Connections {
        target: downloader
        onSendErrorMsg: errorMsg => {
            errorDialog.text.text = errorMap[errorMsg]
            errorDialog.open()
            }
    }
//singleTableStep1Finished

    Connections {
        target: downloader
        onStartSingleTableStep2and3: {
            var tempName = "temp.db"; //临时文件名称
            var tempFileUrl = appDir+"/Database/" + tempName;
            var downloadFlieName = "/" + ftpDialog.uploadName; // "/wp.db"
            console.log(ftpDialog.uploadName);
            setFTPConfig()
            scheduler.pushSelectedTable(passListView.currentIndex, tempName);//write
            downloader.put(tempFileUrl, ftpDialog.uploadName, "singleTable"); //upload to remote
            }
    }

    Connections {
        target: downloader
        onSingleTableAllFinished: {
                onePassComplete.title = "传输完成"
                onePassComplete.completeBtn.visible =true;
            }
    }

    function mainLoadDb(file){

        scheduler.callParamDb(file);

        angleRelatedTableModel.onDataReady.connect((m, l) => { refreshAngleTable() })

        fixedTable.establishConnection()

        angleChart.connectToModel();

        passListView.passListInitialize();

        fixedPopupInitialize();

        statusBar.getCurruntName()
    }

    function createAngleTable(){
        angleTableContainer.source = "Tables/AngleTable.qml"
    }

    function destroyAngleTable(){
        angleTableContainer.source = "";
    }

    /// refresh angletable and webview
    function refreshAngleTable(){
        if(angleTableContainer.source !== ""){
            destroyAngleTable();
            console.log(angleTableContainer.source)
        }
        createAngleTable();

        // angleChart.refreshWebTable()
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
            fileDialog.clear();//clear curruntFileurl
            statusBar.clearCurruntName()// clear statusBar's currunt fileName
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
        window.x = Screen.width / 2 - window.width / 2
        window.y = Screen.height / 2 - window.height / 2

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

    function uploadFile(){

        var uploadUrl = downloader.toLocal(fileDialog.curruntFileUrl)
        downloader.put(uploadUrl, ftpDialog.uploadName,"default");
    }

//    function downloadfile(){
//        var downloadFileUrl = downloader.toLocal(downloadFile.fileUrl)   // "D:/datasave"
//        var downloadFlieName = "/" + ftpDialog.downloadName // "/wp.db"

//        var downName = downloadFileUrl+downloadFlieName
//        var loadName = downloader.toLocal(fileDialog.curruntFileUrl)
//        if(downName === loadName && scheduler.isPdbLoaded() ){
//            errorDialog.text.text = errorMap["downloadConflict"]
//            errorDialog.open()
//        }
//        else if(!downloader.checkIfExist(downName)){
//            downloadDialog.open()
//            downloader.get(downloadFlieName,  downloadFileUrl+downloadFlieName, "default")
//        }
//            else
//                fileConflict.open()
//    }
    function downloadfile(){
        var downloadFileUrl = downloader.toLocal(downloadFile.fileUrl)   // eg: "D:/datasave/wp.db"
        var downloadFlieName = "/" + ftpDialog.uploadName // "/wp.db"
        //var downName = downloadFileUrl+downloadFlieName
        var loadName = downloader.toLocal(fileDialog.curruntFileUrl)
        if(downloadFileUrl === loadName && scheduler.isPdbLoaded() ){
            errorDialog.text.text = errorMap["downloadConflict"]
            errorDialog.open()
        }
        else {
            downloadDialog.open()
            downloader.get(downloadFlieName, downloadFileUrl, "default")
        }


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
        //ftpDialog.downloadName = downloader.getDownloadName();
    }

    function setFTPConfig(){
        downloader.setIP(ftpDialog.ip)
        downloader.setPort(ftpDialog.port)
        downloader.setUser(ftpDialog.user)
        downloader.setPassword(ftpDialog.password)
        downloader.setUploadName(ftpDialog.uploadName)
        //downloader.setDownloadName(ftpDialog.downloadName)
        downloader.writeConfig()
    }

    function pushSelectedTableToRemote(){//step1
        var tempName = "temp.db"
        var tempFileUrl = appDir+"/Database/" + tempName

        console.log("GG:"+tempFileUrl)
        var downloadFlieName = "/" + ftpDialog.uploadName // "/wp.db"
        downloader.get(downloadFlieName, tempFileUrl, "singleTable") //download temp.db to appDir
        //scheduler.pushSelectedTable(tableIndex, tempName);//write
        //downloader.put(tempFileUrl, ftpDialog.uploadName); //upload to remote
    }

    function closeDialog(){//执行一遍所有下载有关的cancelbtn做的事

        uploadDialog.clear()

        downloadDialog.clear()

        onePassComplete.close();
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:2}D{i:1}D{i:5}D{i:3}D{i:8}D{i:6}D{i:9}D{i:11}D{i:13}
D{i:17}D{i:15}D{i:20}D{i:21}D{i:24}D{i:23}D{i:26}D{i:25}D{i:27}D{i:29}D{i:28}D{i:30}
D{i:31}D{i:32}D{i:33}D{i:34}D{i:35}D{i:36}D{i:37}D{i:38}D{i:39}D{i:40}D{i:41}D{i:42}
D{i:43}D{i:44}D{i:45}D{i:46}D{i:47}D{i:48}D{i:49}
}
##^##*/
