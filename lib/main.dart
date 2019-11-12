import 'package:flutter/material.dart';
import 'package:turalura/widgets/home_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Turalura",
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        // theme: new ThemeData(brightness: Brightness.light),
        // darkTheme: new ThemeData(brightness: Brightness.dark),
        home: Home());
  }
}
