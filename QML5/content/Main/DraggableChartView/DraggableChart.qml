import QtQuick 2.15
import QtCharts 2.15

Item {
    id: control

    ///
    /// user visible property
    ///

    property bool locked: true
    property alias backgroundColor: chart.backgroundColor
    property int seriesCount: 0

    readonly property var eng2Chn : {    "angle":                "角度",
                                         "stayLeftTime_Lead":    "前枪左边停时间",
                                         "stayRightTime_Lead":   "前枪右边停时间",
                                         "stayLeftTime_Trail":   "后枪左边停时间",
                                         "stayRightTime_Trail":  "后枪右边停时间",
                                         "oscWidth_Lead":        "前枪摆宽",
                                         "oscWidth_Trail":       "后枪摆宽",
                                         "oscFreq_Lead":         "前枪摆动频率",
                                         "oscFreq_Trail":        "后枪摆动频率",
                                         "feedRate_Lead":        "前枪送丝速度",
                                         "feedRate_Trail":       "后枪送丝速度",
                                         "Arc_Rate_Lead":        "前枪电弧修正",
                                         "Arc_Rate_Trail":       "后枪电弧修正",
                                         "leadTargetCur":        "前枪干伸高度值",
                                         "trailTargetCur":       "后枪干伸高度值",
                                         "carACC":               "小车加速度",
                                         "carSPEED":             "小车速度"}


    readonly property var seriesColor: ["#fe6637", "#237bff"]

    Component {
        id: modelC
        ListModel {

        }
    }

    Component {
        id: dragC
        Repeater {
            id: repeaterC

            required property LineSeries chartSeries

            required property int chartSeriesIndex

            required property color enabledColor

            // required property color disabledColor

            model: chartSeries.count

            Dragger {
                property real chartWidth: chart.width

                property real chartHeight: chart.height

                property bool adjustEnabled: false

                enabled: !control.locked  // control whether user can drag

                radius: enabled ? 5 : 0

                visible: repeaterC.chartSeries.visible

                color: enabledColor

                onHeightChanged: adjustToPoint(this, repeaterC.chartSeries, index)
                onChartWidthChanged: adjustToPoint(this, repeaterC.chartSeries, index)
                onChartHeightChanged: adjustToPoint(this, repeaterC.chartSeries, index)

                onYChanged:{
                    if(active || adjustEnabled){
                        adjustToDragger(this, repeaterC.chartSeries, index)
                    }
                }

                onActiveChanged: {
                    if(active === false){
                        let point = repeaterC.chartSeries.at(index)
                        let p = chart.mapToPosition(point, repeaterC.chartSeries)
                        p.y = y + height/2
                        let p_dragged = chart.mapToValue(p, repeaterC.chartSeries)
                        console.log("dragger index: " + index + " series index: " + repeaterC.chartSeriesIndex + " changed value: " + p_dragged.y)
                        angleRelatedTableModel.callSetData(index, repeaterC.chartSeriesIndex + 1, (Math.round(p_dragged.y * 100) / 100).toFixed(2))
                    }
               }
            }

            Component.onCompleted: {
                //console.log(chart.mapToPosition(repeaterC.chartSeries.at(1), repeaterC.chartSeries))
            }
        }
    }

    DynamicChart {
        id: chart
        anchors.fill: parent

        margins.top: 40
    }

    ListModel {
        id: seriesList

    }


    // listView to show legends
    ListView {
        id: legendView

        model: seriesList

        // the width of the legendView is dynamically changed
        width: 0

        orientation: ListView.Horizontal
        spacing: 10

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10

        delegate: ClickableLegend {
            id: cLegend
            text: model.name
            legendColor: model.color

            onToggled: {
                model.l_series.visible = !cLegend.checked
                model.d_series.enabled = !cLegend.checked
            }

            Component.onCompleted: {
                model.l_series.visible = !cLegend.checked
                legendView.width = legendView.width + cLegend.width + legendView.spacing
            }
        }
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////  signals and functions  ////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////  Initialization  //////////////////////////////////////////////

    function connectToModel(){
        angleRelatedTableModel.partDataChanged.connect((r, c, v) => {
                                                            console.log("column:" + c)
                                                            console.log((seriesList.get(c - 1)).name)
                                                            let d_series = seriesList.get(c - 1).d_series
                                                            let item = d_series.itemAt(r)
                                                             console.log("row:" + r)
                                                            let l_series = d_series.chartSeries

                                                            item.adjustEnabled = true
                                                            let point = l_series.at(r)
                                                            point.y = v
                                                            let p = chart.mapToPosition(point, l_series)
                                                            item.y = p.y - item.height/2
                                                            item.adjustEnabled = false
                                                       })
        angleRelatedTableModel.dataDeleted.connect(deleteDraggableSeries)
        angleRelatedTableModel.dataReady.connect(createDraggableSeries)
    }

///////////////////////////////////////////////////  Adjust  //////////////////////////////////////////////////

    // adjust the point when the chartview adjust its width and height
    function adjustToPoint(item, series, index){

        //let position = Qt.point(model.get(index).xx, model.get(index).yy)

        let p = chart.mapToPosition(series.at(index), series)

        item.x = p.x - item.width / 2
        item.y = p.y - item.height / 2

    }

    // adjust the point when dragged
    function adjustToDragger(item, series, index){
        let position = Qt.point(item.x + item.width / 2, item.y + item.height / 2)

        let p = chart.mapToValue(position, series)

        series.replace(series.at(index).x, series.at(index).y,  // old position
                       series.at(index).x, p.y)                 // new position
    }


    function adjustSeries(seriesIndex, index, value){

        let series = seriesList.get(seriesIndex).l_series

        series.replace(series.at(index).x, series.at(index).y,  // old position
                       series.at(index).x, value)               // new position

        adjustAxis()
    }

    function adjustAxis(){
        let model = []
        for(let i = 0; i < seriesList.count; i++){
            let m = []
            let series = seriesList.get(i).l_series
            for(let j = 0; j < series.count; j++){
                m.push(series.at(j).y)
            }
            model.push(m)
        }

        let mma = minMaxAvg(model)
        let y_min = mma[0] - mma[2]/2 - 1, y_max = mma[1] + mma[2]/2 + 1
        chart.adjustAxis({"miny": Math.floor(y_min),
                          "maxy": Math.ceil(y_max),})
    }


    // TODO: callback
    function callBack(row, col, value){
        //view.webCallBack(row, col, value);
    }


/////////////////////////////////////////////////  Dynamic  //////////////////////////////////////////////////

    // this will alse create the axis for the modelList, with policy of max + avg + 1 and min - avg - 1
    function createDraggableSeries(modelList, legendList){

        console.log(modelList)
        console.log(legendList)
        seriesCount = modelList.length - 1

        // create series
        let x_series = modelList[0]
        modelList.shift()
        let x_min = x_series[0], x_max = x_series[x_series.length - 1]
        let mma = minMaxAvg(modelList)
        let y_min = mma[0] - mma[2]/10 - 1, y_max = mma[1] + mma[2]/10 + 1
        console.log("y_min:" + y_min + "  y_max: " + y_max)
        chart.adjustAxis({"minx": x_min,
                          "maxx": x_max,
                          "miny": Math.floor(y_min),
                          "maxy": Math.ceil(y_max),
                          "tick": x_series.length})

        for(let i = 0; i < seriesCount; i++){
            let model  = createModel(x_series, modelList[i])
            let series = createSeries(model, legendList[i], i)
            let d_series = createDragSeries(series, model, i)
//            series.onPointReplaced.connect((index) => {
//                adjustToPoint(d_series.itemAt(index), series, index)
//            })
            seriesList.append({"name": eng2Chn[legendList[i]], "color": String(series.color), "l_series": series, "d_series": d_series})
        }
    }

    // this will delete all the series, draggers and legends
    function deleteDraggableSeries(){
        for(let i = 0; i < control.seriesCount; i++){
            let drag = seriesList.get(i).d_series
            if(drag) drag.destroy()
            chart.removeSeries(seriesList.get(i).l_series)
        }
        seriesList.clear()
        legendView.width = 0
        control.seriesCount = 0
    }

    // modelList must contain one x series, may contain several y series, use legend as the series name
    function createSeries(model, legend, index){
        var series = chart.createLineSeries(model, legend)
        console.log(control.seriesColor)
        series.color = seriesColor[index]
        series.width = 3
        return series
    }

    // create a series and push it into pointModelList, return it
    function createModel(x_series, y_series){
        var model = modelC.createObject(chart)
        for(let i = 0; i < x_series.length; i++){
            model.append({"xx": x_series[i], "yy": y_series[i]})
        }
        return model
    }

    // create a dragSeries
    function createDragSeries(series, model, index){
        var d_series = dragC.createObject(chart, {chartSeries: series, chartSeriesIndex:index, enabledColor: series.color})
        return d_series
    }


////////////////////////////////////////////////  Mathematics  ////////////////////////////////////////////////

    // calculate min, max and average of several modelList
    function minMaxAvg(modelList){
        var min = modelList[0][0], max = modelList[0][0], avg = 0

        for(let i = 0; i < modelList.length; i++){
            let tmp_min = extreme(modelList[i], false),
                tmp_max = extreme(modelList[i], true),
                tmp_avg = average(modelList[i])

            if(min > tmp_min) min = tmp_min
            if(max < tmp_max) max = tmp_max
            avg += tmp_avg
        }
        return [min, max, avg/(modelList.length)]
    }


    //calculate the average value of the list
    function average(list){
        if(list.length === 0)
            return null

        var avg = 0
        for(let i = 0; i < list.length; i++)
            avg += list[i]

        return (avg + 0.0)/list.length
    }


    // find the extreme value of the ListElement
    // flag = true : find the max
    // falg = false: find the min
    function extreme(list, flag){
        if(list.length === 0)
            return null

        var ext = list[0]
        for(let i = 1; i < list.length; i++){
            if((flag === true && ext < list[i]) || (flag === false && ext > list[i]))
                ext = list[i]
        }
        return ext;
    }
}
