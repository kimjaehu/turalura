import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/services/auth_service.dart';
import 'package:turalura/views/landing_view.dart';
import 'package:turalura/views/navigation_view.dart';
import 'package:turalura/views/onboard_view.dart';
import 'package:turalura/views/onboarding/add_view.dart';
import 'package:turalura/views/onboarding/country_view.dart';
import 'package:turalura/widgets/provider_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        return CircularProgressIndicator();
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
          return Home();
        }  
        return CircularProgressIndicator();
      },
    );
  }
}

// Stream<DocumentSnapshot> getUserInfoSnapshot(BuildContext context) async* {
//   final uid = await Provider.of(context).auth.getCurrentUID();
//   yield* Firestore.instance.collection('users').document(uid).snapshots();
// }