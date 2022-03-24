import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects 1.0
import QtQuick.Timeline 1.0

Item {
    id: loginWindow
    width: 800
    height: 600

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
            color: "transparent"
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
            text: "密码修改"
            font.pixelSize: 29
            font.weight: Font.Normal
            font.family: "Microsoft Yahei"
        }
        VerticalInput {
            id: inputID

            anchors{
              top: logoTitle.bottom
              left: parent.left
              topMargin: 20
              leftMargin: 20
            }
            textAreaPlaceholderText: "请输入用户名"
            title: "用户名"
            //inputText.echoMode: TextInput.Password
            inputText.onAccepted: userVerify()

            inputText.focus: true
            KeyNavigation.tab: inputOldPw.inputText
        }

        VerticalInput {
            id: inputOldPw
            anchors{
              top: inputID.bottom
              left: inputID.left
              topMargin: 10
            }
            textAreaPlaceholderText: "请输入该用户的原有密码"
            title: "该用户的原有密码"
            inputText.echoMode: TextInput.Password
            inputText.onAccepted: userVerify()

            KeyNavigation.tab: inputNewPw.inputText
        }

        VerticalInput {
            id: inputNewPw
            anchors{
              top: inputOldPw.bottom
              left: inputOldPw.left
              topMargin: 10
            }
            inputText.echoMode: TextInput.Password
            textAreaPlaceholderText: "新密码"
            title: "请输入新密码"
        }

        VerticalInput {
            id: inputNewPwTwice
            anchors{
              top: inputNewPw.bottom
              left: inputNewPw.left
              topMargin: 10
            }
            inputText.echoMode: TextInput.Password
            textAreaPlaceholderText: "再输入一次新密码"
            title: "请再输入一次新密码"
        }


        LoginButton {
            id: loginButton
            x: 221
            y: 401
            width: 140
            anchors{
                verticalCenter: loginButton1.verticalCenter
                right: inputNewPwTwice.right
                rightMargin: 20
             }
            textItemText: "确定修改"
            onClicked: {
                if(userVerify()){
                    if(pwVerify()){
                        if(pwUpdate(inputID.inputText.text,inputOldPw.inputText.text,inputNewPw.inputText.text)){
                            errorMsg.text = "密码修改成功！"
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
            //y: 420
            width: 140
            anchors{
              top: inputNewPwTwice.bottom
              left: inputNewPwTwice.left
              topMargin: 20
              leftMargin:20
            }
            textItemText: "返 回"
            onClicked: backToLogin()

            KeyNavigation.tab: inputID.inputText
        }

        Text {
            id: errorMsg
            x: 25
            y: 420
            color: "#9a0000"
            anchors{
             right:inputID.right
             bottom: inputID.top
             bottomMargin: 10
             rightMargin:10
            }
            property string errMsg
            font.pixelSize: 14
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    property var componentMainWindow : null
    property var objectMainWindow : null
    property var objectLogin: null

    function userVerify(){
        if(inputID.inputText.text === ""){
            errorMsg.text = "你还没有输入用户名"
            return false
        }
        else if(inputOldPw.inputText.text === ""){
            errorMsg.text = "你还没有输入密码"
            return false
        }
        else{
            if(!scheduler.userVerify(inputID.inputText.text, inputOldPw.inputText.text)){
                errorMsg.text = "用户名或密码输入错误"
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
            errorMsg.text = "你还没有输入新密码"
            return false
        }
        else if(inputNewPwTwice.inputText.text === ""){
            errorMsg.text = "你需要再次输入一次新密码"
            return false
        }
        else{
            if(!(inputNewPwTwice.inputText.text == inputNewPw.inputText.text)){
                errorMsg.text = "两次密码输入不一致"
                return false
            }
            else{
                errorMsg.text = ""
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

    function backToLogin(){
        loginWindow.destroy()
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}D{i:3}D{i:4}D{i:5}D{i:6}D{i:2}D{i:9}D{i:10}D{i:11}D{i:12}
D{i:13}D{i:14}D{i:15}D{i:16}D{i:7}D{i:1}
}
##^##*/
