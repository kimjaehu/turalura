import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/services/auth_service.dart';
import 'package:turalura/views/landing_view.dart';
import 'package:turalura/views/navigation_view.dart';
import 'package:turalura/views/onboard_view.dart';
import 'package:turalura/views/onboarding/add_view.dart';
import 'package:turalura/views/onboarding/country_view.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;

void main() => runApp(MyApp());

  final String appIdForAndroid = "ca-app-pub-3069349665651547~5210469006";
  final String appIdForIOS = "ca-app-pub-3069349665651547~2584305666";

  final String adUnitIDForAndroid = "ca-app-pub-3069349665651547/7645044745";
  final String adUnitIDForIOS = "ca-app-pub-3069349665651547/3514228043";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



String adUnit = adUnitIDForAndroid;

    if (Platform.isAndroid) {
      FirebaseAdMob.instance.initialize(appId: appIdForAndroid);
      adUnit = adUnitIDForAndroid;
    } else if (Platform.isIOS) {
      FirebaseAdMob.instance.initialize(appId: appIdForIOS);
      adUnit = adUnitIDForIOS;
    }

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['baby', 'health'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

  

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: adUnit,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);


    myBanner
    // typically this happens well before the ad is shown
    ..load()
    ..show(
      // Positions the banner ad 60 pixels from the bottom of the screen
      anchorOffset: 60.0,
      // Positions the banner ad 10 pixels from the center of the screen to the right
      horizontalCenterOffset: 10.0,
      // Banner Position
      anchorType: AnchorType.bottom,
    );

    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Turalura",
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        // theme: new ThemeData(brightness: Brightness.light),
        // darkTheme: new ThemeData(brightness: Brightness.dark),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/country': (BuildContext context) => CountryView(),
          '/add': (BuildContext context) => AddView(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? UserInfoController() : LandingView();
        }
        return circularProgress();
      },
    );
  }
}

class UserInfoController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.getUserInfoSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.hasData){
          if (!snapshot.data.exists) { 
            return OnboardView();
          }
          if (snapshot.data["currentBaby"] == null) {
            return AddView();
          } else {
            return Home();
          }
          
        }  
        return circularProgress();
      },
    );
  }
}

// Stream<DocumentSnapshot> getUserInfoSnapshot(BuildContext context) async* {
//   final uid = await Provider.of(context).auth.getCurrentUID();
//   yield* Firestore.instance.collection('users').document(uid).snapshots();
// }