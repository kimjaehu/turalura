import 'package:flutter/material.dart';
import 'package:turalura/models/Ads.dart';
import 'package:turalura/views/activities_view.dart';
import 'package:turalura/views/delays_view.dart';
import 'package:turalura/views/home_view.dart';
import 'package:turalura/views/milestone_view.dart';
import 'package:turalura/views/progress_view.dart';

import 'onboarding/switch_view.dart';

// final String appIdForAndroid = "ca-app-pub-3069349665651547~5210469006";
// final String appIdForIOS = "ca-app-pub-3069349665651547~2584305666";

// final String adUnitIDForAndroid = "ca-app-pub-3069349665651547/7645044745";
// final String adUnitIDForIOS = "ca-app-pub-3069349665651547/3514228043";

// String adUnit = adUnitIDForAndroid;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _currentIndex = 0;

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

  // final List<Widget> _children = [
  //   HomeView(),
  //   ProgressView(),
  //   MilestoneView(),
  //   DelaysView(),
  //   ActivitiesView(),
  //   // Gears(),
  // ];

  // MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   keywords: <String>['baby', 'health'],
  //   contentUrl: 'https://flutter.io',
  //   childDirected: false,
  //   testDevices: <String>[
  //     "8916E7F6511D794B8A9DE7869C837372"
  //   ], // Android emulators are considered test devices
  // );

  // BannerAd _bannerAd;

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  //       // https://developers.google.com/admob/android/test-ads
  //       // https://developers.google.com/admob/ios/test-ads
  //       adUnitId: adUnit,
  //       size: AdSize.smartBanner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("BannerAd event is $event");
  //       });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (Platform.isAndroid) {
  //     FirebaseAdMob.instance.initialize(appId: appIdForAndroid);
  //     adUnit = adUnitIDForAndroid;
  //   } else if (Platform.isIOS) {
  //     FirebaseAdMob.instance.initialize(appId: appIdForIOS);
  //     adUnit = adUnitIDForIOS;
  //   }
  //   _bannerAd = createBannerAd()
  //     ..load()
  //     ..show(
  //       anchorOffset: 0.0,
  //       horizontalCenterOffset: 0.0,
  //       anchorType: AnchorType.bottom,
  //     );
  // }

  // @override
  // void dispose() {
  //   _bannerAd.dispose();
  //   super.dispose();
  // }

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
        title: Text(
          "Turalura",
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lobster',
          ),
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

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }
}
