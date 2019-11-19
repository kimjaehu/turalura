import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:turalura/widgets/provider_widget.dart';

class NewMeasurementDateView extends StatefulWidget {

  final Measurement measurement;
  NewMeasurementDateView({Key key, @required this.measurement})
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
                minimumDate: _date,
                maximumDate: _date,
                maximumYear: _date.year,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (pickedDate) {
                  print("$pickedDate, $_date");
                  if (pickedDate.isBefore(_date) ) {
                    setState(() {
                      _dateValidator = true;
                      widget.measurement.measureDate = pickedDate;
                    });
                  } else {
                    setState(() {
                      _dateValidator = false;
                      widget.measurement.measureDate = null;
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
                if (_dateValidator) {
                  final uid = await Provider.of(context).auth.getCurrentUID();

                  await db.collection("measurements").document(uid).collection('userMeasurements').add(widget.measurement.toJson());
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
