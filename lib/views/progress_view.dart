import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/views/new_measurement/measurement_view.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/widgets/growth_chart.dart';
import 'package:turalura/widgets/measurement_card.dart';
import 'package:turalura/widgets/provider_widget.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final newMeasurement = new Measurement(null, null, null, null, null);
    return StreamBuilder<Object>(
        stream: Provider.of(context).auth.getUserBabySummaryStreamSnapshots(),
        builder: (context, summarySnapshot) {
          return StreamBuilder<Object>(
              stream:
                  getUserMeasurementsStreamSnapshots(context, summarySnapshot),
              builder: (context, measurementSnapshot) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: MeasurementCard(summarySnapshot: summarySnapshot, newMeasurement: newMeasurement),
                      ),
                      !measurementSnapshot.hasData
                          ? CircularProgressIndicator()
                          : Expanded(
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
                                              category: "height",
                                              summarySnapshot: summarySnapshot,
                                              measurementSnapshot:measurementSnapshot,
                                            ),
                                          ),
                                          Center(
                                            child: GrowthChart(
                                              title: "Weight-for-age",
                                              category: "weight",
                                              summarySnapshot: summarySnapshot,
                                              measurementSnapshot:measurementSnapshot
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
              });
        });
  }

  Stream<QuerySnapshot> getUserMeasurementsStreamSnapshots(
      BuildContext context, snapshot) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    final currentBaby = snapshot.data['name'];
    print('current baby ${currentBaby.toString().toLowerCase()}');
    yield* Firestore.instance
        .collection('measurements')
        .document(uid)
        .collection(currentBaby.toString().toLowerCase())
        .snapshots();
  }
}
