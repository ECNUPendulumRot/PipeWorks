import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import QtQuick.Timeline 1.0

Item {
    id: loginWindow
    width: 800
    height: 600

    Rectangle {
        id: background
        color: "#dedcdc"
        border.color: "#707070"
        border.width: 0
        anchors.fill: parent

        Rectangle {
            id: rectangle
            x: 0
            y: 0
            width: 320
            height: 600
            opacity: 1
            color: "#051540"
            border.color: "#707070"
            border.width: 0

            Image {
                id: logoDpLogin
                y: 160
                width: 125
                height: 80
                source: "../images/DPLogin.png"
                mipmap: true
                asynchronous: false
                antialiasing: true
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: label
                y: 277
                color: "#ffffff"
                text: qsTr("德平科技")
                font.pixelSize: 46
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenterOffset: -1
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: textItem
                y: 540
                opacity: enabled ? 1.0 : 0.3
                color: "#ffffff"
                text: "2022 v1.0"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                anchors.horizontalCenterOffset: -1
                anchors.horizontalCenter: label.horizontalCenter
                z: 1
                font.weight: Font.Medium
            }

            Image {
                id: image
                x: 108
                y: 393
                width: 100
                height: 100
                source: "../images/QRcode.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: rectangle1
            x: 362
            y: 50
            width: 400
            height: 500
            opacity: 1
            color: "#e7e7e7"
            border.width: 0
            antialiasing: false
            layer.enabled: true
            layer.effect: DropShadowEffect {
                id: dropShadow
                color: "#c8000000"
                radius: 8
                verticalOffset: 0
                horizontalOffset: 0
                spread: 0.2
            }
            z: 0

            Text {
                id: logoTitle
                x: 34
                y: 25
                text: "信息修改"
                font.pixelSize: 29
                font.weight: Font.Normal
            }
            InformationMInput {
                id: inputID
                x: 25
                y: 75
                labelFontSize: 14
                textAreaPlaceholderText: "请输入ID信息"
                title: "请输入ID信息"
                inputText.echoMode: TextInput.Password
                inputText.onAccepted: userVerify()

                KeyNavigation.tab: inputOldPw.inputText
            }

            InformationMInput {
                id: inputOldPw
                x: 25
                anchors.top: inputID.bottom
                labelFontSize: 14
                anchors.topMargin: 3
                textAreaPlaceholderText: "请输入原有的密码"
                title: "请输入原来的密码"
                inputText.echoMode: TextInput.Password
                inputText.onAccepted: userVerify()

                KeyNavigation.tab: inputNewPw.inputText
            }
            InformationMInput {
                id: inputNewPw
                x: 25
                anchors.top: inputOldPw.bottom
                labelFontSize: 14
                anchors.topMargin: -3
                inputText.echoMode: TextInput.Password
                textAreaPlaceholderText: "请输入新密码"
                title: "请输入新密码"
            }
            InformationMInput {
                id: inputNewPwTwice
                x: 25
                anchors.top: inputNewPw.bottom
                anchors.topMargin: 3
                labelFontSize: 14
                inputText.echoMode: TextInput.Password
                textAreaPlaceholderText: "请重复输入新密码"
                title: "请重复输入新密码"
            }

            LoginButton {
                id: loginButton
                x: 221
                y: 401
                width: 140
                anchors.verticalCenter: loginButton1.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 39
                textItemText: "确 定"
                onClicked: {
                            if(userVerify()){
                                if(pwVerify()){
                                    if(pwUpdate(inputID.inputText.text,inputOldPw.inputText.text,inputNewPw.inputText.text)){
                                        errorMsg.text = "密码修改成功！"
                                        //createLogin()
                                    }

                                    else
                                        errorMsg.text = "密码修改失败，请检查是否符合规范"
                                }

                            }
                            }

                KeyNavigation.tab: loginButton1
                Keys.onPressed: {
                    if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                        userVerify();
                }
            }

            LoginButton {
                id: loginButton1
                y: 420
                width: 140
                anchors.left: parent.left
                anchors.leftMargin: 44
                textItemText: "返 回"
                onClicked: createLogin()



            }

            Text {
                id: errorMsg
                x: 25
                y: 420
                color: "#9a0000"
                anchors.bottom: inputID.top
                property string errMsg
                font.pixelSize: 14
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: -320
            }


        }

    }

    property var componentMainWindow : null
    property var objectMainWindow : null
    property var objectLogin: null

    function userVerify(){
        if(inputID.inputText.text === ""){
            errorMsg.text = "您还没有输入ID信息"
            return false
        }

        else if(inputOldPw.inputText.text === ""){
            errorMsg.text = "您还没有输入密码"
            return false
        }

            else{
                if(!scheduler.userVerify(inputID.inputText.text, inputOldPw.inputText.text)){
                    errorMsg.text = "账户与密码错误"
                    return false

                }
                else{
                    errorMsg.text = ""
                    return true
                }
            }
    }

    function pwVerify(){
        if(inputNewPw.inputText.text === ""){
            errorMsg.text = "您还没有输入新的密码"
            return false
        }

        else if(inputNewPwTwice.inputText.text === ""){
            errorMsg.text = "您还没有第二次输入新的密码"
            return false
        }

        else{
            if(!(inputNewPwTwice.inputText.text == inputNewPw.inputText.text)){
                errorMsg.text = "两次密码输入不一致"
                return false
            }
            else{
//                scheduler.managerInit();
//                window.visible = false;
//                createMain();
                errorMsg.text = ""
                console.log("newPwVerify successful!")
                return true
            }
        }
    }

    function pwUpdate(id, opw, npw){
        if(scheduler.userUpdate(id, opw, npw))
            return true
        else
            return false
    }

    function createMain(){
        objectMainWindow = Qt.createQmlObject(
                    'import QtQuick 2.15
                     import QtQuick.Controls 2.15
                     import "../Main"

                     MainWindow {
                        id : mWindow
                        anchors.fill: parent
                     }
                     ',
                    window)
        check();
        window.w = 1366
        window.h = 768
        window.visible = true
    }

    function createLogin(){
        objectLogin = Qt.createQmlObject(
                   'import QtQuick 2.15
                    import QtQuick.Controls 2.15
                    import QtQuick.Studio.Effects 1.0
                    import QtQuick.Timeline 1.0



                     Login {
                        anchors.fill: parent
                     }
                     ',
                    window)
        //check();
        window.w = 800
        window.h = 600
        window.visible = true
    }

    function check(){
        if(scheduler.getAuthority() === 1){
            objectMainWindow.disable();
        }
    }


}





/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}D{i:3}D{i:4}D{i:5}D{i:6}D{i:2}D{i:9}D{i:10}D{i:11}D{i:12}
D{i:13}D{i:14}D{i:15}D{i:16}D{i:7}D{i:1}
}
##^##*/
