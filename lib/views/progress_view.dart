import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/views/new_measurement/measurement_view.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/widgets/growth_graph.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newMeasurement = new Measurement(null, null, null, null, null);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text("data"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewMeasurementView(
                            measurement: newMeasurement,
                          )),
                );
              },
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'Height',
                      ),
                      Tab(
                        text: 'Weight',
                      ),
                      Tab(
                        text: 'Data',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Center(
                          child: GrowthChart(
                            title: "Height-for-age",
                          ),
                        ),
                        Center(
                          child: GrowthChart(
                            title: "Weight-for-age",
                          ),
                        ),
                        Center(child: Text('Summary')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
