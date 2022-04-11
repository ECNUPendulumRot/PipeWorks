import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components 1.0
import "Components"

Item {
    id: rectangle


    property var mapping : {
    "KHp_Lead"      :0,
    "KHi_Lead"      :1,
    "KHd_Lead"      :2,
    "KVp_Lead"      :3,
    "KVi_Lead"      :4,
    "KVd_Lead"      :5,
    "detaM_Lead"    :6,
    "detaK_Lead"    :7,
    "detaF_Lead"    :8,
    "k1_Lead"       :9,
    "k2_Lead"       :10,
    "k3_Lead"       :11,
    "k4_Lead"       :12,
    "M1_Lead"       :13,
    "M2_Lead"       :14,
    "M3_Lead"       :15,
    "M4_Lead"       :16,
    "KHp_Trail"     :17,
    "KHi_Trail"     :18,
    "KHd_Trail"     :19,
    "KVp_Trail"     :20,
    "KVi_Trail"     :21,
    "KVd_Trail"     :22,
    "detaM_Trail"   :23,
    "detaK_Trail"   :24,
    "detaF_Trail"   :25,
    "k1_Trail"      :26,
    "k2_Trail"      :27,
    "k3_Trail"      :28,
    "k4_Trail"      :29,
    "M1_Trail"      :30,
    "M2_Trail"      :31,
    "M3_Trail"      :32,
    "M4_Trail"      :33
    }
    width: content.width
    height: content.height




    GroupItem {
        x: 34
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        id: content
        MyGroupTitle2 {
            id: myGroupTitle2
            x: 0
            y: 0
            width: 794
            height: 410
            label4FontpixelSize: 14
            label4Color: "#202020"
            label4Text: "控制参数配置"
        }

        Rectangle {
            id: rectangle1
            x: 30
            y: 27
            width: 352
            height: 360
            color: "#00ffffff"
            GroupItem {
                x: 26
                y: 74





                MyEditLine2 {
                    id: lf
                    x: 0
                    y: -65

                    mapString: "detaF_Lead"

                    labelText: "F值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: lm
                    x: 0
                    y: -35

                    mapString: "detaM_Lead"

                    labelText: "M值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: lm1
                    x: 0
                    y: 0

                    mapString: "M1_Lead"

                    labelText: "M1值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: lm2
                    x: 0
                    y: 30

                    mapString: "M2_Lead"
                    labelText: "M2值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: lm3
                    x: 0
                    y: 60

                    mapString: "M3_Lead"

                    labelText: "M3值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: lm4

                    mapString: "M4_Lead"
                    x: 0
                    y: 90
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
            }

            GroupItem {
                x: 187
                y: 74




                MyEditLine2 {
                    id: lk
                    x: 0
                    y: lm.y

                    mapString: "detaK_Lead"

                    labelText: "K值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: lk1
                    x: 0
                    y: 0

                    mapString: "k1_Lead"

                    labelText: "K1值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: lk2
                    x: 0
                    y: 30

                    mapString: "k2_Lead"

                    labelText: "K2值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: lk3
                    x: 0
                    y: 60

                    mapString: "k3_Lead"

                    labelText: "K3值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: lk4
                    x: 0
                    y: 90

                    mapString: "k4_Lead"

                    labelText: "K4值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
            }

            MyGroupTitle {
                id: myGroupTitle
                anchors.fill: parent
                labelText: "前焊枪"
                labelColor: "#202020"
            }

            Item {
                id: item2
                x: 26
                y: 209
                width: 140
                height: 130
                MyEditLine2 {
                    id: lhp
                    x: 12
                    y: 25

                    mapString: "KHp_Lead"

                    labelText: "比例"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }

                MyEditLine2 {
                    id: lhi
                    x: 12
                    y: 55

                    mapString: "KHi_Lead"

                    labelText: "积分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }

                MyEditLine2 {
                    id: lhd
                    x: 12
                    y: 85

                    mapString: "KHd_Lead"

                    labelText: "微分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyGroupTitle {
                    id: myGroupTitle1
                    anchors.fill: parent
                    labelColor: "#202020"
                    labelText: "横向PID"
                }
            }

            Item {
                id: item3
                x: 190
                y: 209
                width: 140
                height: 130
                MyEditLine2 {
                    id: lvp
                    x: 12
                    y: 25

                    mapString: "KVp_Lead"

                    labelText: "比例"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyEditLine2 {
                    id: lvi
                    x: 12
                    y: 55

                    mapString: "KVi_Lead"

                    labelText: "积分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyEditLine2 {
                    id: lvd
                    x: 12
                    y: 85

                    mapString: "KVd_Lead"

                    labelText: "微分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyGroupTitle {
                    id: myGroupTitle3
                    anchors.fill: parent
                    labelColor: "#202020"
                    labelText: "纵向PID"
                }
            }
        }

        Rectangle {
            id: rectangle2
            x: 412
            y: 27
            width: 352
            height: 360
            color: "#00ffffff"
            GroupItem {
                x: 26
                y: 74





                MyEditLine2 {
                    id: tf
                    x: 0
                    y: -65

                    mapString: "detaF_Trail"

                    labelText: "F值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: tm
                    x: 0
                    y: -35

                    mapString: "detaM_Trail"

                    labelText: "M值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: tm1
                    x: 0
                    y: 0

                    mapString: "M1_Trail"

                    labelText: "M1值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: tm2
                    x: 0
                    y: 30

                    mapString: "M2_Trail"

                    labelText: "M2值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: tm3
                    x: 0
                    y: 60

                    mapString: "M3_Trail"

                    labelText: "M3值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: tm4
                    x: 0
                    y: 90

                    mapString: "M4_Trail"

                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
            }

            GroupItem {
                x: 187
                y: 74




                MyEditLine2 {
                    id: tk
                    x: 0
                    y: tm.y

                    mapString: "detaK_Trail"

                    labelText: "K值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: tk1
                    x: 0
                    y: 0

                    mapString: "k1_Trail"

                    labelText: "K1值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: tk2
                    x: 0
                    y: 30

                    mapString: "k2_Trail"

                    labelText: "K2值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }
                MyEditLine2 {
                    id: tk3
                    x: 0
                    y: 60

                    mapString: "k3_Trail"

                    labelText: "K3值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
                MyEditLine2 {
                    id: tk4
                    x: 0
                    y: 90

                    mapString: "k4_Trail"

                    labelText: "K4值"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }
            }

            MyGroupTitle {
                id: myGroupTitle4
                anchors.fill: parent
                labelText: "后焊枪"
                labelColor: "#202020"
            }

            Item {
                id: item4
                x: 26
                y: 209
                width: 140
                height: 130
                MyEditLine2 {
                    id: thp
                    x: 12
                    y: 25

                    mapString: "KHp_Trail"

                    labelText: "比例"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyEditLine2 {
                    id: thi
                    x: 12
                    y: 55

                    mapString: "KHi_Trail"

                    labelText: "积分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyEditLine2 {
                    id: thd
                    x: 12
                    y: 85

                    mapString: "KHd_Trail"

                    labelText: "微分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40
                }

                MyGroupTitle {
                    id: myGroupTitle5
                    anchors.fill: parent
                    labelColor: "#202020"
                    labelText: "横向PID"
                }
            }

            Item {
                id: item5
                x: 190
                y: 209
                width: 140
                height: 130
                MyEditLine2 {
                    id: tvp
                    x: 12
                    y: 25

                    mapString: "KVp_Trail"

                    labelText: "比例"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyEditLine2 {
                    id: tvi
                    x: 12
                    y: 55

                    mapString: "KVi_Trail"

                    labelText: "积分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyEditLine2 {
                    id: tvd
                    x: 12
                    y: 85

                    mapString: "KVd_Trail"

                    labelText: "微分"
                    textFieldWidth: 60
                    textFieldAnchorsleftMargin: 40

                }

                MyGroupTitle {
                    id: myGroupTitle6
                    anchors.fill: parent
                    labelColor: "#202020"
                    labelText: "纵向PID"
                }
            }
        }
    }

    Component.onCompleted: {
        initPermission();
    }

    function refreshData(item){
        if(item.type === "editable"){
            item.textFieldText = controlFTableModel.fixedTablePopData(mapping[item.mapString],"parValue");
            item.textFieldColor = controlFTableModel.callIsDirty(mapping[item.mapString],3) ? "#cc5555":"#0d0d0d";
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            refreshData(item.children[i])
        return
    }

    function writeInData(item){
        if(item.editEnabled){
            if(item.type === "editable"){
                controlFTableModel.callSetData(mapping[item.mapString], 3, item.textFieldText)
            }
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            writeInData(item.children[i])
        return
    }

    function clearData(item){
        if(item.type === "editable"){
            item.textFieldText = "";
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            clearData(item.children[i])
        return
    }

    function disableInput(item){
        if(item.permission === "false"){
            item.enabled = false;
            return;
        }
        for(var i = 0; i < item.children.length; i++)
            disableInput(item.children[i]);
        return;
    }

    function initPermission(){
        lf.permission   =   "false"

        lm.permission   =   "false"
        lm1.permission  =   "false"
        lm2.permission  =   "false"
        lm3.permission  =   "false"
        lm4.permission  =   "false"

        lk.permission   =   "false"
        lk1.permission  =   "false"
        lk2.permission  =   "false"
        lk3.permission  =   "false"
        lk4.permission  =   "false"

        lhp.permission  =   "false"
        lhi.permission  =   "false"
        lhd.permission  =   "false"

        lvp.permission  =   "false"
        lvi.permission  =   "false"
        lvd.permission  =   "false"

        tf.permission   =   "false"

        tm.permission   =   "false"
        tm1.permission  =   "false"
        tm2.permission  =   "false"
        tm3.permission  =   "false"
        tm4.permission  =   "false"

        tk.permission   =   "false"
        tk1.permission  =   "false"
        tk2.permission  =   "false"
        tk3.permission  =   "false"
        tk4.permission  =   "false"

        thp.permission  =   "false"
        thi.permission  =   "false"
        thd.permission  =   "false"

        tvp.permission  =   "false"
        tvi.permission  =   "false"
        tvd.permission  =   "false"
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:410;width:794}
}
##^##*/
