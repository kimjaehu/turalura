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
    } catch (e) {
      print(e);
    }
  }

  Future submitAnonymous() async {
    final auth = Provider.of(context).auth;
    await auth.signInAnonymously();
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.orange,
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
                  child: RichText(
                    text: TextSpan(
                      text: 'Sign in with ',
                      style: TextStyle(fontSize: 20.0, color: Colors.orange),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'G',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'o',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'o',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'g',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'l',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'e',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                onPressed: submit,
                color: Colors.white,
              ),
              FlatButton(
                  child: Text(
                    "Try without signing in",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: submitAnonymous)
            ],
          ),
        ),
      ),
    );
  }
}
