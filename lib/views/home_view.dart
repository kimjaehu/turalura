import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final int age = 182;
  final milestoneAge = "3 mo";
  final milestones = 10;
  final completedMilestones = 2;

  Widget progress() {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 75.0,
      child: Card(
        color: Colors.teal,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                children: <Widget>[
                  Text(
                    age.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                   Text(
                    " days old",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
            VerticalDivider(
              color: Colors.white,
              width: 15.0,
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  milestoneAge,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.white,
              width: 15.0,
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "${completedMilestones.toString()} / ${milestones.toString()}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[progress()],
    ));
  }
}
