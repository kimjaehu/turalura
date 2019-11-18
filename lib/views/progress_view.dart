import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/views/new_measurement/measurement_view.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/widgets/growth_graph.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newMeasurement = new Measurement(null, 4, null, null, null);
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("data"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewMeasurementView(measurement: newMeasurement,)),
              );
            },
          ),
          GrowthChart(title: "Height-for-age",),
          GrowthChart(title: "Weight-for-age",),
        ],
      ),
    );
  }
}
