import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turalura/models/Measurement.dart';

class NewMeasurementDateView extends StatefulWidget {
  final Measurement measurement;
  NewMeasurementDateView({Key key, @required this.measurement}) : super(key:key);

  @override
  _NewMeasurementViewState createState() => _NewMeasurementViewState();
}

class _NewMeasurementViewState extends State<NewMeasurementDateView> {

  DateTime _date = new DateTime.now();

  @override
  void initState() {

    super.initState();
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
                  print(pickedDate);
                },              
              ),
            ),
            
            
            RaisedButton(
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 45.0, right: 45.0),
                child: Text(
                  "Save",
                  style: TextStyle(),
                ),
              ),
              onPressed: () {
                
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
