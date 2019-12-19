import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turalura/views/onboarding/add_view.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class SwitchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('My baby'),
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: getUserBabyListStreamSnapshots(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if (!snapshot.hasData) return babyCard(context, null, 0);
            if (!snapshot.hasData) return circularProgress();
            return new GridView.builder(
              itemCount: snapshot.data.documents.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return babyCard(context, snapshot, index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget babyCard(context, snapshot, index) {
    if (index == 0) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddView()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: Colors.blueGrey[700],
            child: Icon(
              Icons.add,
              size: 100.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    String babyName = snapshot.data.documents[index - 1]['name'];
    String gender = snapshot.data.documents[index - 1]['gender'];
    Timestamp dob = snapshot.data.documents[index -1]['dob'];
    return GestureDetector(
      onTap: () async {
        final uid = await Provider.of(context).auth.getCurrentUID();
        await Firestore.instance
            .collection('users')
            .document(uid)
            .updateData({'currentBaby': babyName, 'dob': dob});
        Navigator.of(context).pushReplacementNamed('/home');
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
            color: gender == 'boy' ? Colors.lightBlue[400] : Colors.pink[300],
            child: Container(
              child: ListTile(
                title: Center(
                    child: AutoSizeText(
                  babyName,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )),
      ),
    );
  }

  Stream<QuerySnapshot> getUserBabyListStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('babies')
        .document(uid)
        .collection('userBabies')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
