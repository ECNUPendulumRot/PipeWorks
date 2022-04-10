import QtQuick 2.15
import QtQuick.Controls 2.15
import "Components"

Rectangle {
    id: rectangle
    width: 160
    height: 768
    color: "#dcdcdc"
    border.color: "#ffffff"

    property var mapping:{
        "flag"      :28,
    }

    signal passListRequestRefreshcombobx()
    signal passListRequestFixTableRefresh(int i)

    property int currentIndex : -1

    Rectangle {
        id: seperateLine
        height: 1
        color: "#707070"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 55
        z: 2
    }

    ButtonGroup {
        id: exclusiveGroup
    }

    Component {
        id: passDelegate
        PassListBtn {
            id: passListBtn
            col: i
            passEditBtnVisible: v
            text: "焊道"
            ButtonGroup.group: exclusiveGroup
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: switchPass(col)
            onFlagChanged: {
                if(scheduler.isPdbLoaded()){
                    passFTableModel.callSetData(col, mapping["flag"], flag)
                }
            }
        }
    }

    ListModel {
        id: pass1Model
        ListElement {
            i: 0
            v: true
        }
        ListElement {
            i: 1
            v: true
        }
    }
    ListModel {
        id: pass2Model
//        ListElement {
//            i: 2
//            v: false
//        }
    }
    ListModel {
        id: pass3Model
        ListElement {
            i: 8
            v: true
        }
        ListElement {
            i: 9
            v: true
        }
        ListElement {
            i: 10
            v: true
        }
    }

    ListView {
        id: pass1View
        width: 130
        height: count * 30
        anchors.top: seperateLine.bottom
        spacing: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 4
        interactive: false
        model: pass1Model

        delegate: passDelegate
    }
    ListView {
        id: pass2View
        width: 130
        height: count * 30
        anchors.top: pass1View.bottom
        spacing: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        interactive: false
        model: pass2Model

        delegate: passDelegate

        onCountChanged: {
            if(scheduler.isPdbLoaded())
            {
                refreshPassName();
                refreshPassFlag();
            }
            var p = addBtn.pos
            refreshEditBtnPos();
            if(pass1View.count !== 0 && pass1View.itemAtIndex(0).haveRead){
                if(addBtn.pos > p){
                    pass2View.itemAtIndex(pass2Model.count - 1).flag = true
                    //passFTableModel.callSetData(addBtn.pos, mapping["flag"], true)
                }
                else if(addBtn.pos < p){
                    passFTableModel.callSetData(p, mapping["flag"], false)
                }
            }
            //console.log(p,addBtn.pos)
        }
    }
    ListView {
        id: pass3View
        width: 130
        height: count * 30
        anchors.top: pass2View.bottom
        spacing: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        interactive: false
        model: pass3Model

        delegate: passDelegate
    }

    PassEditBtn {
        id: addBtn
        width: 70
        anchors.left: pass3View.left
        anchors.leftMargin: -8
        anchors.verticalCenter: pass3View.top
        anchors.verticalCenterOffset: pass3View.count * 30 + 13

        textItemText: "+"
        pos: pass2Model.count + pass1Model.count - 1
        onClicked: {
            if(pass2Model.count + pass1Model.count < pass3Model.get(0).i){
                pass2Model.append({"i": pass2Model.count + pass1Model.count,
                                   "v": false});
            }
        }
    }

    PassEditBtn {
        id: removeBtn
        y: addBtn.y
        width: 70
        checked: addBtn.checked
        anchors.right: pass2View.right
        anchors.rightMargin: addBtn.anchors.leftMargin
        pos: pass2Model.count + pass1Model.count - 1
        onClicked: {
            if(pass2Model.count > 0){
                pass2Model.remove(pass2Model.count - 1);
            }
        }
    }

    function passListInitialize(){
        if(exclusiveGroup.checkedButton != null){
            exclusiveGroup.checkedButton.clicked();
            exclusiveGroup.checkedButton.checked = true;
        }
        else{
            pass1View.currentItem.clicked();
            pass1View.currentItem.checked = true;
        }
        pass2Model.clear();
        refreshPassList();
    }

    function refreshPassList(){
        if(scheduler.isPdbLoaded())
        {
            refreshFillPassList();
            refreshPassName();
            refreshPassFlag();
        }
    }

    function refreshFillPassList(){
        var newCol = pass1View.itemAtIndex(pass1Model.count - 1).col + 1;
        newCol += pass2Model.count;
        if(passFTableModel.fixedTablePopData(newCol, "flag")){
            while(passFTableModel.fixedTablePopData(newCol, "flag")){
                addBtn.clicked();
                newCol++;
            }
        }
        else{
            while(!passFTableModel.fixedTablePopData(newCol - 1, "flag")){
                removeBtn.clicked();
                newCol--;
            }
        }
    }

    function switchPass(i){
        //console.log("Pass" + i + "Parameter")
        if(scheduler.isPdbLoaded()){
            scheduler.callPassSelected("Pass" + i + "Parameter")
            passListRequestRefreshcombobx()
            passListRequestFixTableRefresh(i);
            currentIndex = i;
        }
    }

    function refreshPassName(){
        getPassName(rectangle);
    }
    function getPassName(item){
        if(item.type === "listBtn"){
            item.text1Text = passFTableModel.fixedTablePopData(item.col, "showName");
            item.haveRead = true;
        }
        for(var i = 0; i < item.children.length; i++)
            getPassName(item.children[i]);
        return;
    }

    function refreshPassFlag(){
        getPassFlag(rectangle);
    }
    function getPassFlag(item){
        if(item.type === "listBtn"){
            item.flag = passFTableModel.fixedTablePopData(item.col, "flag");
        }
        for(var i = 0; i < item.children.length; i++)
            getPassFlag(item.children[i]);
        return;
    }

    function clear(){
        resetPass(rectangle);
        pass2Model.clear();
        currentIndex = -1;
    }
    function resetPass(item){
        if(item.type === "listBtn"){
            item.text1Text = "";
            item.flag = false;
            item.haveRead = false;
        }
        for(var i = 0; i < item.children.length; i++)
            resetPass(item.children[i]);
        return;
    }

    function refreshEditBtnPos(){
        addBtn.pos = pass2Model.count + pass1Model.count - 1;
        removeBtn.pos = pass2Model.count + pass1Model.count - 1;
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
