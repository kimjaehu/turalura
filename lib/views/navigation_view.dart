import 'package:flutter/material.dart';
import 'package:turalura/models/Ads.dart';
import 'package:turalura/views/activities_view.dart';
import 'package:turalura/views/delays_view.dart';
import 'package:turalura/views/home_view.dart';
import 'package:turalura/views/milestone_view.dart';
import 'package:turalura/views/progress_view.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

import 'onboarding/switch_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.blueGrey[800],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SwitchView()),
            );
          },
        ),
        title: FutureBuilder(
          future: Provider.of(context).auth.getAnonymous(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print('snapshot data ${snapshot.data}');

            if (!snapshot.hasData) return circularProgress();
            return snapshot.data
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Turalura: Trial",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lobster',
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 16.0,
                          )
                        ],
                      ),
                      RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                : Text(
                    "Turalura",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lobster',
                    ),
                  );
          },
        ),
      ),
      // body: _children[_currentIndex],
      body: PageView(
        children: <Widget>[
          HomeView(),
          ProgressView(),
          MilestoneView(),
          DelaysView(),
          ActivitiesView(),
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.blueGrey[800],
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: Ads.getMargin(screenHeight)),
          child: BottomNavigationBar(
            selectedItemColor: Colors.orangeAccent,
            unselectedItemColor: Colors.grey,
            onTap: onTap,
            currentIndex: _pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.child_care,
                ),
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
                icon: new Icon(
                  Icons.new_releases,
                  color: Colors.red,
                ),
                title: new Text("Important"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.extension),
                title: new Text("Activities"),
              ),
              // BottomNavigationBarItem(
              //   icon: new Icon(Icons.child_friendly),
              //   title: new Text("Gears"),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = RaisedButton(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        child: RichText(
          text: TextSpan(
            text: 'Sign in with ',
            style: TextStyle(fontSize: 20.0, color: Colors.orange),
            children: <TextSpan>[
              TextSpan(
                  text: 'G',
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'o',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'o',
                  style: TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'g',
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'l',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'e',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      onPressed: submit,
      color: Colors.white,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.orange,
        title: Text("Sign In For Free Account"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        content: Text(
            "With an account, your data will be securely saved, allowing you to access it from multiple devices."),
        contentTextStyle: TextStyle(
            fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
        actions: [
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              okButton,
            ],
          )
        ]
        // [
        //   okButton,
        // ],
        );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void submit() async {
    try {
      final auth = Provider.of(context).auth;
      String uid = await auth.convertWithGoogle();
      print("signed in with google: $uid");
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print(e);
    }
  }
}
