import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:turalura/models/Gear.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:turalura/views/onboarding/switch_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final int age = 182;
  final int milestoneAge = 3;
  final int milestones = 10;
  final int completedMilestones = 2;
  final double heightCm = 60.0;
  final double weightKg = 6.5;
  final List<Gear> gearsList = [
    Gear(
        "Uppababy Minu",
        "Stroller",
        "purchaseUrl",
        "https://images-na.ssl-images-amazon.com/images/I/61KtJYa0LyL._SL1001_.jpg",
        "Good",
        4.5,
        3),
    Gear(
        "Babyzen Yoyo+",
        "Stroller",
        "purchaseUrl",
        "https://images-na.ssl-images-amazon.com/images/I/61V5a4VsfYL._SL1500_.jpg",
        "Good",
        4.0,
        3),
    Gear(
        "Clek Fllo",
        "Car Seat",
        "purchaseUrl",
        "https://images-na.ssl-images-amazon.com/images/I/81ZFHWAG1RL._SL1500_.jpg",
        "Good",
        4.0,
        2),
  ];

  Widget summaryCard() {
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
                            "Days ince birth",
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
                          age.toString(),
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

  Widget progressCard() {
    return Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      height: 70.0,
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
                          "Sep. 20, 2019",
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
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                          "${heightCm.toString()} cm",
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
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                          "${weightKg.toString()} kg",
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
                child: GestureDetector(
                  onTap: () => print("tapped"),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.show_chart,
                            size: 35.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            "Progress",
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
      ),
    );
  }

  Widget progressChartCard() {
    return Container(
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      height: 150.0,
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

  Widget babyCard() {
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
                  "Baby Sean",
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

  Widget buildGearsCard(BuildContext context, int index) {
    final gear = gearsList[index];
    return new Container(
      width: 110.0,
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 75.0,
              width: 75.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: new NetworkImage(gear.imageUrl),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Text(gear.name),
            Text(gear.rating.toString()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          babyCard(),
          summaryCard(),
          progressCard(),
          progressChartCard(),
        ],
      ),
    );
  }
}
