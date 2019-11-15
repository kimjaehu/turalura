import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/views/new_measurement/measurement_view.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("data"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewMeasurementView(),),);
            },
          )
        ],
      ),
    );
  }
}
