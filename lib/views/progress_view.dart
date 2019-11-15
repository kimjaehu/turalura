import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/views/new_measurement/measurement_view.dart';
import 'package:turalura/models/Measurement.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newMeasurement = new Measurement(null, null, null, null);
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
          )
        ],
      ),
    );
  }
}
