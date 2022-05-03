import QtQuick 2.0
import QtCharts 2.15

ChartView {
    id: view

    legend.visible: false

    animationOptions: ChartView.AllAnimations

    antialiasing: true

    property bool axisReady: false


    ValueAxis {
        id: axisx
        min: 0
        max: 10
        tickCount: 10
    }

    ValueAxis {
        id: axisy
        min: 0
        max: 10
        tickCount: 10
    }

    // an empty series for initial visualization
    LineSeries {
        axisX: axisx
        axisY: axisy
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  signals and functions  ////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function adjustAxis(dict){
        if(dict["minx"]) axisx.min = dict["minx"]
        if(dict["maxx"]) axisx.max = dict["maxx"]
        if(dict["miny"]) axisy.min = dict["miny"]
        if(dict["maxy"]) axisy.max = dict["maxy"]
        if(dict["tick"]) axisx.tickCount = dict["tick"]
    }


    // create a series with specified x series, y series and lits legend name
    function createLineSeries(model, seriesName){

        var series = view.createSeries(ChartView.SeriesTypeLine, seriesName, axisx, axisy)
        series.useOpenGL = true
        // series.onClicked.connect(function(point){console.log(view.mapToPosition(point, series))})
        for(let i = 0; i < model.count; i++){
            series.append(model.get(i).xx, model.get(i).yy)
        }
        return series
    }

}
