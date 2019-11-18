import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:turalura/models/Charts_data.dart';

class GrowthChart extends StatefulWidget {
  final String title;
  GrowthChart({Key key, @required this.title}) : super(key: key);

  @override
  _GrowthChartState createState() => _GrowthChartState();
}

class _GrowthChartState extends State<GrowthChart> {
  List<charts.Series<Growth, int>> _heightSeriesLineData;

  _generateData() {
    final lineSeriesData1 = [
      new Growth(1, 20),
      new Growth(2, 30),
      new Growth(3, 35),
      new Growth(4, 40),
      new Growth(5, 50),
      new Growth(6, 40),
      new Growth(7, 50),
      new Growth(8, 50),
    ];

    final lineSeriesData2 = [
      new Growth(1, 50),
      new Growth(2, 40),
      new Growth(3, 35),
      new Growth(4, 20),
      new Growth(5, 10),
      new Growth(6, 20),
      new Growth(7, 40),
      new Growth(8, 50),
    ];

    var lineSeriesData3 = [
      new Growth(1, 35),
      new Growth(2, 45),
    ];

    _heightSeriesLineData.add(
      charts.Series(
        domainFn: (Growth growth, _) => growth.day,
        measureFn: (Growth growth, _) => growth.value,
        id: '99th',
        data: lineSeriesData1,
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.black),
      ),
    );
    _heightSeriesLineData.add(
      charts.Series(
        domainFn: (Growth growth, _) => growth.day,
        measureFn: (Growth growth, _) => growth.value,
        id: '50th',
        data: lineSeriesData2,
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.black),
      ),
    );
    _heightSeriesLineData.add(
      charts.Series(
        domainFn: (Growth growth, _) => growth.day,
        measureFn: (Growth growth, _) => growth.value,
        id: 'height',
        data: lineSeriesData3,
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
      )..setAttribute(charts.rendererIdKey, 'babyName'),
    );
  }

  @override
  void initState() {
    super.initState();
    _heightSeriesLineData = List<charts.Series<Growth, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                child: charts.LineChart(
                  _heightSeriesLineData,
                  defaultRenderer: new charts.LineRendererConfig(
                    stacked: true,
                    strokeWidthPx: 1.0,
                  ),
                  customSeriesRenderers: [
                    new charts.LineRendererConfig(
                        customRendererId: 'babyName', includePoints: true)
                  ],
                  animate: true,
                  animationDuration: Duration(milliseconds: 250),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
