import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/views/new_measurement/measurement_view.dart';

class MeasurementCard extends StatelessWidget {
  AsyncSnapshot summarySnapshot;
  Measurement newMeasurement;

  MeasurementCard({
    @required this.summarySnapshot,
    @required this.newMeasurement,
  });

  @override
  Widget build(BuildContext context) {
    String height, weight;
    DateTime lastUpdated;
    if (!summarySnapshot.hasData) return Text('');

    if (summarySnapshot.data['unit'] == 'metric') {
      height = '${summarySnapshot.data['height'].toStringAsFixed(1)} cm';
      weight = '${summarySnapshot.data['weight'].toStringAsFixed(1)} kg';
      lastUpdated = DateTime.parse(
          summarySnapshot.data['lastUpdated'].toDate().toString());
    } else if (summarySnapshot.data['unit'] == 'imperial') {
      height =
          '${(summarySnapshot.data['height'] / 2.54).toStringAsFixed(1)} in';
      weight =
          '${(summarySnapshot.data['weight'] * 2.205).toStringAsFixed(1)} lbs';
      lastUpdated = DateTime.parse(
          summarySnapshot.data['lastUpdated'].toDate().toString());
    } else {
      height = '-';
      weight = '-';
      lastUpdated = null;
    }
    return Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      height: 70.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: SizedBox.fromSize(
                size: Size(60, 60), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.purple, // button color
                    child: InkWell(
                      splashColor: Colors.white, // splash color
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewMeasurementView(
                                    measurement: newMeasurement,
                                    summarySnapshot: summarySnapshot,
                                  )),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.straighten,
                            color: Colors.white,
                          ), // icon
                          Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Card(
              color: Colors.orange,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Last updated",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                lastUpdated == null
                                    ? "No data yet"
                                    : new DateFormat('MMM. d, yyyy')
                                        .format(lastUpdated),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    indent: 5.0,
                    endIndent: 5.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Height",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                height,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    indent: 5.0,
                    endIndent: 5.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Weight",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                weight,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
