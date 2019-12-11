import 'dart:io' show Platform;

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:turalura/views/activities_view.dart';
import 'package:turalura/views/delays_view.dart';
import 'package:turalura/views/home_view.dart';
import 'package:turalura/views/milestone_view.dart';
import 'package:turalura/views/progress_view.dart';

final String appIdForAndroid = "ca-app-pub-3069349665651547~5210469006";
final String appIdForIOS = "ca-app-pub-3069349665651547~2584305666";

final String adUnitIDForAndroid = "ca-app-pub-3069349665651547/7645044745";
final String adUnitIDForIOS = "ca-app-pub-3069349665651547/3514228043";

String adUnit = adUnitIDForAndroid;

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
    ActivitiesView(),
    // Gears(),
  ];

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['baby', 'health'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[
      "8916E7F6511D794B8A9DE7869C837372"
    ], // Android emulators are considered test devices
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: adUnit,
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      FirebaseAdMob.instance.initialize(appId: appIdForAndroid);
      adUnit = adUnitIDForAndroid;
    } else if (Platform.isIOS) {
      FirebaseAdMob.instance.initialize(appId: appIdForIOS);
      adUnit = adUnitIDForIOS;
    }
    _bannerAd = createBannerAd()
      ..load()
      ..show(
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Turalura",
          style: TextStyle(color: Colors.amber[800]),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: BottomNavigationBar(
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
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
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
