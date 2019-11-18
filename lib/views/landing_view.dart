import 'package:flutter/material.dart';
import 'package:turalura/widgets/provider_widget.dart';

class LandingView extends StatefulWidget {

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  void submit() async {
  try {
    final auth = Provider.of(context).auth;
    String uid = await auth.signInWithGoogle();
    print("signed in with google: $uid");
    Navigator.of(context).pushReplacementNamed('/home');
    } catch(e) {
    print(e);
  }
}
  

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Turalura",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: height * .1,
              ),
              RaisedButton(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    child: Text(
                      "Sign in with Google",
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                    )),
                onPressed: submit,
                color: Colors.white,
              ),
              // RaisedButton(
              //   child: Padding(
              //       padding: EdgeInsets.fromLTRB(8.5, 5.0, 8.5, 5.0),
              //       child: Text(
              //         "Sign in with Facebook",
              //         style:
              //             TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
              //       )),
              //   onPressed: () {},
              //   color: Colors.white,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
