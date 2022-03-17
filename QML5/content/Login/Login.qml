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
                //"../images/QRcode.jpg"
                source: "qrc:/qtquickplugin/images/template_image.png"
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
                y: 35
                text: "用户登录"
                font.pixelSize: 29
                font.weight: Font.Normal
            }

            VerticalInput {
                id: inputID
                x: 25
                y: 144
                textAreaPlaceholderText: "请输入用户名"
                title: "账户"
                inputText.onAccepted: userLogin()

                inputText.focus: true
                KeyNavigation.tab: inputPw.inputText
            }

            VerticalInput {
                id: inputPw
                x: 25
                y: 225
                textAreaPlaceholderText: "请输入密码"
                title: "密码"
                inputText.echoMode: TextInput.Password
                inputText.onAccepted: userLogin()

                KeyNavigation.tab: loginButton
            }

            LoginButton {
                id: loginButton
                width: 140
                anchors.verticalCenter: loginButton1.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 45
                textItemText: "登 录"
                onClicked: userLogin()

                KeyNavigation.tab: loginButton1
                Keys.onPressed: {
                    if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                        userLogin();
                }
            }

            LoginButton {
                id: loginButton1
                y: 359
                width: 140
                anchors.left: parent.left
                anchors.leftMargin: 45
                textItemText: "取 消"
                onClicked: Qt.quit()

                KeyNavigation.tab: inputID.inputText
                Keys.onPressed: {
                    if(event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                        Qt.quit();
                }
            }

            LoginButton {
                id: loginButton2
                x: 295
                y: 306
                width: 80
                height: 28
                anchors.top: inputPw.bottom
                anchors.topMargin: 5
                textItemText: "修改密码"
                onClicked: createInformationManagement()
            }
        }

    }

    property var componentMainWindow : null
    property var objectMainWindow : null
    property var objectIM : null

    function userLogin(){
        if(inputID.inputText.text === "")
            console.log("no id:", inputID.inputText.text);
        else if(inputPw.inputText.text === "")
            console.log("no pw:", inputPw.inputText.text);
        else{
            if(!scheduler.userCreate(inputID.inputText.text, inputPw.inputText.text)){
                console.log("id or pw wrong");
            }
            else{
                scheduler.managerInit();
                window.visible = false;
                createMain();
            }
        }
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

    function createInformationManagement(){
        objectIM = Qt.createQmlObject(
                   'import QtQuick 2.15
                    import QtQuick.Controls 2.15
                    import QtQuick.Studio.Effects 1.0
                    import QtQuick.Timeline 1.0


                     InformationManagemet {
                        id : im
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


