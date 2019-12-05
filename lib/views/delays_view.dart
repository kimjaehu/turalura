import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class MilestoneView extends StatefulWidget {
  @override
  _MilestoneViewState createState() => _MilestoneViewState();
}

class _MilestoneViewState extends State<MilestoneView> {
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

  Map<String, dynamic> milestoneList = {
    "2": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t respond to loud sounds"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t watch things as they move"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t smile at people"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t bring hands to mouth"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone": "Can’t hold head up when pushing up when on tummy"
      },
    ],
    "4": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t watch things as they move"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t smile at people"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone":
            "Can’t hold head steady"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t coo or make sounds"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t bring things to mouth"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t push down with legs when feet are placed on a hard surface"
      },
      {
        "id": "7",
        "category": "signs of possible developmental delay",
        "milestone": "Has trouble moving one or both eyes in all directions"
      },
    ],
    "6": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t try to get things that are in reach"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone": "Shows no affection for caregivers"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t respond to sounds around him"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Has difficulty getting things to mouth"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t make vowel sounds (\"ah\", \"eh\", \"oh\")"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t roll over in either direction"
      },
      {
        "id": "7",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t laugh or make squealing sounds"
      },
      {
        "id": "8",
        "category": "signs of possible developmental delay",
        "milestone": "Seems very stiff, with tight muscles"
      },
      {
        "id": "9",
        "category": "signs of possible developmental delay",
        "milestone": "Seems very floppy, like a rag doll"
      },
    ],
    "9": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t bear weight on legs with support"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t sit with help"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t babble (\"mama\", \"baba\", \"dada\")"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t play any games involving back-and-forth play"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t respond to own name"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t seem to recognize familiar people"
      },
      {
        "id": "7",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t look where you point"
      },
      {
        "id": "8",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t transfer toys from one hand to the other"
      },
    ],
    "12": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t crawl"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone": "Can’t stand when supported"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t search for things that she sees you hide"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t say single words like \"mama\" or \"dada\""
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t learn gestures like waving or shaking head"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t point to things"
      },
      {
        "id": "7",
        "category": "signs of possible developmental delay",
        "milestone": "Loses skills he once had"
      },
    ],
    "18": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t point to show things to others"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone": "Can’t walk"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t know what familiar things are for"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t copy others"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t gain new words"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t have at least 6 words"
      },
      {
        "id": "7",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t notice or mind when a caregiver leaves or returns"
      },
      {
        "id": "8",
        "category": "signs of possible developmental delay",
        "milestone": "Loses skills he once had"
      },
    ],
    "24": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t use 2-word phrases (for example, \"drink milk\")"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t know what to do with common things, like a brush, phone, fork, spoon"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t copy actions and words"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t follow simple instructions"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone":
            "Doesn’t walk steadily"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone": "Loses skills she once had"
      },
    ],
    "36": [
      {
        "id": "1",
        "category": "signs of possible developmental delay",
        "milestone": "Falls down a lot or has trouble with stairs"
      },
      {
        "id": "2",
        "category": "signs of possible developmental delay",
        "milestone": "Drools or has very unclear speech"
      },
      {
        "id": "3",
        "category": "signs of possible developmental delay",
        "milestone": "Can’t work simple toys (such as peg boards, simple puzzles, turning handle)"
      },
      {
        "id": "4",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t speak in sentences"
      },
      {
        "id": "5",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t understand simple instructions"
      },
      {
        "id": "6",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t play pretend or make-believe"
      },
      {
        "id": "7",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t want to play with other children or with toys"
      },
      {
        "id": "8",
        "category": "signs of possible developmental delay",
        "milestone": "Doesn’t make eye contact"
      },
      {
        "id": "9",
        "category": "signs of possible developmental delay",
        "milestone": "Loses skills he once had"
      },
    ],
    "48": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "Enjoys doing new things"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "Plays \"Mom\" and \"Dad\""
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Is more and more creative with make-believe play"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone": "Would rather play with other children than by himself"
      },
      {
        "id": "5",
        "category": "Social/Emotional",
        "milestone": "Cooperates with other children"
      },
      {
        "id": "6",
        "category": "Social/Emotional",
        "milestone": "Often can’t tell what’s real and what’s make-believe"
      },
      {
        "id": "7",
        "category": "Social/Emotional",
        "milestone": "Talks about what she likes and what she is interested in"
      },
      {
        "id": "8",
        "category": "Language/Communication",
        "milestone":
            "Knows some basic rules of grammar, such as correctly using \"he\" and \"she\""
      },
      {
        "id": "9",
        "category": "Language/Communication",
        "milestone":
            "Sings a song or says a poem from memory such as the \"Itsy Bitsy Spider\" or the \"Wheels on the Bus\""
      },
      {
        "id": "10",
        "category": "Language/Communication",
        "milestone": "Tells stories"
      },
      {
        "id": "11",
        "category": "Language/Communication",
        "milestone": "Can say first and last name"
      },
      {
        "id": "12",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Names some colors and some numbers"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Understands the idea of counting"
      },
      {
        "id": "14",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Starts to understand time"
      },
      {
        "id": "15",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Remembers parts of a story"
      },
      {
        "id": "16",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Understands the idea of \"same\" and \"different\""
      },
      {
        "id": "17",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Draws a person with 2 to 4 body parts"
      },
      {
        "id": "18",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Uses scissors"
      },
      {
        "id": "19",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Starts to copy some capital letters"
      },
      {
        "id": "20",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Plays board or card games"
      },
      {
        "id": "21",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Tells you what he thinks is going to happen next in a book"
      },
      {
        "id": "22",
        "category": "Movement/Physical Development",
        "milestone": "Hops and stands on one foot up to 2 seconds"
      },
      {
        "id": "23",
        "category": "Movement/Physical Development",
        "milestone": "Catches a bounced ball most of the time"
      },
      {
        "id": "24",
        "category": "Movement/Physical Development",
        "milestone": "Pours, cuts with supervision, and mashes own food"
      },
    ],
    "60": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "Wants to please friends"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "Wants to be like friends"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "More likely to agree with rules"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone": "Likes to sing, dance, and act"
      },
      {
        "id": "5",
        "category": "Social/Emotional",
        "milestone": "Is aware of gender"
      },
      {
        "id": "6",
        "category": "Social/Emotional",
        "milestone": "Can tell what’s real and what’s make-believe"
      },
      {
        "id": "7",
        "category": "Social/Emotional",
        "milestone":
            "Shows more independence (for example, may visit a next-door neighbor by himself [adult supervision is still needed])"
      },
      {
        "id": "8",
        "category": "Social/Emotional",
        "milestone": "Is sometimes demanding and sometimes very cooperative"
      },
      {
        "id": "9",
        "category": "Language/Communication",
        "milestone": "Speaks very clearly"
      },
      {
        "id": "10",
        "category": "Language/Communication",
        "milestone": "Tells a simple story using full sentences"
      },
      {
        "id": "11",
        "category": "Language/Communication",
        "milestone": "Uses future tense; for example, \"Grandma will be here.\""
      },
      {
        "id": "12",
        "category": "Language/Communication",
        "milestone": "Says name and address"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Counts 10 or more things"
      },
      {
        "id": "14",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Can draw a person with at least 6 body parts"
      },
      {
        "id": "15",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Can print some letters or numbers"
      },
      {
        "id": "16",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Copies a triangle and other geometric shapes"
      },
      {
        "id": "17",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Knows about things used every day, like money and food"
      },
      {
        "id": "18",
        "category": "Movement/Physical Development",
        "milestone": "Stands on one foot for 10 seconds or longer"
      },
      {
        "id": "19",
        "category": "Movement/Physical Development",
        "milestone": "Hops; may be able to skip"
      },
      {
        "id": "20",
        "category": "Movement/Physical Development",
        "milestone": "Can do a somersault"
      },
      {
        "id": "21",
        "category": "Movement/Physical Development",
        "milestone": "Uses a fork and spoon and sometimes a table knife"
      },
      {
        "id": "22",
        "category": "Movement/Physical Development",
        "milestone": "Can use the toilet on her own"
      },
      {
        "id": "23",
        "category": "Movement/Physical Development",
        "milestone": "Swings and climbs"
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
          stream: getUserMilestonesStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            selectedCount = 0;
            return Column(
              children: <Widget>[
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
                                  ? Colors.deepPurple
                                  : initMonth < int.parse(monthsList[index])
                                      ? Colors.grey
                                      : Colors.deepPurple[200],
                              child: Center(
                                child: Text(
                                  buttonText,
                                  style: TextStyle(color: Colors.white),
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
                        milestoneHeading("Social/Emotional", Colors.blue),
                        getMilestoneCards(snapshot, monthNum,
                            "Social/Emotional", Colors.blue),
                        milestoneHeading(
                            "Language/Communication", Colors.green),
                        getMilestoneCards(snapshot, monthNum,
                            "Language/Communication", Colors.green),
                        milestoneHeading(
                            "Cognitive (learning, thinking, problem-solving)",
                            Colors.orange),
                        getMilestoneCards(snapshot, monthNum,
                            "Movement/Physical Development", Colors.indigo),
                        milestoneHeading("Social/Emotional", Colors.blue),
                        getMilestoneCards(snapshot, monthNum,
                            "Movement/Physical Development", Colors.indigo),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget milestoneHeading(String headText, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
      child: Card(
        color: color,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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

  Widget getMilestoneCards(snapshot, monthNum, category, cardColor) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: milestoneList[monthNum].length,
      itemBuilder: (BuildContext context, int index) {
        String milestoneNum = milestoneList[monthNum][index]["id"];
        return milestoneList[monthNum][index]["category"] != category
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.all(8.0),
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
                                  milestoneList[monthNum][index]["id"],
                                  style: TextStyle(
                                      color: cardColor,
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
                                milestoneList[monthNum][index]["milestone"],
                                style: TextStyle(
                                    color: cardColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: snapshot.data[monthNum][milestoneNum]
                                  ? IconButton(
                                      icon: Icon(Icons.check_box),
                                      iconSize: 40,
                                      color: cardColor,
                                      onPressed: () async {
                                        final uid = await Provider.of(context)
                                            .auth
                                            .getCurrentUID();

                                        await Firestore.instance
                                            .collection("milestones")
                                            .document(uid)
                                            .setData({
                                          monthNum: {
                                            milestoneNum:
                                                snapshot.data[monthNum]
                                                        [milestoneNum]
                                                    ? false
                                                    : true
                                          }
                                        }, merge: true);
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.check_box_outline_blank),
                                      iconSize: 40,
                                      color: cardColor,
                                      onPressed: () async {
                                        final uid = await Provider.of(context)
                                            .auth
                                            .getCurrentUID();

                                        await Firestore.instance
                                            .collection("milestones")
                                            .document(uid)
                                            .setData({
                                          monthNum: {
                                            milestoneNum:
                                                snapshot.data[monthNum]
                                                        [milestoneNum]
                                                    ? false
                                                    : true
                                          }
                                        }, merge: true);
                                      },
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

  Stream<DocumentSnapshot> getUserMilestonesStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('milestones')
        .document(uid)
        .snapshots();
  }
}
