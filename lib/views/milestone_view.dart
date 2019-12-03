import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

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
      "milestone": "Can hold head up and begins to push up when lying on tummy"
    },
    {
      "id": "10",
      "category": "Movement/Physical Development",
      "milestone": "Makes smoother movements with arms and legs"
    },
  ],
};

Map<int, bool> milestoneChecked = {
  1: true,
  2: true,
  3: true,
  4: false,
  5: false,
  6: true,
  7: false,
  8: true,
  9: true,
  10: true,
};

class MilestoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int monthNum = 2;
    return StreamBuilder<DocumentSnapshot>(
        stream: getUserMilestonesStreamSnapshots(context, monthNum),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          return ListView.builder(
            itemCount: milestoneList[monthNum.toString()].length,
            itemBuilder: (BuildContext context, int index) {
              int milestoneNum =
                  int.parse(milestoneList[monthNum.toString()][index]["id"]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () async {
                      final uid =
                          await Provider.of(context).auth.getCurrentUID();

                      Firestore.instance
                          .collection("milestones")
                          .document(uid)
                          .collection("userMilestones")
                          .document(monthNum.toString())
                          .updateData(snapshot.data[milestoneNum.toString()]
                              ? {milestoneNum.toString(): false}
                              : {milestoneNum.toString(): true});
                      Firestore.instance
                      .collection("summaries")
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
                                  milestoneList[monthNum.toString()][index]
                                      ["id"],
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
                                milestoneList[monthNum.toString()][index]
                                    ["milestone"],
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
                              child: snapshot.data[milestoneNum.toString()]
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
        });
  }

  Stream<DocumentSnapshot> getUserMilestonesStreamSnapshots(
      BuildContext context, monthNum) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('milestones')
        .document(uid)
        .collection("userMilestones")
        .document(monthNum.toString())
        .snapshots();
  }
}
