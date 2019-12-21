import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turalura/models/Measurement.dart';
import 'package:turalura/views/teething_view.dart';
import 'package:turalura/widgets/measurement_card.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

Color backgroundColor = Colors.white;
Color focusTextColor = Colors.blueGrey[800];
Color primaryTextColor = Colors.white;
Color primaryCardColor = Colors.orange[700];
Color secondaryCardColor = Colors.orange;
Color tertiaryCardColor = Colors.orange[400];

class _HomeViewState extends State<HomeView> {
  final newMeasurement =
      new Measurement(null, null, null, null, null, null, null);

  @override
  void initState() {
    super.initState();
  }

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
                color: backgroundColor,
                child: Column(
                  children: <Widget>[
                    babyCard(context, userSnapshot),
                    MeasurementCard(
                        summarySnapshot: summarySnapshot,
                        newMeasurement: newMeasurement),
                    summaryCard(context, summarySnapshot),
                    // progressCard(context, summarySnapshot),
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

  Widget babyCard(context, userSnapshot) {
    if (!userSnapshot.hasData) {
      return Text("");
    }
    String currentBaby = userSnapshot.data['currentBaby'];
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: AutoSizeText(
                currentBaby,
                maxLines: 1,
                style: TextStyle(
                  color: focusTextColor,
                  fontSize: 60.0,
                  fontFamily: 'Lobster',
                  // fontWeight: FontWeight.bold
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
    final String milestoneMonthNum = summarySnapshot.data['monthNum'] != null
        ? summarySnapshot.data['monthNum']
        : '-';
    final String milestonesCount =
        summarySnapshot.data['milestonesCount'] != null
            ? summarySnapshot.data['milestonesCount'].toString()
            : '-';
    final String milestonesCompleted =
        summarySnapshot.data['milestonesCompleted'] != null
            ? summarySnapshot.data['milestonesCompleted'].toString()
            : '-';

    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              color: primaryCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // AutoSizeText(
                  //   "Days Since birth",
                  //   style: TextStyle(
                  //       color: Colors.white, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      AutoSizeText(
                        dateDifference.toString(),
                        style: TextStyle(
                            fontFamily: 'Righteous',
                            color: primaryTextColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
                          "days old",
                          style: TextStyle(
                              color: primaryTextColor,
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
          Expanded(
            flex: 5,
            child: Container(
              color: secondaryCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    "$milestoneMonthNum mo. milestones",
                    style: TextStyle(
                        color: primaryTextColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      AutoSizeText(
                        milestonesCompleted,
                        style: TextStyle(
                            fontFamily: 'Righteous',
                            color: primaryTextColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: AutoSizeText(
                          "/",
                          style: TextStyle(
                              color: primaryTextColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      AutoSizeText(
                        milestonesCount,
                        style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      // AutoSizeText(
                      //   " completed",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 15.0,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ],
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
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              color: secondaryCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    "Height-for-age",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      AutoSizeText.rich(
                        TextSpan(
                            text: heightPercentile,
                            style: TextStyle(
                                fontFamily: 'Righteous',
                                color: primaryTextColor,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      ' ${heightPercentile == '-' ? '-' : getPercentileText(heightPercentile)}',
                                  style: TextStyle(fontSize: 15.0))
                            ]),
                      ),
                      AutoSizeText(
                        'percentile',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: primaryCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    "Weight-for-age",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      AutoSizeText.rich(
                        TextSpan(
                            text: weightPercentile,
                            style: TextStyle(
                                fontFamily: 'Righteous',
                                color: primaryTextColor,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      ' ${weightPercentile == '-' ? '-' : getPercentileText(weightPercentile)}',
                                  style: TextStyle(fontSize: 15.0))
                            ]),
                      ),
                      AutoSizeText(
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
    );
  }

  Widget teethingCard(context, monthDifference) {
    String assetName;
    String scheduleText;
    if (monthDifference < 6) {
      assetName = 'assets/images/teething/zerotosix.svg';
      scheduleText = '0 to 6 months';
    } else if (monthDifference >= 6 && monthDifference < 8) {
      assetName = 'assets/images/teething/sixtoten.svg';
      scheduleText = '6 to 10 months';
    } else if (monthDifference >= 8 && monthDifference < 9) {
      assetName = 'assets/images/teething/eighttotwelve.svg';
      scheduleText = '8 to 12 months';
    } else if (monthDifference >= 9 && monthDifference < 10) {
      assetName = 'assets/images/teething/ninetothirteen.svg';
      scheduleText = '9 to 13 months';
    } else if (monthDifference >= 10 && monthDifference < 13) {
      assetName = 'assets/images/teething/tentosixteen.svg';
      scheduleText = '10 to 13 months';
    } else if (monthDifference >= 13 && monthDifference < 14) {
      assetName = 'assets/images/teething/thirteentonineteen.svg';
      scheduleText = '13 to 19 months';
    } else if (monthDifference >= 14 && monthDifference < 16) {
      assetName = 'assets/images/teething/fourteentoeighteen.svg';
      scheduleText = '14 to 18 months';
    } else if (monthDifference >= 16 && monthDifference < 17) {
      assetName = 'assets/images/teething/sixteentotwentytwo.svg';
      scheduleText = '16 to 22 months';
    } else if (monthDifference >= 17 && monthDifference < 23) {
      assetName = 'assets/images/teething/seventeentotwentythree.svg';
      scheduleText = '17 to 23 months';
    } else if (monthDifference >= 23 && monthDifference < 25) {
      assetName = 'assets/images/teething/twentythreetothirtyone.svg';
      scheduleText = '23 to 31 months';
    } else if (monthDifference >= 25 && monthDifference < 33) {
      assetName = 'assets/images/teething/twentyfivetothirtythree.svg';
      scheduleText = '25 to 33 months';
    } else {
      assetName = 'assets/images/teething/twentyfivetothirtythree.svg';
      scheduleText = null;
    }
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blueGrey[100],
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeethingView(
                                assetName: assetName,
                                scheduleText: scheduleText,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              SvgPicture.asset(assetName,
                                  semanticsLabel: 'Baby Teething Chart'),
                              Positioned(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                          "Teething",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: focusTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: scheduleText != null
                                            ? AutoSizeText(
                                                scheduleText,
                                                style: TextStyle(
                                                    fontFamily: 'Righteous',
                                                    fontSize: 8.0,
                                                    color: focusTextColor),
                                              )
                                            : null,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TeethingView(
                  //       assetName: assetName,
                  //       scheduleText: scheduleText,
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  color: Colors.blueGrey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.airline_seat_individual_suite,
                        size: 28,
                        color: primaryTextColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          getSleepText(monthDifference),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Righteous',
                            fontSize: 16.0,
                            color: primaryTextColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TeethingView(
                  //       assetName: assetName,
                  //       scheduleText: scheduleText,
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  color: Colors.blueGrey[700],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.restaurant,
                        size: 28,
                        color: primaryTextColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          getFoodText(monthDifference),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Righteous',
                            fontSize: 16.0,
                            color: primaryTextColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getSleepText(double monthDifference) {
    if (monthDifference > 0 && monthDifference < 4) {
      return 'Sleep 14-17 hrs';
    }
    if (monthDifference >= 4 && monthDifference < 12) {
      return 'Sleep 12–16 hrs';
    }
    if (monthDifference >= 12 && monthDifference < 24) {
      return 'Sleep 11–14 hrs';
    }
    return 'Sleep 10–13 hrs';
  }

  String getFoodText(double monthDifference) {
    if (monthDifference > 0 && monthDifference < 6) {
      return 'Breastfeeding or Formula';
    }
    if (monthDifference >= 6 && monthDifference < 12) {
      return 'begin adding solid foods';
    }
    return 'regular meals and snacks';
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

}
