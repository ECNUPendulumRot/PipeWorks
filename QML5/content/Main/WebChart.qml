import QtQuick 2.15
import QtQuick.Window 2.15
import QtWebEngine 1.10
import QtWebChannel 1.15


Rectangle {

    id: view

    property alias lock : webobj.lock

    width: 640
    height: 480
    visible: true
    color: "#ffffff"

    signal webCallBack(int series, int index, double data);

    WebEngineView {
            anchors.fill: parent
            //C:/testAlg/webQmlTest/qmlWeb/jschart.html
            url: "qrc:/JavaScript/jschart.html"
            webChannel: webChannel
        }

    WebChannel{
        id: webChannel
        registeredObjects: [webobj]
//        Component.onCompleted: {
//                    webChannel.registerObject("webobj", WebClass)
//                }
    }

    QtObject{
        id: webobj
        WebChannel.id: "webobj"
        
        //property string angleDatas : null

        property bool lock
        //onAngleDatasChanged: chartFresh(angleDatas)
        onLockChanged: calllockChanged()

        signal calllockChanged();
        signal chartFresh(string s);
        signal updatePoint(int x, int y, string value);

        function callBack(row, col, value){
            view.webCallBack(row, col, value);
        }

    }

    function connectToModel(){
        angleRelatedTableModel.modelDataChanged.connect(refreshWebTable)
        angleRelatedTableModel.modelSingleDataChanged.connect(callUpdatePoint)
    }

    function refreshWebTable(s){
        webobj.chartFresh(s)
    }

    function callUpdatePoint(x,y,v){
        webobj.updatePoint(x,y,v)
    }
}
