import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: control

    ///
    /// user-visible properties
    ///

    property alias active: dragArea.drag.active

    color: "#ff0000"
    radius: 5
    // property string type : "dragger"

    ///
    /// attached properties
    ///

    width: radius * 2
    height: radius * 2

    MouseArea {
        id: dragArea
        anchors.fill: parent

        preventStealing: true
        propagateComposedEvents: false

        drag{
            target: control
            axis: Drag.YAxis
        }

        onClicked: {
            console.log(control.x + control.width/2, control.y + control.width/2)
        }

    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  signals and functions  ////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    signal dragged(real x, real y)

    function setDragMinMax(min, max){
        dragArea.drag.minimumY = min
        dragArea.drag.maximumY = max
    }
}
