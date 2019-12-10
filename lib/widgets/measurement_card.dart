import 'package:auto_size_text/auto_size_text.dart';
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
      child: Card(
        color: Colors.orange,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "Last updated",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    AutoSizeText(
                      lastUpdated == null
                          ? "No data yet"
                          : new DateFormat('MMM. d, yyyy').format(lastUpdated),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
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
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "Height",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    AutoSizeText(
                      height,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
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
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "Weight",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    AutoSizeText(
                      weight,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: InkWell(
                    splashColor: Colors.orange, // splash color
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewMeasurementView(
                            measurement: newMeasurement,
                            summarySnapshot: summarySnapshot,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.straighten,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
