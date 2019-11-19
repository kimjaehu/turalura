import 'package:flutter/material.dart';

class SwitchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.orangeAccent[200],
        child: SafeArea(
          child: Column(),
        ),
      ),
    );
  }
}
