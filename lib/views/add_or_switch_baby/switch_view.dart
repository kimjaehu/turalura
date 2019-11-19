import 'package:flutter/material.dart';
import 'package:turalura/services/auth_service.dart';
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
        child: IconButton(
          icon: Icon(Icons.undo),onPressed: () async {
            try{
              AuthService auth = Provider.of(context).auth;
              await auth.signOut();
              Navigator.of(context).pushReplacementNamed('/home');
              print("Signed out");
            } catch(e) {
              print(e);
            }
          },),
        
      ),
    );
  }
}
