import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/views/onboarding/switch_view.dart';
import 'package:turalura/widgets/measurement_card.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

import 'new_measurement/measurement_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final newMeasurement =
      new Measurement(null, null, null, null, null, null, null);

  Widget babyCard(context, userSnapshot) {
    if (!userSnapshot.hasData) {
      return Text("");
    }

    String currentBaby = userSnapshot.data['currentBaby'];

    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
      height: MediaQuery.of(context).size.height * 0.1,
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
                  Icons.menu,
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
                      color: Colors.grey[700],
                      fontSize: 40.0,
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

    DateTime dob =
        DateTime.parse(summarySnapshot.data['dob'].toDate().toString());
    DateTime toDate = DateTime.now();
    int dateDifference = toDate.difference(dob).inDays;
    final String milestoneMonthNum = summarySnapshot.data['monthNum'];
    final String milestonesCount =
        summarySnapshot.data['milestonesCount'].toString();
    final String milestonesCompleted =
        summarySnapshot.data['milestonesCompleted'].toString();

    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
      height: MediaQuery.of(context).size.height * 0.125,
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
                            "$milestoneMonthNum mo. milestone",
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
                          milestonesCompleted,
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
                          milestonesCount,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " completed",
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
      height: MediaQuery.of(context).size.height * 0.125,
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
                          Icon(
                            Icons.straighten,
                            color: Colors.white,
                          ), // icon
                          Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ), // text
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

  String getPercentileText(String percent) {
    int oneDigitChecker = int.parse(percent) % 10;
    int twoDigitChecker = int.parse(percent) % 100;

    if (oneDigitChecker == 1 && twoDigitChecker != 11) {
      return 'st';
    }
    if (oneDigitChecker == 2 && twoDigitChecker != 12) {
      return 'nd';
    }
    if (oneDigitChecker == 3 && twoDigitChecker != 13) {
      return 'rd';
    }

    return 'th';
  }

  Widget progressPercentileCard(context, summarySnapshot, monthDifference) {
    if (!summarySnapshot.hasData) return Text('');
    String heightPercentile, weightPercentile;

    if (summarySnapshot.data["heightPercentile"] != null) {
      heightPercentile =
          (summarySnapshot.data["heightPercentile"] * 100).toStringAsFixed(0);
      weightPercentile =
          (summarySnapshot.data["weightPercentile"] * 100).toStringAsFixed(0);
    } else {
      heightPercentile = '-';
      weightPercentile = '-';
    }
    return Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
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
                                  bottom: 5.0,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: heightPercentile,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' ${heightPercentile == '-' ? '-' : getPercentileText(heightPercentile)}',
                                          style: TextStyle(fontSize: 15.0))
                                    ]),
                              ),
                              Text(
                                'percentile',
                                style: TextStyle(color: Colors.white),
                              )
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
                                  bottom: 5.0,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: weightPercentile,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' ${weightPercentile == '-' ? '-' : getPercentileText(weightPercentile)}',
                                          style: TextStyle(fontSize: 15.0))
                                    ]),
                              ),
                              Text(
                                'percentile',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              color: Colors.indigo,
              child: Center(child: Text('adga')),
            ),
          )
        ],
      ),
    );
  }

  Widget teethingCard(context, monthDifference) {
    String _assetName;
    if (monthDifference < 6) {
      _assetName = 'assets/images/teething/zerotosix.svg';
    } else if (monthDifference >= 6 && monthDifference < 8) {
      _assetName = 'assets/images/teething/sixtoten.svg';
    } else if (monthDifference >= 8 && monthDifference < 9) {
      _assetName = 'assets/images/teething/eighttotwelve.svg';
    } else if (monthDifference >= 9 && monthDifference < 10) {
      _assetName = 'assets/images/teething/ninetothirteen.svg';
    } else if (monthDifference >= 10 && monthDifference < 13) {
      _assetName = 'assets/images/teething/tentosixteen.svg';
    } else if (monthDifference >= 13 && monthDifference < 14) {
      _assetName = 'assets/images/teething/thirteentonineteen.svg';
    } else if (monthDifference >= 14 && monthDifference < 16) {
      _assetName = 'assets/images/teething/fourteentoeighteen.svg';
    } else if (monthDifference >= 16 && monthDifference < 17) {
      _assetName = 'assets/images/teething/sixteentotwentytwo.svg';
    } else if (monthDifference >= 17 && monthDifference < 23) {
      _assetName = 'assets/images/teething/seventeentotwentythree.svg';
    } else if (monthDifference >= 23 && monthDifference < 25) {
      _assetName = 'assets/images/teething/twentythreetothirtyone.svg';
    } else if (monthDifference >= 25 && monthDifference < 33) {
      _assetName = 'assets/images/teething/twentyfivetothirtythree.svg';
    } else {
      _assetName = 'assets/images/teething/twentyfivetothirtythree.svg';
    }
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 5.0, left: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Card(
                color: Colors.yellow[300],
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Teething Chart",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          SvgPicture.asset(_assetName,
                              semanticsLabel: 'Baby Teething Chart'),
                          // Positioned(

                          //   child: Text("Testing"),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text("agdsgh")],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  String getSleepText(double monthDifference) {
    if (monthDifference > 0 && monthDifference < 4) {
      return '14-17 hrs';
    }
    if (monthDifference >= 4 && monthDifference < 12) {
      return '12–16 hrs';
    }
    if (monthDifference >= 12 && monthDifference < 24) {
      return '11–14 hrs';
    }
    if (monthDifference >= 24 && monthDifference < 60) {
      return '10–13 hrs';
    }
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
    return StreamBuilder(
      stream: Provider.of(context).auth.getUserInfoSnapshot(),
      builder: (context, userSnapshot) {
        return StreamBuilder(
            stream:
                Provider.of(context).auth.getUserBabySummaryStreamSnapshots(),
            builder: (context, summarySnapshot) {
              if (!summarySnapshot.hasData) return circularProgress();
              DateTime dob = DateTime.parse(
                  summarySnapshot.data['dob'].toDate().toString());
              DateTime toDate = DateTime.now();
              double monthDifference =
                  (toDate.difference(dob).inDays) / 30.4375;
              return Container(
                child: Column(
                  children: <Widget>[
                    babyCard(context, userSnapshot),
                    summaryCard(context, summarySnapshot),
                    // progressCard(context, summarySnapshot),
                    MeasurementCard(
                        summarySnapshot: summarySnapshot,
                        newMeasurement: newMeasurement),
                    progressPercentileCard(
                        context, summarySnapshot, monthDifference),
                    teethingCard(context, monthDifference),
                  ],
                ),
              );
            });
      },
    );
  }
}
