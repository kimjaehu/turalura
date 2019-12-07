import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class NewMeasurementDateView extends StatefulWidget {
  final Measurement measurement;
  AsyncSnapshot summarySnapshot;
  NewMeasurementDateView(
      {Key key, @required this.measurement, this.summarySnapshot})
      : super(key: key);

  @override
  _NewMeasurementViewState createState() => _NewMeasurementViewState();
}

class _NewMeasurementViewState extends State<NewMeasurementDateView> {
  final db = Firestore.instance;

  DateTime _date = new DateTime.now();
  bool _dateValidator;

  Future<Object> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  @override
  void initState() {
    super.initState();
    _dateValidator = true;
    widget.measurement.measureDate = _date;
  }

  Future<double> calculatePercentile(
      String gender, String category, int day, double measurement, String unit) async {
    Map<String, dynamic> growthData =
        await parseJsonFromAssets('assets/data_repo/growth_data.json');

    double lowerPercentile,
        heigherPercentile,
        lowerMeasurement,
        higherMeasurement = 0;
    double p01 = growthData[gender][category][day.toString()]["P01"];
    double p1 = growthData[gender][category][day.toString()]["P1"];
    double p3 = growthData[gender][category][day.toString()]["P3"];
    double p5 = growthData[gender][category][day.toString()]["P5"];
    double p10 = growthData[gender][category][day.toString()]["P10"];
    double p15 = growthData[gender][category][day.toString()]["P15"];
    double p25 = growthData[gender][category][day.toString()]["P25"];
    double p50 = growthData[gender][category][day.toString()]["P50"];
    double p75 = growthData[gender][category][day.toString()]["P75"];
    double p85 = growthData[gender][category][day.toString()]["P85"];
    double p90 = growthData[gender][category][day.toString()]["P90"];
    double p95 = growthData[gender][category][day.toString()]["P95"];
    double p97 = growthData[gender][category][day.toString()]["P97"];
    double p99 = growthData[gender][category][day.toString()]["P99"];
    double p999 = growthData[gender][category][day.toString()]["P999"];

    if (measurement > 0 && measurement <= p01) {
      return 0.01;
    } else if (measurement > p01 && measurement <= p1) {
      lowerPercentile = 0.001;
      heigherPercentile = 0.01;
      lowerMeasurement = p01;
      higherMeasurement = p1;
    } else if (measurement > p1 && measurement <= p3) {
      lowerPercentile = 0.01;
      heigherPercentile = 0.03;
      lowerMeasurement = p1;
      higherMeasurement = p3;
    } else if (measurement > p3 && measurement <= p5) {
      lowerPercentile = 0.01;
      heigherPercentile = 0.05;
      lowerMeasurement = p3;
      higherMeasurement = p5;
    } else if (measurement > p5 && measurement <= p10) {
      lowerPercentile = 0.05;
      heigherPercentile = 0.1;
      lowerMeasurement = p5;
      higherMeasurement = p10;
    } else if (measurement > p10 && measurement <= p15) {
      lowerPercentile = 0.1;
      heigherPercentile = 0.15;
      lowerMeasurement = p10;
      higherMeasurement = p15;
    } else if (measurement > p15 && measurement <= p25) {
      lowerPercentile = 0.15;
      heigherPercentile = 0.25;
      lowerMeasurement = p15;
      higherMeasurement = p25;
    } else if (measurement > p25 && measurement <= p50) {
      lowerPercentile = 0.25;
      heigherPercentile = 0.5;
      lowerMeasurement = p25;
      higherMeasurement = p50;
    } else if (measurement > p50 && measurement <= p75) {
      lowerPercentile = 0.5;
      heigherPercentile = 0.75;
      lowerMeasurement = p50;
      higherMeasurement = p75;
    } else if (measurement > p75 && measurement <= p85) {
      lowerPercentile = 0.75;
      heigherPercentile = 0.85;
      lowerMeasurement = p75;
      higherMeasurement = p85;
    } else if (measurement > p85 && measurement <= p90) {
      lowerPercentile = 0.85;
      heigherPercentile = 0.90;
      lowerMeasurement = p85;
      higherMeasurement = p90;
    } else if (measurement > p90 && measurement <= p95) {
      lowerPercentile = 0.90;
      heigherPercentile = 0.95;
      lowerMeasurement = p90;
      higherMeasurement = p95;
    } else if (measurement > p95 && measurement <= p97) {
      lowerPercentile = 0.95;
      heigherPercentile = 0.97;
      lowerMeasurement = p95;
      higherMeasurement = p97;
    } else if (measurement > p97 && measurement <= p99) {
      lowerPercentile = 0.97;
      heigherPercentile = 0.99;
      lowerMeasurement = p97;
      higherMeasurement = p99;
    } else if (measurement > p99 && measurement <= p999) {
      lowerPercentile = 0.99;
      heigherPercentile = 0.999;
      lowerMeasurement = p99;
      higherMeasurement = p999;
    }
    if (measurement > p999) {
      return 99.9;
    }

    return lowerPercentile +
        ((measurement - lowerMeasurement) /
            (higherMeasurement - lowerMeasurement) *
            (heigherPercentile - lowerPercentile));
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.summarySnapshot.hasData) {
      return circularProgress();
    }
    print('dob ${widget.summarySnapshot.data['dob']}');
    DateTime dob =
        DateTime.parse(widget.summarySnapshot.data['dob'].toDate().toString());

    print(dob);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Measurement Date'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300.0,
              child: CupertinoDatePicker(
                initialDateTime: _date,
                minimumDate: dob,
                minimumYear: dob.year,
                maximumDate: _date,
                maximumYear: _date.year,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (pickedDate) {
                  print("$pickedDate, $_date");
                  if (pickedDate.isBefore(_date) &&
                      pickedDate.isAfter(dob.subtract(new Duration(days: 1)))) {
                    int dateDifference = pickedDate.difference(dob).inDays;
                    setState(() {
                      _dateValidator = true;
                      widget.measurement.measureDate = pickedDate;
                    });
                  } else {
                    setState(() {
                      _dateValidator = false;
                      widget.measurement.measureDate = null;
                      widget.measurement.day = null;
                    });
                  }
                },
              ),
            ),
            RaisedButton(
              color: _dateValidator ? Colors.deepPurple : Colors.grey[400],
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 45.0, right: 45.0),
                child: Text(
                  _dateValidator ? "Save" : "Invalid date",
                  style: TextStyle(),
                ),
              ),
              onPressed: () async {
                int dateDifference =
                      widget.measurement.measureDate.difference(dob).inDays;
                String babyGender =
                      widget.summarySnapshot.data['gender'];
                print('babygender: $babyGender');
                  double heightPercentile = await calculatePercentile(
                          babyGender,
                          "height",
                          dateDifference,
                          widget.measurement.height,
                          widget.measurement.unit)
                      .catchError((onError) {
                    print(onError);
                  });
                  double weightPercentile = await calculatePercentile(
                          babyGender,
                          "weight",
                         dateDifference,
                          widget.measurement.weight,
                          widget.measurement.unit)
                      .catchError((onError) {
                    print(onError);
                  });

                setState(() {
                  widget.measurement.day = dateDifference;
                  widget.measurement.heightPercentile = heightPercentile;
                  widget.measurement.weightPercentile = weightPercentile;
                });

                if (_dateValidator) {
                  final uid = await Provider.of(context).auth.getCurrentUID();
                  final userInfo = await Firestore.instance
                      .collection('users')
                      .document(uid)
                      .get();
                  String userBaby = userInfo.data['currentBaby'].toString();
                  

                  await db
                      .collection("measurements")
                      .document(uid)
                      .collection(userBaby.toLowerCase())
                      .document(DateFormat('yyyyMMdd')
                          .format(widget.measurement.measureDate))
                      .setData(widget.measurement.toJson());

                  final latestMeasure = await db.collection("measurements")
                      .document(uid)
                      .collection(userBaby.toLowerCase()).orderBy("measureDate").limit(1).getDocuments();

                  await db
                      .collection("summaries")
                      .document(uid)
                      .collection(userBaby.toLowerCase())
                      .document('summary')
                      .updateData({
                    'height': widget.measurement.height,
                    'weight': widget.measurement.weight,
                    'lastUpdated': widget.measurement.measureDate,
                    'unit': widget.measurement.unit,
                    'heightPercentile': heightPercentile,
                    'weightPercentile': weightPercentile
                  });
                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  Text('');
                }
              },
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, right: 5.0, left: 5.0, bottom: 10.0),
                  child: Container(
                    color: Colors.pink,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
