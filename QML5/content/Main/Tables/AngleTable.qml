import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQml 2.15
import "MultiSelection"

Rectangle {
    id: widget

    signal webTableRequestFresh(int row, int column, string text )

    width: 300
    height: 770

    visible: true
    enabled: true
    color: "transparent"
    border.color: "#ffffff"
    border.width: 0

    property bool isCheck : false
    property var multiModeCopy : null

    property var engToChn : {//cmd <------> table column name
        "angle"         :"角度\n(度)",
        "stayTime_Lead" :"前枪边停时间\n(秒)",
        "oscWidth_Lead" :"前枪摆宽\n(毫米)",
        "oscFreq_Lead"  :"前枪摆动周期\n(毫秒)",   //？
        "feedRate_Lead" :"前枪送丝速度\n(毫米/秒)",
        "Arc_Rate_Lead" :"前枪电弧修正\n(伏特)",
        "Arc_Rate_Trail":"后枪电弧修正\n(伏特)",
        "stayTime_Trail":"后枪边停时间\n(秒)",
        "oscWidth_Trail":"后枪摆宽\n(毫米)",
        "oscFreq_Trail" :"后枪摆动周期\n(毫秒)",
        "feedRate_Trail":"后枪送丝速度\n(毫米/秒)",
        "carACC"        :"小车加速度\n(毫米/秒²)",
        "carSPEED"      :"小车速度\n(毫米/秒)",
        "leadTargetCur" :"前枪垂向目标值\n(毫米)",
        "trailTargetCur":"后枪垂向目标值\n(毫米)"
    }


    ListView {
        id: header


        implicitWidth: parent.width
        height: 35
        anchors.left: view.left
        anchors.right: view.right
        anchors.top: parent.top
        anchors.topMargin: 0
        implicitHeight: 35
        orientation: ListView.Horizontal

        interactive: false
        enabled: false


        currentIndex: -1

        model: ListModel{
            id:listModel

            Component.onCompleted: {
                for (var i = 0; i < view.columns; i++ )
                    listModel.append({"headerName": engToChn[angleRelatedTableModel.headerNameEng(i)]})
            }
        }

        highlightFollowsCurrentItem: true
        highlight: Rectangle {
            width: header.width/header.count; height: 35
            color: "lightsteelblue"; radius: 5
//            x: list.currentItem.x
//            Behavior on x {
//                SpringAnimation {
//                    spring: 3
//                    damping: 0.2
//                }
//            }
            }
        delegate: Button {
            id: headerDelegate

            implicitWidth: header.width/header.count
            implicitHeight: 35
            background: delegateBg
            Rectangle {
                id: delegateBg
                anchors.fill: parent
                color: "transparent"
            }

            contentItem:delegateContent
            Item {
                id:delegateContent

                anchors.fill: parent

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
            enabled: index === 0 ? false : true
            onClicked: {
                if(header.currentIndex === index){
                    disableColumn(index);
                    header.currentIndex = -1;
                }
                else{
                    enableColumn(index);
                    header.currentIndex = index;
                }
            }
        }
    }

    TableModel {
        id: checkboxModel
        TableModelColumn { display: "checkStatus" }
        Component.onCompleted: checkbxModelCreate()
    }

    TableView {
        id: checkboxView

        width:0

        anchors.left: parent.left
        anchors.top: view.top
        anchors.bottom: view.bottom
        model:checkboxModel
        flickableDirection: Flickable.VerticalFlick
        clip: true
        syncView: view
        syncDirection:Qt.Vertical
        reuseItems: true
        delegate: Item {
            id: checkbxDelegate
            implicitHeight: 35
            implicitWidth: 30
            property string type : "checkbox"
            property alias check: delegateCheckbx.checked

            SelectCheckBx {
                id: delegateCheckbx
                implicitWidth: 20
                implicitHeight: 20
                //checked: model.display
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.IconOnly
                anchors.horizontalCenter: parent.horizontalCenter

                onCheckedChanged: {
                    model.display = checked
                    rowSelectChange(row, checked);
                }
            }
            Component.onCompleted: {
                addGroup(delegateCheckbx)
                delegateCheckbx.checked = model.display
            }
        }
    }

    TableView {
        id: view

        width: parent.width

        anchors.left: checkboxView.right
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: calculation.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0

        columnWidthProvider: function (column) { return view.width/view.columns }
        //TODO : load model

        model: angleRelatedTableModel
        flickableDirection: Flickable.VerticalFlick
        clip: true
        reuseItems: true

        delegate: Item {
            id: tableDelegate

            implicitWidth: view.width/view.columns
            implicitHeight: 35


            Rectangle {
                id: delegateWrapper

                anchors.fill: parent

                border.width: 0;
                color: {
                    if(column === 0)
                        return "transparent"
                    else {
                        if(!widget.isCheck)
                            return "transparent"
                        else{
                            if(model.isSelect)    return "#0D267B"
                            else            return "transparent"
                        }
                    }
                }

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

                    visible: column === view.columns - 1 ? false : true
                }

                AngleTextField {
                    id:textField
                    text: model.display
                    color: widget.isCheck ? (isSelect? "#ffffff" : isDirty ? "#cc5555" : "#0d0d0d") : (isDirty ? "#cc5555":"#0d0d0d")
                    readOnly: column === 0 ? true: false
                    anchors.fill: parent

                    onEditingFinished: {
                        angleRelatedTableModel.callSetData(row, column, text)
                        textField.focus = false
                    }

                }
            }

        }

//        Component.onCompleted: {
//            console.log("view columns after complete: " + view.columns)
//            console.log("model (row, column) :" + "(" + angleRelatedTableModel.rowCount() + "," + angleRelatedTableModel.columnCount() + ")")
//        }

        ScrollBar.vertical: ScrollBar{}
    }

    MultiCalulation {
        id: calculation

        visible: false
        enabled:  visible
        anchors.horizontalCenter: widget.horizontalCenter
        anchors.bottom: multiselect.top
        anchors.bottomMargin: 10

        onAddRequest: angleRelatedTableModel.callAddToModel(n, true)
        onMinusRequest: angleRelatedTableModel.callAddToModel(n, false)
    }

    OperationBtn {
        id: multiselect
        y: 723

        textItemColor: "#202020"
        buttonBackgroundBordercolor: "#202020"
        wrapperColor: "#472b2b2b"

        text: qsTr("批量操作")
        enabled: visible
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            disableSingleSelect(view)
            restoreBeforeOp()
            widget.isCheck = true
        }
    }


    OperationBtn {
        id: cancel
        text: qsTr("取消")

        textItemColor: "#B90000"
        buttonBackgroundBordercolor: "#B90000"
        wrapperColor: "#5df74f4f"
        visible : false
        enabled: visible
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: multiselect.verticalCenter

        onClicked: {
            reset()
            enableSingleSelect(view);
            refreshAfterCancel();

            widget.isCheck = false
        }
    }

    OperationBtn {
        id: confirm
        text: qsTr("确认")

        textItemColor: "#0B8559"
        buttonBackgroundBordercolor: "#0B8559"
        wrapperColor: "#5f4df056"

        visible: false
        enabled: visible
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: multiselect.verticalCenter

        onClicked: {
            reset()
            enableSingleSelect(view);
            calculation.clear()
            widget.isCheck = false
        }
    }

    Timer {
        id: resizeTimer
        interval: 10
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: {view.forceLayout()}
    }

    ButtonGroup {
        id: groupBtn
        exclusive: false
        checkState: rootCheckbx.checkState
    }

    SelectCheckBx {
        id: rootCheckbx
        checked: display
        width: 20
        height: 20
        visible: false

        tristate: true
        anchors.verticalCenter: header.verticalCenter
        display: AbstractButton.IconOnly
        anchors.horizontalCenter: checkboxView.horizontalCenter
        checkState: groupBtn.checkState


        nextCheckState: function() {
                if (checkState === Qt.Checked)
                    return Qt.Unchecked
                else
                    return Qt.Checked
            }

        onCheckStateChanged: {
            var i = 0
            if(checkState === Qt.Checked)
                for(i = 0; i < checkboxModel.rowCount; i++)
                    checkboxModel.setData(checkboxModel.index(i,0), "display", true)
            else if(checkState === Qt.Unchecked)
                for(i = 0; i < checkboxModel.rowCount; i++)
                    checkboxModel.setData(checkboxModel.index(i,0), "display", false)
        }
    }

    states: [
        State {
            name: "check"
            when: widget.isCheck

            PropertyChanges {
                target: checkboxView
                width: 30
            }

            PropertyChanges {
                target: view
                anchors.bottomMargin: calculation.height + 5
            }

            PropertyChanges {
                target: rootCheckbx
                visible: true
            }

            PropertyChanges {
                target: multiselect
                visible: false
            }

            PropertyChanges {
                target: cancel
                visible: true
            }
            PropertyChanges {
                target: confirm
                visible: true
            }

            PropertyChanges {
                target: calculation
                visible: true
            }

            PropertyChanges {
                target: header
                enabled: true
            }


        },
        State {
            name: "normal"
            when: !widget.isCheck

            PropertyChanges {
                target: multiselect
                visible: true
            }
        }
    ]
    transitions: [
        Transition {
            id: transition
            SequentialAnimation {
                PropertyAnimation {
                    target: view
                    property: "anchors.bottomMargin"
                    duration: 50
                }
                PropertyAnimation {
                    target: checkboxView
                    property: "width"
                    duration: 100
                }
                PropertyAnimation {
                    target: calculation
                    property: "visible"
                    duration: 0
                }
            }
            onRunningChanged: {
                if(running === true)
                    resizeTimer.start()
                else{
                    resizeTimer.stop()
                    view.forceLayout()
                }
            }
            to: "check"
            from: "*"
        },
        Transition {
            id: transition1
            SequentialAnimation {
                PropertyAnimation {
                    target: calculation
                    property: "visible"
                    duration: 0
                }
                PropertyAnimation {
                    target: checkboxView
                    property: "width"
                    duration: 100
                }
                PropertyAnimation {
                    target: view
                    property: "anchors.bottomMargin"
                    duration: 50
                }
            }
            onRunningChanged: {
                if(running === true)
                    resizeTimer.start()
                else{
                    resizeTimer.stop()
                    view.forceLayout()
                }
            }
            to: "normal"
            from: "*"
        }
    ]
    ///
    /// \functions and signals
    ///
    function checkbxModelCreate(){
        for(var i = 0; i < view.rows; i++){
            checkboxModel.appendRow({"checkStatus":false})
        }
        //qDebug.log(checkboxModel.rows[2])
    }

    function addGroup(button){
        groupBtn.addButton(button)
    }

    function reset(){
        header.currentIndex = -1
        initializeCheckModel()
        initializeCheckbox(checkboxView)
        initializeSelection()
    }

    function initializeSelection(){
        for(var i = 0; i < view.rows; i++){
            for(var j = 1; j < view.columns; j++)
                 angleRelatedTableModel.callSetSelect(i, j, false);
        }
    }

    function initializeCheckModel(){
        for(var i = 0; i < checkboxModel.rowCount; i++){
            checkboxModel.setData(checkboxModel.index(i,0), "display", false)
        }
    }

    function initializeCheckbox(item){
        if(item.type === "checkbox"){
            item.check = false
            return
        }
        for(var i = 0; i < item.children.length; i++){
            initializeCheckbox(item.children[i])
        }
    }


    function disableSingleSelect(item){
        if(item.type === "editable"){
            item.disable()
            return
        }
        for(var i = 0; i < item.children.length; i++){
            disableSingleSelect(item.children[i])
        }
    }

    function enableSingleSelect(item){
        if(item.type === "editable"){
            item.enable()
            return
        }
        for(var i = 0; i < item.children.length; i++){
            enableSingleSelect(item.children[i])
        }
    }

    function rowSelectChange(index, checked){
        if(header.currentIndex === -1)
            return
        else angleRelatedTableModel.callSetSelect(index, header.currentIndex, checked);
    }


    // column related
    function disableColumn(index){
        for(var i =0; i < view.rows; i++)
            angleRelatedTableModel.callSetSelect(i, index, false);
    }

    function enableColumn(index){
        for(var i = 0; i < view.rows; i++){
            for(var j = 1; j < view.columns; j++)
                if(j === index)
                    angleRelatedTableModel.callSetSelect(i, j, checkboxModel.rows[i].checkStatus);
                else
                    angleRelatedTableModel.callSetSelect(i, j, false);
        }
    }

    function modelToCopy(){
        var copy = []
        for(var i = 0; i < view.rows; i++){
            var storeRow = []
            for(var j = 0; j < view.columns; j++)
                storeRow.push(angleRelatedTableModel.callGetData(i, j))
            copy.push(storeRow)
        }
        multiModeCopy =  copy;
    }

    function copyToModel(){
        console.log("write")
        if(multiModeCopy !== null){
            for(var i = 0; i < view.rows; i++){
                for(var j = 0; j < view.columns; j++){
                    if(multiModeCopy[i][j] !== angleRelatedTableModel.callGetData(i, j)){
                        angleRelatedTableModel.callSetData(i, j, multiModeCopy[i][j])
                        console.log("write")
                    }
                    console.log(multiModeCopy[i][j])
                }
            }
        }
    }

    function refreshAfterCancel(){
        angleRelatedTableModel.callRevert();
        copyToModel()
    }

    function restoreBeforeOp(){
        modelToCopy()
    }
}
