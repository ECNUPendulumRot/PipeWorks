import QtQuick 2.15
import QtQuick.Controls 2.15
import "Components"

Rectangle {
    id: rectangle
    width: 160
    height: 768
    color: "#dcdcdc"
    border.color: "#ffffff"

    signal passListRequestRefreshcombobx()
    signal passListRequestFixTableRefresh(int i)

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
            text: "焊道" + col
            ButtonGroup.group: exclusiveGroup
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: refresh(col)
            onDoubleClicked: {
                if(haveRead){
                    flag = !flag
                    passFTableModel.callSetData(col, 24, flag)
                }
            }
        }
    }

    ListModel {
        id: pass1Model
        ListElement {
            i: 0
        }
        ListElement {
            i: 1
        }
    }
    ListModel {
        id: pass2Model
        ListElement {
            i: 2
        }
        ListElement {
            i: 3
        }
        ListElement {
            i: 4
        }
        ListElement {
            i: 5
        }
        ListElement {
            i: 6
        }
        ListElement {
            i: 7
        }
    }
    ListModel {
        id: pass3Model
        ListElement {
            i: 8
        }
        ListElement {
            i: 9
        }
    }

    ListView {
        id: pass1View
        width: 110
        height: count * 30
        anchors.top: seperateLine.bottom
        spacing: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 4
        model: pass1Model

        delegate: passDelegate
    }
    ListView {
        id: pass2View
        width: 110
        height: count * 30
        anchors.top: pass1View.bottom
        spacing: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        model: pass2Model

        delegate: passDelegate

        onCountChanged: {
            if(scheduler.isPdbLoaded()){
                refreshPassName();
                refreshPassFlag();
            }
        }
    }
    ListView {
        id: pass3View
        width: 110
        height: count * 30
        anchors.top: pass2View.bottom
        spacing: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        model: pass3Model

        delegate: passDelegate
    }

    MainBarParameterBtn {
        id: mainBarParameterBtn
        x: 39
        y: 506
        onClicked: {
            if(pass2View.count > 1){
                pass2Model.remove(pass2Model.count - 1);
            }
        }
    }

    MainBarParameterBtn {
        id: mainBarParameterBtn1
        x: 39
        y: 620
        onClicked: {
            if(pass2Model.count + pass1Model.count < pass3Model.get(0).i){
                pass2Model.append({"i":pass2Model.count + pass1Model.count});
            }1011
        }
    }

    function passListInitialize(){
        pass1View.currentItem.clicked();
        pass1View.currentItem.checked = true;
        if(scheduler.isPdbLoaded())
        {
            refreshPassName();
            refreshPassFlag();
        }
    }

    function refresh(i){
        if(scheduler.isPdbLoaded()){
            scheduler.callPassSelected("Pass" + i + "Parameter")

            passListRequestRefreshcombobx()
            passListRequestFixTableRefresh(i);
        }
    }

    function refreshPassName(){
        getPassName(rectangle);
    }

    function refreshPassFlag(){
        getPassFlag(rectangle);
    }

    function clear(){
        resetPass(rectangle);
    }

    function getPassName(item){
        if(item.type === "listBtn"){
            item.text1Text = passFTableModel.fixedTablePopData(item.col, "showName");
            item.haveRead = true;
            return
        }
        for(var i = 0; i < item.children.length; i++)
            getPassName(item.children[i]);
        return;
    }

    function getPassFlag(item){
        if(item.type === "listBtn"){
            item.flag = passFTableModel.fixedTablePopData(item.col, "flag");
        }
        for(var i = 0; i < item.children.length; i++)
            getPassFlag(item.children[i]);
        return;
    }

    function resetPass(item){
        if(item.type === "listBtn"){
            item.text1Text = "";
            item.flag = true;
            item.haveRead = false;
        }
        for(var i = 0; i < item.children.length; i++)
            resetPass(item.children[i]);
        return;
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}
}
##^##*/
