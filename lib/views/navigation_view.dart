import 'package:flutter/material.dart';
import 'package:turalura/pages.dart';
import 'package:turalura/views/delays_view.dart';
import 'package:turalura/views/home_view.dart';
import 'package:turalura/views/milestone_view.dart';
import 'package:turalura/views/progress_view.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
int _currentIndex = 0;
final List<Widget> _children = [
  HomeView(),
  ProgressView(),
  MilestoneView(),
  DelaysView(),
  Activities(),
  Gears(),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Turalura", style: TextStyle(color: Colors.amber[800]),),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.child_care,),
            title: new Text("home"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.show_chart),
            title: new Text("Progress"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.check_circle_outline),
            title: new Text("Milestones"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.new_releases, color: Colors.red,),
            title: new Text("Important"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.accessibility_new),
            title: new Text("Activities"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.child_friendly),
            title: new Text("Gears"),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
