import 'package:flutter/material.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/views/new_measurement/date_view.dart';

class NewMeasurementView extends StatefulWidget {
  final Measurement measurement;
  AsyncSnapshot summarySnapshot;
  NewMeasurementView(
      {Key key, @required this.measurement, this.summarySnapshot})
      : super(key: key);

  @override
  _NewMeasurementViewState createState() => _NewMeasurementViewState();
}

class _NewMeasurementViewState extends State<NewMeasurementView> {
  List<bool> isSelected;
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  String unit = 'metric';

  @override
  void initState() {
    isSelected = [true, false];
    // _heightController.text = (widget.measurement.height).toString();
    // _weightController.text = (widget.measurement.weight).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Measurements'),
      ),
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
              conversionToggleButton(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
              Card(
                  color: isSelected[0] ? Colors.lightBlue : Colors.green,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText:
                                  isSelected[0] ? "Height (cm)" : "Height (in)",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.lightBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: isSelected[0] ? "cm" : "in",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold)),
                          controller: _heightController,
                          // autofocus: true,
                        ),
                      ),
                    ],
                  ),
                ),
              
                SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                Card(
                  color: isSelected[0] ? Colors.lightBlue : Colors.green,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText:
                                  isSelected[0] ? "Weight (kg)" : "Weight (lbs)",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.lightBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: isSelected[0] ? "kg" : "lbs",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold)),
                          controller: _weightController,
                          // autofocus: true,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
              ClipOval(
                  child: Material(
                    color: Colors.deepPurple, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                        width: 65,
                        height: 65,
                        child: Icon(
                          Icons.navigate_next,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        widget.measurement.unit = unit;

                        if (unit == "metric") {
                          widget.measurement.height =
                              double.parse(_heightController.text);
                          widget.measurement.weight =
                              double.parse(_weightController.text);
                        } else {
                          widget.measurement.height =
                              double.parse(_heightController.text) * 2.54;
                          widget.measurement.weight =
                              double.parse(_weightController.text) / 2.20462;
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewMeasurementDateView(
                                    measurement: widget.measurement,
                                    summarySnapshot: widget.summarySnapshot)));
                      },
                    ),
                  ),
                ),
              
              // RaisedButton(
              //   color: Colors.deepPurple,
              //   textColor: Colors.white,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 45.0, right: 45.0),
              //     child: Text(
              //       "Next",
              //       style: TextStyle(),
              //     ),
              //   ),
              //   onPressed: () {
              //     widget.measurement.unit = unit;

              //     if (unit == "metric") {
              //       widget.measurement.height =
              //           double.parse(_heightController.text);
              //       widget.measurement.weight =
              //           double.parse(_weightController.text);
              //     } else {
              //       widget.measurement.height =
              //           double.parse(_heightController.text) * 2.54;
              //       widget.measurement.weight =
              //           double.parse(_weightController.text) / 2.20462;
              //     }

              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => NewMeasurementDateView(
              //                 measurement: widget.measurement,
              //                 summarySnapshot: widget.summarySnapshot)));

              //     print(
              //         "${widget.measurement.unit}, ${widget.measurement.height}, ${widget.measurement.weight}");
              //   },
              // ),
              // Expanded(
              //   child: Padding(
              //       padding: EdgeInsets.all(
              //           5.0),
              //       child: Container(
              //         color: Colors.pink,
              //       )),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget conversionToggleButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ToggleButtons(
            color: Colors.amber[800],
            borderColor: Colors.amber[800],
            fillColor: Colors.amber[800],
            borderWidth: 2,
            selectedBorderColor: Colors.amber[800],
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Text(
                    'Metric',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Text(
                    'Imperial',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                    unit = "imperial";
                  } else {
                    isSelected[i] = false;
                    unit = "metric";
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }
}
