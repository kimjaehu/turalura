import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/views/onboarding/switch_view.dart';
import 'package:turalura/widgets/measurement_card.dart';
import 'package:turalura/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

import 'new_measurement/measurement_view.dart';

class HomeView extends StatefulWidget {
  
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final newMeasurement = new Measurement(null, null, null, null, null);
  final int age = 182;
  final int milestoneAge = 3;
  final int milestones = 10;
  final int completedMilestones = 2;
  final double heightCm = 60.0;
  final double weightKg = 6.5;
  
  Widget babyCard(context, userSnapshot) {
    if (!userSnapshot.hasData) {
      return Text("");
    }
    String currentBaby = userSnapshot.data['currentBaby'];

    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SwitchView()),
                  );
                },
                child: Icon(
                  Icons.child_care,
                  size: 50.0,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            indent: 5.0,
            endIndent: 5.0,
          ),
          Expanded(
            flex: 7,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: AutoSizeText(
                  currentBaby,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryCard(context, summarySnapshot) {
    if (!summarySnapshot.hasData) return Text('');
    print(summarySnapshot.data['dob']);

    DateTime dob =
        DateTime.parse(summarySnapshot.data['dob'].toDate().toString());
    DateTime toDate = DateTime.now();
    int dateDifference = toDate.difference(dob).inDays;
    print(dob);
    print(dateDifference);

    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
      height: 85.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Card(
              color: Colors.blue,
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.timer,
                    //       size: 75.0,
                    //       color: Colors.white,
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Text(
                            "Days Since birth",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          dateDifference.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "days old",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Card(
              color: Colors.pink,
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.check_circle_outline,
                    //       size: 75.0,
                    //       color: Colors.white,
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Text(
                            "$milestoneAge mo. milestone",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          completedMilestones.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "/",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          milestones.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressCard(context, summarySnapshot) {
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
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Card(
              color: Colors.orange,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Last updated",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                lastUpdated == null
                                    ? "No data yet"
                                    : new DateFormat('MMM. d, yyyy')
                                        .format(lastUpdated),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
                    flex: 2,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Height",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                height,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
                    flex: 2,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Weight",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                weight,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // VerticalDivider(
                  //   color: Colors.white,
                  //   indent: 5.0,
                  //   endIndent: 5.0,
                  // ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Center(
                  //     child: GestureDetector(
                  //       onTap: () => print("tapped"),
                  //       child: Icon(Icons.assignment),
                  //       // child: Column(
                  //       //   children: <Widget>[
                  //       //     Row(
                  //       //       mainAxisAlignment: MainAxisAlignment.center,
                  //       //       children: <Widget>[
                  //       //         Icon(
                  //       //           Icons.add,
                  //       //           size: 35.0,
                  //       //           color: Colors.white,
                  //       //         ),
                  //       //       ],
                  //       //     ),
                  //       //     Row(
                  //       //       mainAxisAlignment: MainAxisAlignment.center,
                  //       //       crossAxisAlignment: CrossAxisAlignment.baseline,
                  //       //       textBaseline: TextBaseline.alphabetic,
                  //       //       children: <Widget>[
                  //       //         Text(
                  //       //           "Add new",
                  //       //           style: TextStyle(
                  //       //               color: Colors.white,
                  //       //               fontSize: 15.0,
                  //       //               fontWeight: FontWeight.bold),
                  //       //         ),
                  //       //       ],
                  //       //     ),
                  //       //   ],
                  //       // ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: SizedBox.fromSize(
                size: Size(60, 60), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.purple, // button color
                    child: InkWell(
                      splashColor: Colors.white, // splash color
                      onTap: () {
                        
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewMeasurementView(
                                          measurement: newMeasurement,
                                          summarySnapshot: summarySnapshot,
                                        )),
                              );
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.straighten, color: Colors.white,), // icon
                          Text("Update", style: TextStyle(fontSize: 12.0, color: Colors.white,fontWeight: FontWeight.bold),), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressPercentileCard(context, summarySnapshot) {
    return Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      height: 100.0,
      child: Card(
        color: Colors.teal,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Height-for-age",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[],
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
              flex: 5,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Weight-for-age",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildGearsCard(BuildContext context, int index) {
  //   final gear = gearsList[index];
  //   return new Container(
  //     width: 110.0,
  //     child: Card(
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             height: 75.0,
  //             width: 75.0,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               image: new DecorationImage(
  //                 image: new NetworkImage(gear.imageUrl),
  //                 fit: BoxFit.fitWidth,
  //                 alignment: Alignment.topCenter,
  //               ),
  //             ),
  //           ),
  //           Text(gear.name),
  //           Text(gear.rating.toString()),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: Provider.of(context).auth.getUserInfoSnapshot(),
        builder: (context, userSnapshot) {
          return StreamBuilder<Object>(
              stream:
                  Provider.of(context).auth.getUserBabySummaryStreamSnapshots(),
              builder: (context, summarySnapshot) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      babyCard(context, userSnapshot),
                      summaryCard(context, summarySnapshot),
                      // progressCard(context, summarySnapshot),
                      MeasurementCard(summarySnapshot: summarySnapshot, newMeasurement: newMeasurement),
                      progressPercentileCard(context, summarySnapshot),
                    ],
                  ),
                );
              });
        });
  }
}
