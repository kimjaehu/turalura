import 'package:flutter/material.dart';

class NewMeasurementView extends StatefulWidget {
  @override
  _NewMeasurementViewState createState() => _NewMeasurementViewState();
}

class _NewMeasurementViewState extends State<NewMeasurementView> {
  List<bool> isSelected;
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New measurement'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
        child: Column(
          children: <Widget>[
            conversionToggleButton(),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Card(
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
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Card(
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
                                isSelected[0] ? "Weight (kg)" : "Weight (lb)",
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: isSelected[0] ? "kg" : "lb",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold)),
                        controller: _weightController,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
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
              onPressed: () {},
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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Metric',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Imperial',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                  } else {
                    isSelected[i] = false;
                  }
                }
                print(isSelected);
              });
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }
}
