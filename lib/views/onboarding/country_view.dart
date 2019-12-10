import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/widgets/provider_widget.dart';

class CountryView extends StatefulWidget {
  @override
  _CountryViewState createState() => _CountryViewState();
}

class _CountryViewState extends State<CountryView> {
  final db = Firestore.instance;
  List<bool> isSelected;
  String country = 'us';

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.orangeAccent,
        child: SafeArea(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: AutoSizeText(
                "Where are you?",
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            countryToggleButton(),
            SizedBox(
              height: height * 0.3,
            ),

            ClipOval(
              child: Material(
                color: Colors.white, // button color
                child: InkWell(
                  splashColor: Colors.orangeAccent, // inkwell color
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: Icon(
                      Icons.check,
                      size: 35,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  onTap: () async {
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    await db.collection("users").document(uid).setData(
                        {'country': country, 'currentBaby': null, 'dob': null});

                    Navigator.of(context).pushReplacementNamed('/add');
                  },
                ),
              ),
            )

            // RaisedButton(
            //   onPressed: () async {
            //     final uid = await Provider.of(context).auth.getCurrentUID();
            //     await db
            //         .collection("users")
            //         .document(uid)
            //         .setData({'country': country, 'currentBaby': null, 'dob': null});

            //     Navigator.of(context).pushReplacementNamed('/add');

            //   },
            //   color: Colors.white,
            //   textColor: Colors.amber[800],
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
            //     child: Text("Save"),
            //   ),
            // )
          ],
        )),
      ),
    );
  }

  Widget countryToggleButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ToggleButtons(
            color: Colors.white,
            borderColor: Colors.white,
            fillColor: Colors.white,
            borderWidth: 2,
            selectedBorderColor: Colors.white,
            selectedColor: Colors.amber[800],
            borderRadius: BorderRadius.circular(5.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'US',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Canada',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                    country = "ca";
                  } else {
                    isSelected[i] = false;
                    country = "us";
                  }
                }
                print("$isSelected, $country");
              });
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }
}
