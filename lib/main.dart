import 'package:flutter/material.dart';
import 'package:turalura/home_widget.dart';
import 'package:turalura/services/auth_service.dart';
import 'package:turalura/views/landing_view.dart';
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
          routes: <String, WidgetBuilder> {
            '/home': (BuildContext context) => HomeController(),
          },),
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
        if(snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : LandingView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


