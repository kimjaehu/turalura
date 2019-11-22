import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/services/auth_service.dart';
import 'package:turalura/views/onboarding/add_view.dart';
import 'package:turalura/widgets/provider_widget.dart';

class SwitchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Baby"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
                print("Signed out");
              } catch (e) {
                print(e);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.usb),
            onPressed: () async {
              try {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddView()),
                  );
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      )),
    );
  }
}
