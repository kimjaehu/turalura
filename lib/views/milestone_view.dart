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
        "milestone": "Smiles spontaneously, especially at people"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone":
            "Likes to play with people and might cry when playing stops"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone":
            "Copies some movements and facial expressions, like smiling or frowning"
      },
      {
        "id": "4",
        "category": "Language/Communication",
        "milestone": "Begins to babble"
      },
      {
        "id": "5",
        "category": "Language/Communication",
        "milestone": "Babbles with expression and copies sounds he hears"
      },
      {
        "id": "6",
        "category": "Language/Communication",
        "milestone":
            "Cries in different ways to show hunger, pain, or being tired"
      },
      {
        "id": "7",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Lets you know if she is happy or sad"
      },
      {
        "id": "8",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Responds to affection"
      },
      {
        "id": "9",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Reaches for toy with one hand"
      },
      {
        "id": "10",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Uses hands and eyes together, such as seeing a toy and reaching for it"
      },
      {
        "id": "11",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Follows moving things with eyes from side to side"
      },
      {
        "id": "12",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Watches faces closely"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Recognizes familiar people and things at a distance"
      },
      {
        "id": "14",
        "category": "Movement/Physical Development",
        "milestone": "Holds head steady, unsupported"
      },
      {
        "id": "15",
        "category": "Movement/Physical Development",
        "milestone": "Pushes down on legs when feet are on a hard surface"
      },
      {
        "id": "16",
        "category": "Movement/Physical Development",
        "milestone": "May be able to roll over from tummy to back"
      },
      {
        "id": "17",
        "category": "Movement/Physical Development",
        "milestone": "Can hold a toy and shake it and swing at dangling toys"
      },
      {
        "id": "18",
        "category": "Movement/Physical Development",
        "milestone": "Brings hands to mouth"
      },
      {
        "id": "19",
        "category": "Movement/Physical Development",
        "milestone": "When lying on stomach, pushes up to elbows"
      },
    ],
    "6": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone":
            "Knows familiar faces and begins to know if someone is a stranger"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "Likes to play with others, especially parents"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Responds to other people’s emotions and often seems happy"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone": "Likes to look at self in a mirror"
      },
      {
        "id": "5",
        "category": "Language/Communication",
        "milestone": "Responds to sounds by making sounds"
      },
      {
        "id": "6",
        "category": "Language/Communication",
        "milestone":
            "Strings vowels together when babbling (“ah,” “eh,” “oh”) and likes taking turns with parent while making sounds"
      },
      {
        "id": "7",
        "category": "Language/Communication",
        "milestone": "Responds to own name"
      },
      {
        "id": "8",
        "category": "Language/Communication",
        "milestone": "Makes sounds to show joy and displeasure"
      },
      {
        "id": "9",
        "category": "Language/Communication",
        "milestone": "Begins to say consonant sounds (jabbering with “m,” “b”)"
      },
      {
        "id": "10",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Looks around at things nearby"
      },
      {
        "id": "11",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Brings things to mouth"
      },
      {
        "id": "12",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Shows curiosity about things and tries to get things that are out of reach"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Begins to pass things from one hand to the other"
      },
      {
        "id": "14",
        "category": "Movement/Physical Development",
        "milestone":
            "Rolls over in both directions (front to back, back to front)"
      },
      {
        "id": "15",
        "category": "Movement/Physical Development",
        "milestone": "Begins to sit without support"
      },
      {
        "id": "16",
        "category": "Movement/Physical Development",
        "milestone": "When standing, supports weight on legs and might bounce"
      },
      {
        "id": "17",
        "category": "Movement/Physical Development",
        "milestone":
            "Rocks back and forth, sometimes crawling backward before moving forward"
      },
    ],
    "9": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "May be afraid of strangers"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "May be clingy with familiar adults"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Has favorite toys"
      },
      {
        "id": "4",
        "category": "Language/Communication",
        "milestone": "Understands \"no\""
      },
      {
        "id": "5",
        "category": "Language/Communication",
        "milestone":
            "Makes a lot of different sounds like \"mamamama\" and \"bababababa\""
      },
      {
        "id": "6",
        "category": "Language/Communication",
        "milestone": "Copies sounds and gestures of others"
      },
      {
        "id": "7",
        "category": "Language/Communication",
        "milestone": "Uses fingers to point at things"
      },
      {
        "id": "8",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Watches the path of something as it falls"
      },
      {
        "id": "9",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Looks for things he sees you hide"
      },
      {
        "id": "10",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Plays peek-a-boo"
      },
      {
        "id": "11",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Puts things in her mouth"
      },
      {
        "id": "12",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Moves things smoothly from one hand to the other"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Picks up things like cereal o’s between thumb and index finger"
      },
      {
        "id": "14",
        "category": "Movement/Physical Development",
        "milestone": "Stands, holding on"
      },
      {
        "id": "15",
        "category": "Movement/Physical Development",
        "milestone": "Can get into sitting position"
      },
      {
        "id": "16",
        "category": "Movement/Physical Development",
        "milestone": "Sits without support"
      },
      {
        "id": "17",
        "category": "Movement/Physical Development",
        "milestone": "Pulls to stand"
      },
      {
        "id": "18",
        "category": "Movement/Physical Development",
        "milestone": "Crawls"
      },
    ],
    "12": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "Is shy or nervous with strangers"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "Cries when mom or dad leaves"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Has favorite things and people"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone": "Shows fear in some situations"
      },
      {
        "id": "5",
        "category": "Social/Emotional",
        "milestone": "Hands you a book when he wants to hear a story"
      },
      {
        "id": "6",
        "category": "Social/Emotional",
        "milestone": "Repeats sounds or actions to get attention"
      },
      {
        "id": "7",
        "category": "Social/Emotional",
        "milestone": "Puts out arm or leg to help with dressing"
      },
      {
        "id": "8",
        "category": "Social/Emotional",
        "milestone": "Plays games such as \"peek-a-boo\" and \"pat-a-cake\""
      },
      {
        "id": "9",
        "category": "Language/Communication",
        "milestone": "Responds to simple spoken requests"
      },
      {
        "id": "10",
        "category": "Language/Communication",
        "milestone":
            "Uses simple gestures, like shaking head \"no\" or waving \"bye-bye\""
      },
      {
        "id": "11",
        "category": "Language/Communication",
        "milestone":
            "Makes sounds with changes in tone (sounds more like speech)"
      },
      {
        "id": "12",
        "category": "Language/Communication",
        "milestone":
            "Says \"mama\" and \"dada\" and exclamations like \"uh-oh!\""
      },
      {
        "id": "13",
        "category": "Language/Communication",
        "milestone": "Tries to say words you say"
      },
      {
        "id": "14",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Explores things in different ways, like shaking, banging, throwing"
      },
      {
        "id": "15",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Finds hidden things easily"
      },
      {
        "id": "16",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Looks at the right picture or thing when it’s named"
      },
      {
        "id": "17",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Copies gestures"
      },
      {
        "id": "18",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Starts to use things correctly; for example, drinks from a cup, brushes hair"
      },
      {
        "id": "19",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Bangs two things together"
      },
      {
        "id": "20",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Puts things in a container, takes things out of a container"
      },
      {
        "id": "21",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Lets things go without help"
      },
      {
        "id": "22",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Pokes with index (pointer) finger"
      },
      {
        "id": "23",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Follows simple directions like \"pick up the toy\""
      },
      {
        "id": "24",
        "category": "Movement/Physical Development",
        "milestone": "Gets to a sitting position without help"
      },
      {
        "id": "25",
        "category": "Movement/Physical Development",
        "milestone":
            "Pulls up to stand, walks holding on to furniture (\"cruising\")"
      },
      {
        "id": "26",
        "category": "Movement/Physical Development",
        "milestone": "May take a few steps without holding on"
      },
      {
        "id": "27",
        "category": "Movement/Physical Development",
        "milestone": "May stand alone"
      },
    ],
    
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
                                print(monthsList[index].toString());
                                setState(() {
                                  monthNum = monthsList[index].toString();
                                });
                              },
                              color: Colors.pink,
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
