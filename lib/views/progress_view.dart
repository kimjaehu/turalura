import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/widgets/growth_chart.dart';
import 'package:turalura/widgets/measurement_card.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newMeasurement = new Measurement(null, null, null, null, null, null, null);
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
                        child: MeasurementCard(
                            summarySnapshot: summarySnapshot,
                            newMeasurement: newMeasurement),
                      ),
                      !measurementSnapshot.hasData
                          ? circularProgress()
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
                                              measurementSnapshot:
                                                  measurementSnapshot,
                                            ),
                                          ),
                                          Center(
                                            child: GrowthChart(
                                                title: "Weight-for-age",
                                                category: "weight",
                                                summarySnapshot:
                                                    summarySnapshot,
                                                measurementSnapshot:
                                                    measurementSnapshot),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                color: Colors.blue[50],
                                                height: 35.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 5,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text("Date")),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text("Day")),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child:
                                                                Text("Height")),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child:
                                                                Text("%")),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .center,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text("Weight"),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child:
                                                                Text("%")),
                                                      ),
                                                    ),
                                                    Expanded(flex: 2, child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(''),
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: measurementList(
                                                    measurementSnapshot, summarySnapshot),
                                              )
                                            ],
                                          )
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

  Widget measurementList(measurementSnapshot, summarySnapshot) {
    return ListView.builder(
      itemCount: measurementSnapshot.data.documents.length,
      itemBuilder: (BuildContext context, int index) {
        DateTime _measureDate = DateTime.parse(measurementSnapshot
            .data.documents[index]["measureDate"]
            .toDate()
            .toString());
        double _height = measurementSnapshot.data.documents[index]["height"];
        double _weight = measurementSnapshot.data.documents[index]["weight"];
        double _heightPercentile = measurementSnapshot.data.documents[index]["heightPercentile"] * 100;
        double _weightPercentile = measurementSnapshot.data.documents[index]["weightPercentile"] * 100;
        int _day = measurementSnapshot.data.documents[index]["day"];
        String _unit = measurementSnapshot.data.documents[index]["unit"];
        String _heightText, _weightText;

        if (_unit == 'metric') {
          _heightText = '$_height cm';
          _weightText = '$_weight kg';

        } else if (_unit == 'imperial') {
          _heightText = '${(_height / 2.54).toStringAsFixed(1)} in';
          _weightText = '${(_weight * 2.205).toStringAsFixed(1)} lbs';
        }

        return Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    new DateFormat('MMM. d, yyyy').format(_measureDate), maxLines: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(_day.toString(), maxLines: 1,),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(_heightText, maxLines: 1,),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText('${_heightPercentile.toStringAsFixed(0)}%', maxLines: 1,),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(_weightText, maxLines: 1,),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText('${_weightPercentile.toStringAsFixed(0)}%', maxLines: 1,),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () async {
                    final currentBaby = summarySnapshot.data['name'];
                    final uid = await Provider.of(context)
                                        .auth
                                        .getCurrentUID();
                    final measureDateFormat = DateFormat('yyyyMMdd').format(_measureDate);

                    Firestore.instance.collection('measurements').document(uid).collection(
                      currentBaby.toString().toLowerCase()).document(measureDateFormat).delete();

                    final latestMeasure = await Firestore.instance.collection("measurements")
                      .document(uid)
                      .collection(currentBaby.toLowerCase()).orderBy("measureDate", descending: true).limit(1).getDocuments();

                    latestMeasure.documents.isNotEmpty ?
                      await Firestore.instance
                        .collection("summaries")
                        .document(uid)
                        .collection(currentBaby.toLowerCase())
                        .document('summary')
                        .updateData({
                      'height': latestMeasure.documents[0].data["height"],
                      'weight': latestMeasure.documents[0].data["weight"],
                      'lastUpdated': latestMeasure.documents[0].data["measureDate"],
                      'unit': latestMeasure.documents[0].data["unit"],
                      'heightPercentile': latestMeasure.documents[0].data["heightPercentile"],
                      'weightPercentile': latestMeasure.documents[0].data["weightPercentile"]
                    })
                    : await Firestore.instance
                        .collection("summaries")
                        .document(uid)
                        .collection(currentBaby.toLowerCase())
                        .document('summary')
                        .updateData({
                          'height': null,
                      'weight': null,
                      'lastUpdated': null,
                      'unit': null,
                      'heightPercentile': null,
                      'weightPercentile': null
                        });
                  },
                  icon: Icon(Icons.clear, color: Colors.red,),
                ),
              )
            )
          ],
        );
      },
    );
  }

  Stream<QuerySnapshot> getUserMeasurementsStreamSnapshots(
      BuildContext context, snapshot) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    final currentBaby = snapshot.data['name'];
    yield* Firestore.instance
        .collection('measurements')
        .document(uid)
        .collection(currentBaby.toString().toLowerCase())
        // .orderBy('__name__', descending: true)
        .snapshots();
  }
}
