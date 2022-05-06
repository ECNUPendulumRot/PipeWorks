import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {

    id: control

    ///
    /// user-visible properties
    ///

    property alias active: dragArea.drag.active
    property alias dragMinY: dragArea.drag.minimumY
    property alias dragMaxY: dragArea.drag.maximumY
    color: "#ff0000"

    radius: 5

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
    }

/////////////////////////////////////////////////  signals  ///////////////////////////////////////////////////

    signal dragged(real x, real y)

//////////////////////////////////////////////////  adjust  ////////////////////////////////////////////////////

    function setDragMinMax(min, max){
        dragArea.drag.minimumY = min
        dragArea.drag.maximumY = max
    }
}
