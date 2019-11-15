import 'package:flutter/material.dart';
import 'package:turalura/models/Measurement.dart';

class NewMeasurementDateView extends StatelessWidget {
  final Measurement measurement;
  NewMeasurementDateView({Key key, @required this.measurement})
      : super(key: key);

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
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Card(
                
              ),
            ),
            
            RaisedButton(
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 45.0, right: 45.0),
                child: Text(
                  "Next",
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
