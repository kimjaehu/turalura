import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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

class MilestoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("asdgasdgasg ${milestoneList[2]}");
    return ListView.builder(
      itemCount: milestoneList[2].length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            color: Colors.brown[300],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(milestoneList[2][index]["id"],style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),maxLines: 2,),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(milestoneList[2][index]["milestone"],style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),maxLines: 2,),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_box_outline_blank,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
