import QtQuick 2.0
import QtCharts 2.15

ChartView {
    id: view

    legend.visible: false

    animationOptions: ChartView.SeriesAnimations
    antialiasing: true

    property bool axisReady: false
    property alias anchorMin: anchorMin
    property alias anchorMax: anchorMax

    ValueAxis {
        id: axisx
        min: 0
        max: 10
        tickCount: 10
        gridLineColor: "#c2c2c2"
        color: "#8f8f8f"
        labelFormat: "%d"
        labelsFont.family: "Microsoft YaHei"
    }

    ValueAxis {
        id: axisy
        min: 0
        max: 10
        gridLineColor: axisx.gridLineColor
        color: axisx.color
        labelsFont:axisx.labelsFont
        tickCount: 10
    }

    // an empty series for initial visualization
    // anchors
    LineSeries {

        id: anchor
        axisX: axisx
        axisY: axisy

        visible: false

        XYPoint {
            id: anchorMin
            x: axisx.min
            y: axisy.min
        }

        XYPoint {
            id:anchorMax
            x: axisx.min
            y: axisy.max
        }
    }

/////////////////////////////////////////////////  signals  ///////////////////////////////////////////////////

/////////////////////////////////////////////////  adjust  ///////////////////////////////////////////////////

    function adjustAxis(dict){
        if(dict["minx"]) axisx.min = dict["minx"]
        if(dict["maxx"]) axisx.max = dict["maxx"]
        if(dict["miny"]) axisy.min = dict["miny"]
        if(dict["maxy"]) axisy.max = dict["maxy"]
        if(dict["tick"]) axisx.tickCount = dict["tick"]
        return [view.mapToPosition(Qt.point(anchorMin.x, anchorMin.y), anchor).y, view.mapToPosition(Qt.point(anchorMax.x, anchorMax.y), anchor).y]
    }

/////////////////////////////////////////////////  create  ///////////////////////////////////////////////////

    // create a series with specified x series, y series and lits legend name
    function createLineSeries(model, seriesName){
        var series = view.createSeries(ChartView.SeriesTypeLine, seriesName, axisx, axisy)
        series.useOpenGL = true
        for(let i = 0; i < model.count; i++){
            series.append(model.get(i).xx, model.get(i).yy)
        }
        return series
    }
}
