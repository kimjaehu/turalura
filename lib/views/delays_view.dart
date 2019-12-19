import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class DelaysView extends StatefulWidget {
  @override
  _DelaysViewState createState() => _DelaysViewState();
}

class _DelaysViewState extends State<DelaysView> {
  int selectedCount;
  String monthNum;
  int initMonth;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this.initialMonth();
    });
  }

  initialMonth() async {
    int monthSince;
    String uid = await Provider.of(context).auth.getCurrentUID();
    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((doc) {
      DateTime dob = DateTime.parse(doc.data['dob'].toDate().toString());
      DateTime toDate = DateTime.now();
      int dateDifference = toDate.difference(dob).inDays;
      if ((dateDifference / 30.4375) >= 0 && (dateDifference / 30.4375) < 4) {
        monthSince = 2;
      } else if ((dateDifference / 30.4375) >= 4 &&
          (dateDifference / 30.4375) < 6) {
        monthSince = 4;
      } else if ((dateDifference / 30.4375) >= 6 &&
          (dateDifference / 30.4375) < 9) {
        monthSince = 6;
      } else if ((dateDifference / 30.4375) >= 9 &&
          (dateDifference / 30.4375) < 12) {
        monthSince = 9;
      } else if ((dateDifference / 30.4375) >= 12 &&
          (dateDifference / 30.4375) < 18) {
        monthSince = 12;
      } else if ((dateDifference / 30.4375) >= 18 &&
          (dateDifference / 30.4375) < 24) {
        monthSince = 18;
      } else if ((dateDifference / 30.4375) >= 24 &&
          (dateDifference / 30.4375) < 36) {
        monthSince = 24;
      } else if ((dateDifference / 30.4375) >= 36 &&
          (dateDifference / 30.4375) < 48) {
        monthSince = 36;
      } else if ((dateDifference / 30.4375) >= 48 &&
          (dateDifference / 30.4375) < 60) {
        monthSince = 48;
      } else {
        monthSince = 60;
      }
      setState(() {
        monthNum = monthSince.toString();
        initMonth = monthSince;
      });
    });
  }

  List<String> monthsList = [
    "2",
    "4",
    "6",
    "9",
    "12",
    "18",
    "24",
    "36",
    "48",
    "60"
  ];

  Map<String, dynamic> delaysList = {
    "2": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t respond to loud sounds"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t watch things as they move"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t smile at people"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t bring hands to mouth"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t hold head up when pushing up when on tummy"
      },
    ],
    "4": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t watch things as they move"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t smile at people"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t hold head steady"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t coo or make sounds"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t bring things to mouth"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays":
            "Doesn\'t push down with legs when feet are placed on a hard surface"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Has trouble moving one or both eyes in all directions"
      },
    ],
    "6": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t try to get things that are in reach"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Shows no affection for caregivers"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t respond to sounds around him"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Has difficulty getting things to mouth"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t make vowel sounds (\"ah\", \"eh\", \"oh\")"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t roll over in either direction"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t laugh or make squealing sounds"
      },
      {
        "id": "8",
        "category": "Signs of possible developmental delay",
        "delays": "Seems very stiff, with tight muscles"
      },
      {
        "id": "9",
        "category": "Signs of possible developmental delay",
        "delays": "Seems very floppy, like a rag doll"
      },
    ],
    "9": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t bear weight on legs with support"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t sit with help"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t babble (\"mama\", \"baba\", \"dada\")"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t play any games involving back-and-forth play"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t respond to own name"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t seem to recognize familiar people"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t look where you point"
      },
      {
        "id": "8",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t transfer toys from one hand to the other"
      },
    ],
    "12": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t crawl"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t stand when supported"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t search for things that she sees you hide"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t say single words like \"mama\" or \"dada\""
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t learn gestures like waving or shaking head"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t point to things"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Loses skills he once had"
      },
    ],
    "18": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t point to show things to others"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t walk"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t know what familiar things are for"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t copy others"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t gain new words"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t have at least 6 words"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t notice or mind when a caregiver leaves or returns"
      },
      {
        "id": "8",
        "category": "Signs of possible developmental delay",
        "delays": "Loses skills he once had"
      },
    ],
    "24": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t use 2-word phrases (for example, \"drink milk\")"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays":
            "Doesn\'t know what to do with common things, like a brush, phone, fork, spoon"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t copy actions and words"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t follow simple instructions"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t walk steadily"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Loses skills she once had"
      },
    ],
    "36": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Falls down a lot or has trouble with stairs"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Drools or has very unclear speech"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays":
            "Can\'t work simple toys (such as peg boards, simple puzzles, turning handle)"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t speak in sentences"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t understand simple instructions"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t play pretend or make-believe"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t want to play with other children or with toys"
      },
      {
        "id": "8",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t make eye contact"
      },
      {
        "id": "9",
        "category": "Signs of possible developmental delay",
        "delays": "Loses skills he once had"
      },
    ],
    "48": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t jump in place"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays": "Has trouble scribbling"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Shows no interest in interactive games or make-believe"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays":
            "Ignores other children or doesn\'t respond to people outside the family"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Resists dressing, sleeping, and using the toilet"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t retell a favorite story"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t follow 3-part commands"
      },
      {
        "id": "8",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t understand \"same\" and \"different\""
      },
      {
        "id": "9",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t use \"me\" and \"you\" correctly"
      },
      {
        "id": "10",
        "category": "Signs of possible developmental delay",
        "delays": "Speaks unclearly"
      },
      {
        "id": "11",
        "category": "Signs of possible developmental delay",
        "delays": "Loses skills he once had"
      },
    ],
    "60": [
      {
        "id": "1",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t show a wide range of emotions"
      },
      {
        "id": "2",
        "category": "Signs of possible developmental delay",
        "delays":
            "Shows extreme behavior (unusually fearful, aggressive, shy or sad)"
      },
      {
        "id": "3",
        "category": "Signs of possible developmental delay",
        "delays": "Unusually withdrawn and not active"
      },
      {
        "id": "4",
        "category": "Signs of possible developmental delay",
        "delays":
            "Is easily distracted, has trouble focusing on one activity for more than 5 minutes"
      },
      {
        "id": "5",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t respond to people, or responds only superficially"
      },
      {
        "id": "6",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t tell what\'s real and what\'s make-believe"
      },
      {
        "id": "7",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t play a variety of games and activities"
      },
      {
        "id": "8",
        "category": "Signs of possible developmental delay",
        "delays": "Can\'t give first and last name"
      },
      {
        "id": "9",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t use plurals or past tense properly"
      },
      {
        "id": "10",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t talk about daily activities or experiences"
      },
      {
        "id": "11",
        "category": "Signs of possible developmental delay",
        "delays": "Doesn\'t draw pictures"
      },
      {
        "id": "12",
        "category": "Signs of possible developmental delay",
        "delays":
            "Can\'t brush teeth, wash and dry hands, or get undressed without help"
      },
      {
        "id": "13",
        "category": "Signs of possible developmental delay",
        "delays": "Loses skills he once had"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).auth.getUserBabySummaryStreamSnapshots(),
      builder: (context, summarySnapshot) {
        if (!summarySnapshot.hasData) {
          circularProgress();
        }

        if (monthNum == null) return circularProgress();
        return StreamBuilder<DocumentSnapshot>(
          stream: getUserdelaysStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            selectedCount = 0;
            return Container(
              color: Colors.red[50],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        AutoSizeText(
                          "Signs of possible developmental delay",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700]),
                          maxLines: 1,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: AutoSizeText(
                              "Materials developed by CDC",
                              style: TextStyle(
                                  fontSize: 8.0, color: Colors.blueGrey[600]),
                              maxLines: 1,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: monthsList.length,
                        itemBuilder: (context, index) {
                          String buttonText;
                          if (int.parse(monthsList[index]) % 12 == 0) {
                            buttonText =
                                '${(int.parse(monthsList[index]) / 12).toStringAsFixed(0)} yr.';
                          } else {
                            buttonText = '${monthsList[index]} mo.';
                          }
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    monthNum = monthsList[index].toString();
                                  });
                                },
                                color: monthNum == monthsList[index]
                                    ? Colors.red
                                    : initMonth < int.parse(monthsList[index])
                                        ? Colors.grey
                                        : Colors.red[200],
                                child: Center(
                                  child: AutoSizeText(
                                    buttonText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          delaysHeading("Signs of possible developmental delay",
                              Colors.red),
                          getdelaysCards(
                              snapshot,
                              monthNum,
                              "Signs of possible developmental delay",
                              Colors.red),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget delaysHeading(String headText, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      child: Card(
        color: color,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
            child: Center(
              child: AutoSizeText(
                headText,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getdelaysCards(snapshot, monthNum, category, cardColor) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: delaysList[monthNum].length,
      itemBuilder: (BuildContext context, int index) {
        String delaysNum = delaysList[monthNum][index]["id"];
        return delaysList[monthNum][index]["category"] != category
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Material(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AutoSizeText(
                                  delaysList[monthNum][index]["id"],
                                  style: TextStyle(
                                      color: int.parse(monthNum) <= initMonth
                                          ? cardColor
                                          : Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: AutoSizeText(
                                delaysList[monthNum][index]["delays"],
                                style: TextStyle(
                                    color: int.parse(monthNum) <= initMonth
                                        ? cardColor
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: int.parse(monthNum) <= initMonth
                                  ? IconButton(
                                      icon: Icon(snapshot.data[monthNum]
                                              [delaysNum]
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
                                      iconSize: 40,
                                      color: cardColor,
                                      onPressed: () async {
                                        snapshot.data[monthNum]
                                              [delaysNum] ?null : showAlertDialog(context);
                                        final uid = await Provider.of(context)
                                            .auth
                                            .getCurrentUID();

                                        await Firestore.instance
                                            .collection("delays")
                                            .document(uid)
                                            .setData({
                                          monthNum: {
                                            delaysNum: snapshot.data[monthNum]
                                                    [delaysNum]
                                                ? false
                                                : true
                                          }
                                        }, merge: true);
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.check_box_outline_blank),
                                      iconSize: 40,
                                      color: Colors.grey,
                                      onPressed: () async {},
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.new_releases,
              size: 100.0,
              color: Colors.red,
            ),
          ),
          Text("Act Early")
        ],
      ),
      titleTextStyle: TextStyle(
          color: Colors.red, fontSize: 35.0, fontWeight: FontWeight.bold),
      content: Text(
          "Tell your child’s doctor or nurse if you notice any of these signs of possible developmental delay for this age, and talk with someone in your community who is familiar with services for young children in your area."),
      contentTextStyle:
          TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Stream<DocumentSnapshot> getUserdelaysStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('delays').document(uid).snapshots();
  }
}
