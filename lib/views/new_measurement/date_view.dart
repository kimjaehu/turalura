import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class NewMeasurementDateView extends StatefulWidget {
  final Measurement measurement;
  AsyncSnapshot summarySnapshot;
  NewMeasurementDateView({Key key, @required this.measurement, this.summarySnapshot})
      : super(key: key);

  @override
  _NewMeasurementViewState createState() => _NewMeasurementViewState();
}

class _NewMeasurementViewState extends State<NewMeasurementDateView> {
  final db = Firestore.instance;

  DateTime _date = new DateTime.now();
  bool _dateValidator;

  @override
  void initState() {
    super.initState();
    _dateValidator = true;
    widget.measurement.measureDate = _date;
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
                  if (pickedDate.isBefore(_date) && pickedDate.isAfter(dob.subtract(new Duration(days: 1)))) {
                    int dateDifference = pickedDate.difference(dob).inDays;
                    setState(() {
                      _dateValidator = true;
                      widget.measurement.measureDate = pickedDate;
                      widget.measurement.day = dateDifference;
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
                  int dateDifference = _date.difference(dob).inDays;
                  widget.measurement.day = dateDifference;
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
                      .document(DateFormat('yyyyMMdd').format(widget.measurement.measureDate))
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
