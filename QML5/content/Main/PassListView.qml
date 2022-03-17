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

//    PassListBtn {
//        id: passListBtn0
//        text: "焊道0"
//        col: 0
//        anchors.top: seperateLine.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenterOffset: 0
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(0)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn1
//        text: "焊道1"
//        col: 1
//        anchors.top: passListBtn0.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(1)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn2
//        text: "焊道2"
//        col: 2
//        anchors.top: passListBtn1.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenterOffset: 0
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(2)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn3
//        text: "焊道3"
//        col: 3
//        anchors.top: passListBtn2.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(3)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn4
//        text: "焊道4"
//        col: 4
//        anchors.top: passListBtn3.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(4)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn5
//        text: "焊道5"
//        col: 5
//        anchors.top: passListBtn4.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(5)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn6
//        text: "焊道6"
//        col: 6
//        anchors.top: passListBtn5.bottom
//        anchors.topMargin: 4
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(6)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn7
//        text: "焊道7"
//        col: 7
//        anchors.top: passListBtn6.bottom
//        anchors.topMargin: 4
//        checkable: true
//        autoExclusive: true
//        anchors.horizontalCenterOffset: 0
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(7)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn8
//        text: "焊道8"
//        col: 8
//        anchors.top: passListBtn7.bottom
//        anchors.topMargin: 4
//        checkable: true
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(8)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

//    PassListBtn {
//        id: passListBtn9
//        text: "焊道9"
//        col: 9
//        anchors.top: passListBtn8.bottom
//        anchors.topMargin: 4
//        checkable: true
//        checked: false
//        autoExclusive: true
//        anchors.horizontalCenter: parent.horizontalCenter

//        onClicked: refresh(9)
//        onDoubleClicked: {
//            flag = !flag
//            passFTableModel.callSetData(col, 24, flag)
//        }
//    }

    ListView {
        id: listView
        width: 110
        height: 308
        anchors.top: seperateLine.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 4
        model: ListModel {
            ListElement {
                i: 0
            }

            ListElement {
                i: 1
            }

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

            ListElement {
                i: 8
            }

            ListElement {
                i: 9
            }
        }
        delegate: passDelegate
        Component {
            id: passDelegate
            PassListBtn {
                id: passListBtn
                col: i
                text: "焊道" + col
                autoExclusive: true
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: refresh(col)
                onDoubleClicked: {
                    flag = !flag
                    passFTableModel.callSetData(col, 24, flag)
                }
            }
        }
    }

    function passListInitialize(){
        listView.currentItem.clicked();
        listView.currentItem.checked = true;
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




