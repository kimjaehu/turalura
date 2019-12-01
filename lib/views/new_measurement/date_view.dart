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
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  @override
  void initState() {
    super.initState();
    _dateValidator = true;
    widget.measurement.measureDate = _date;
    calculatePercentile("boy", "height", 5, 47.6);
  }
  
  Future<double> calculatePercentile( String gender, String category, int day, double measurement) async {
    Map<String, dynamic> growthData = await parseJsonFromAssets('assets/data_repo/growth_data.json');

    print(growthData[gender][category][day.toString()]);
    double percentile, lowerPercentile, heigherPercentile, lowerMeasurement, higherMeasurement = 0;
    double p01 = growthData[gender][category][day.toString()]["p01"];
    double p1 = growthData[gender][category][day.toString()]["p1"];
    double p3 =growthData[gender][category][day.toString()]["p3"];
    double p5 = growthData[gender][category][day.toString()]["p5"];
    double p10 = growthData[gender][category][day.toString()]["p10"];
    double p15 =growthData[gender][category][day.toString()]["p15"];
    double p25 =growthData[gender][category][day.toString()]["p25"];
    double p50 =growthData[gender][category][day.toString()]["p50"];
    double p75 =growthData[gender][category][day.toString()]["p75"];
    double p85 =growthData[gender][category][day.toString()]["p85"];
    double p90 =growthData[gender][category][day.toString()]["p90"];
    double p95 =growthData[gender][category][day.toString()]["p95"];
    double p97 =growthData[gender][category][day.toString()]["p97"];
    double p99 =growthData[gender][category][day.toString()]["p99"];
    double p999 =growthData[gender][category][day.toString()]["p999"];

    if (measurement > 0 && measurement <= p01) {
      lowerPercentile = 0;
      heigherPercentile = 0.001;
      lowerMeasurement = 0;
      higherMeasurement = p01;
    } else if (measurement > p01 && measurement <= p1) {
      lowerPercentile = 0.001;
      heigherPercentile = 0.01;
      lowerMeasurement = p01;
      higherMeasurement = p1;
    } else if (measurement > p1 && measurement <= p3) {
      lowerPercentile = 0.01;
      heigherPercentile = 0.03;
    } else if (measurement > p3 && measurement <= p5) {
      lowerPercentile = 0.01;
      heigherPercentile = 0.05;
    } else if (measurement > p5 && measurement <= p10) {
      lowerPercentile = 0.05;
      heigherPercentile = 0.1;
    } else if (measurement > p10 && measurement <= p15) {
      lowerPercentile = 0.1;
      heigherPercentile = 0.15;
    } else if (measurement > p15 && measurement <= p25) {
      lowerPercentile = 0.15;
      heigherPercentile = 0.25;
    } else if (measurement > p25 && measurement <= p50) {
      lowerPercentile = 0.25;
      heigherPercentile = 0.5;
    } else if (measurement > p50 && measurement <= p75) {
      lowerPercentile = 0.5;
      heigherPercentile = 0.75;
    } else if (measurement > p75 && measurement <= p85) {
      lowerPercentile = 0.75;
      heigherPercentile = 0.85;
    } else if (measurement > p85 && measurement <= p90) {
      lowerPercentile = 0.85;
      heigherPercentile = 0.90;
    } else if (measurement > p90 && measurement <= p95) {
      lowerPercentile = 0.90;
      heigherPercentile = 0.95;
    } else if (measurement > p95 && measurement <= p97) {
      lowerPercentile = 0.95;
      heigherPercentile = 0.97;
    } else if (measurement > p97 && measurement <= p99) {
      lowerPercentile = 0.97;
      heigherPercentile = 0.99;
    } else if (measurement > p99 && measurement <= p999) {
      lowerPercentile = 0.99;
      heigherPercentile = 0.999;
    } 

    percentile = lowerPercentile + (
      
    )
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
                setState(() {
                  int dateDifference =
                      widget.measurement.measureDate.difference(dob).inDays;
                  widget.measurement.day = dateDifference;
                });

                if (_dateValidator) {
                  final uid = await Provider.of(context).auth.getCurrentUID();
                  final userInfo = await Firestore.instance
                      .collection('users')
                      .document(uid)
                      .get();
                  String userBaby = userInfo.data['currentBaby'].toString();
                  String babyGender = widget.summarySnapshot.data['gender'].toString();

                  double heightPercentile =
                      await calculatePercentile(babyGender, "height", widget.measurement.day,widget.measurement.height).catchError((onError) {
                    print(onError);
                  });
                  double weightPercentile =
                      await calculatePercentile(babyGender, "weight", widget.measurement.day,widget.measurement.height).catchError((onError) {
                    print(onError);
                  });

                  await db
                      .collection("measurements")
                      .document(uid)
                      .collection(userBaby.toLowerCase())
                      .document(DateFormat('yyyyMMdd')
                          .format(widget.measurement.measureDate))
                      .setData(widget.measurement.toJson());

                  await db
                      .collection("summaries")
                      .document(uid)
                      .collection(userBaby.toLowerCase())
                      .document('summary')
                      .updateData({
                    'height': widget.measurement.height,
                    'weight': widget.measurement.weight,
                    'lastUpdated': widget.measurement.measureDate,
                    'unit': widget.measurement.unit
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
