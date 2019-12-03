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

  @override
  void initState() {
    super.initState();
    // initial month based on the days since birth
    monthNum = 2.toString();
    selectedCount = 0;
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
        "category": "Social/Emotional",
        "milestone": "Begins to smile at people"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone":
            "Can briefly calm himself\n(may bring hands to mouth and suck on hand)"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Tries to look at parent"
      },
      {
        "id": "4",
        "category": "Language/Communication",
        "milestone": "Coos, makes gurgling sounds"
      },
      {
        "id": "5",
        "category": "Language/Communication",
        "milestone": "Turns head toward sounds"
      },
      {
        "id": "6",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Pays attention to faces"
      },
      {
        "id": "7",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Begins to follow things with eyes and recognize people at a distance"
      },
      {
        "id": "8",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Begins to act bored (cries, fussy) if activity doesn’t change"
      },
      {
        "id": "9",
        "category": "Movement/Physical Development",
        "milestone":
            "Can hold head up and begins to push up when lying on tummy"
      },
      {
        "id": "10",
        "category": "Movement/Physical Development",
        "milestone": "Makes smoother movements with arms and legs"
      },
    ],
    "4": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "example example"
      }
    ]





  };

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).auth.getUserBabySummaryStreamSnapshots(),
      builder: (context, summarySnapshot) {
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
                        if (int.parse(monthsList[index]) % 12 == 0){
                          buttonText = '${(int.parse(monthsList[index]) / 12).toStringAsFixed(0)} yr.';
                        } else {
                          buttonText = '${monthsList[index]} mo.';
                        }
                        return Container(
                          
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RaisedButton(
                              onPressed: () {
                                print(monthsList[index].toString());
                                setState(() {
                                  monthNum = monthsList[index].toString();
                                });
                              },
                              color: Colors.pink,
                              child: Center(
                                child: Text(buttonText, style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: getMilestoneCards(snapshot, monthNum),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget getMilestoneCards(snapshot, monthNum) {
    return ListView.builder(
      itemCount: milestoneList[monthNum].length,
      itemBuilder: (BuildContext context, int index) {
        String milestoneNum = milestoneList[monthNum][index]["id"];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            child: InkWell(
              onTap: () async {
                final uid = await Provider.of(context).auth.getCurrentUID();

                await Firestore.instance
                    .collection("milestones")
                    .document(uid)
                    .setData({
                  monthNum: {
                    milestoneNum:
                        snapshot.data[monthNum][milestoneNum] ? false : true
                  }
                }, merge: true);
                // snapshot.data[monthNum][milestoneNum]
                //   ? {milestoneNum: false}
                //   : {milestoneNum: true}
                //   );
              },
              child: Card(
                color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            milestoneList[monthNum][index]["id"],
                            style: TextStyle(
                                color: Colors.white,
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
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          milestoneList[monthNum][index]["milestone"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: snapshot.data[monthNum][milestoneNum]
                            ? Icon(
                                Icons.check_box,
                                size: 40,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 40,
                                color: Colors.white,
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
