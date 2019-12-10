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
            "Begins to act bored (cries, fussy) if activity doesn\'t change"
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
        "milestone":
            "Responds to other people\'s emotions and often seems happy"
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
            "Picks up things like cereal o\'s between thumb and index finger"
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
        "milestone": "Looks at the right picture or thing when it\'s named"
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
    "18": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "Likes to hand things to others as play"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "May have temper tantrums"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "May be afraid of strangers"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone": "Shows affection to familiar people"
      },
      {
        "id": "5",
        "category": "Social/Emotional",
        "milestone": "Plays simple pretend, such as feeding a doll"
      },
      {
        "id": "6",
        "category": "Social/Emotional",
        "milestone": "May cling to caregivers in new situations"
      },
      {
        "id": "7",
        "category": "Social/Emotional",
        "milestone": "Points to show others something interesting"
      },
      {
        "id": "8",
        "category": "Social/Emotional",
        "milestone": "Explores alone but with parent close by"
      },
      {
        "id": "9",
        "category": "Language/Communication",
        "milestone": "Says several single words"
      },
      {
        "id": "10",
        "category": "Language/Communication",
        "milestone": "Says and shakes head \"no\""
      },
      {
        "id": "11",
        "category": "Language/Communication",
        "milestone": "Points to show someone what he wants"
      },
      {
        "id": "12",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Knows what ordinary things are for; for example, telephone, brush, spoon"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Points to get the attention of others"
      },
      {
        "id": "14",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Shows interest in a doll or stuffed animal by pretending to feed"
      },
      {
        "id": "15",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Points to one body part"
      },
      {
        "id": "16",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Scribbles on his own"
      },
      {
        "id": "17",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Can follow 1-step verbal commands without any gestures; for example, sits when you say \"sit down\""
      },
      {
        "id": "18",
        "category": "Movement/Physical Development",
        "milestone": "Walks alone"
      },
      {
        "id": "19",
        "category": "Movement/Physical Development",
        "milestone": "May walk up steps and run"
      },
      {
        "id": "20",
        "category": "Movement/Physical Development",
        "milestone": "Pulls toys while walking"
      },
      {
        "id": "21",
        "category": "Movement/Physical Development",
        "milestone": "Can help undress herself"
      },
      {
        "id": "22",
        "category": "Movement/Physical Development",
        "milestone": "Drinks from a cup"
      },
      {
        "id": "23",
        "category": "Movement/Physical Development",
        "milestone": "Eats with a spoon"
      },
    ],
    "24": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "Copies others, especially adults and older children"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "Gets excited when with other children"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Shows more and more independence"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone":
            "Shows defiant behavior (doing what he has been told not to)"
      },
      {
        "id": "5",
        "category": "Social/Emotional",
        "milestone":
            "Plays mainly beside other children, but is beginning to include other children, such as in chase games"
      },
      {
        "id": "6",
        "category": "Language/Communication",
        "milestone": "Points to things or pictures when they are named"
      },
      {
        "id": "7",
        "category": "Language/Communication",
        "milestone": "Knows names of familiar people and body parts"
      },
      {
        "id": "8",
        "category": "Language/Communication",
        "milestone": "Says sentences with 2 to 4 words"
      },
      {
        "id": "9",
        "category": "Language/Communication",
        "milestone": "Follows simple instructions"
      },
      {
        "id": "10",
        "category": "Language/Communication",
        "milestone": "Repeats words overheard in conversation"
      },
      {
        "id": "11",
        "category": "Language/Communication",
        "milestone": "Points to things in a book"
      },
      {
        "id": "12",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Finds things even when hidden under two or three covers"
      },
      {
        "id": "13",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Begins to sort shapes and colors"
      },
      {
        "id": "14",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Completes sentences and rhymes in familiar books"
      },
      {
        "id": "15",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Plays simple make-believe games"
      },
      {
        "id": "16",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Builds towers of 4 or more blocks"
      },
      {
        "id": "17",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Might use one hand more than the other"
      },
      {
        "id": "18",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone":
            "Follows two-step instructions such as \"Pick up your shoes and put them in the closet.\""
      },
      {
        "id": "19",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Names items in a picture book such as a cat, bird, or dog"
      },
      {
        "id": "20",
        "category": "Movement/Physical Development",
        "milestone": "Stands on tiptoe"
      },
      {
        "id": "21",
        "category": "Movement/Physical Development",
        "milestone": "Kicks a ball"
      },
      {
        "id": "22",
        "category": "Movement/Physical Development",
        "milestone": "Begins to run"
      },
      {
        "id": "23",
        "category": "Movement/Physical Development",
        "milestone": "Climbs onto and down from furniture without help"
      },
      {
        "id": "24",
        "category": "Movement/Physical Development",
        "milestone": "Walks up and down stairs holding on"
      },
      {
        "id": "25",
        "category": "Movement/Physical Development",
        "milestone": "Throws ball overhand"
      },
      {
        "id": "26",
        "category": "Movement/Physical Development",
        "milestone": "Makes or copies straight lines and circles"
      },
    ],
    "36": [
      {
        "id": "1",
        "category": "Social/Emotional",
        "milestone": "Copies adults and friends"
      },
      {
        "id": "2",
        "category": "Social/Emotional",
        "milestone": "Shows affection for friends without prompting"
      },
      {
        "id": "3",
        "category": "Social/Emotional",
        "milestone": "Takes turns in games"
      },
      {
        "id": "4",
        "category": "Social/Emotional",
        "milestone": "Shows concern for a crying friend"
      },
      {
        "id": "5",
        "category": "Social/Emotional",
        "milestone": "Understands the idea of \"mine\" and \"his\" or \"hers\""
      },
      {
        "id": "6",
        "category": "Social/Emotional",
        "milestone": "Shows a wide range of emotions"
      },
      {
        "id": "7",
        "category": "Social/Emotional",
        "milestone": "Separates easily from mom and dad"
      },
      {
        "id": "8",
        "category": "Social/Emotional",
        "milestone": "May get upset with major changes in routine"
      },
      {
        "id": "9",
        "category": "Social/Emotional",
        "milestone": "Dresses and undresses self"
      },
      {
        "id": "10",
        "category": "Language/Communication",
        "milestone": "Follows instructions with 2 or 3 steps"
      },
      {
        "id": "11",
        "category": "Language/Communication",
        "milestone": "Can name most familiar things"
      },
      {
        "id": "12",
        "category": "Language/Communication",
        "milestone": "Understands words like \"in\", \"on\", and \"under\""
      },
      {
        "id": "13",
        "category": "Language/Communication",
        "milestone": "Says first name, age, and sex"
      },
      {
        "id": "14",
        "category": "Language/Communication",
        "milestone": "Names a friend"
      },
      {
        "id": "15",
        "category": "Language/Communication",
        "milestone":
            "Says words like \"I\", \"me\", \"we\", and \"you\" and some plurals (cars, dogs, cats)"
      },
      {
        "id": "16",
        "category": "Language/Communication",
        "milestone":
            "Talks well enough for strangers to understand most of the time"
      },
      {
        "id": "17",
        "category": "Language/Communication",
        "milestone": "Carries on a conversation using 2 to 3 sentences"
      },
      {
        "id": "18",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Can work toys with buttons, levers, and moving parts"
      },
      {
        "id": "19",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Plays make-believe with dolls, animals, and people"
      },
      {
        "id": "20",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Does puzzles with 3 or 4 pieces"
      },
      {
        "id": "21",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Understands what “two” means"
      },
      {
        "id": "22",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Copies a circle with pencil or crayon"
      },
      {
        "id": "23",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Turns book pages one at a time"
      },
      {
        "id": "24",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Builds towers of more than 6 blocks"
      },
      {
        "id": "25",
        "category": "Cognitive (learning, thinking, problem-solving)",
        "milestone": "Screws and unscrews jar lids or turns door handle"
      },
      {
        "id": "26",
        "category": "Movement/Physical Development",
        "milestone": "Climbs well"
      },
      {
        "id": "27",
        "category": "Movement/Physical Development",
        "milestone": "Runs easily"
      },
      {
        "id": "28",
        "category": "Movement/Physical Development",
        "milestone": "Pedals a tricycle (3-wheel bike)"
      },
      {
        "id": "29",
        "category": "Movement/Physical Development",
        "milestone": "Walks up and down stairs, one foot on each step"
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
        "milestone": "Often can\'t tell what\'s real and what\'s make-believe"
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
        "milestone": "Can tell what\'s real and what\'s make-believe"
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
            if (summarySnapshot.data["name"] == null) {
              circularProgress();
            }
            String currentBaby =
                summarySnapshot.data["name"].toString().toLowerCase();
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
                        milestoneHeading("Social/Emotional", Colors.blue),
                        getMilestoneCards(snapshot, monthNum,
                            "Social/Emotional", Colors.blue, currentBaby),
                        milestoneHeading(
                            "Language/Communication", Colors.green),
                        getMilestoneCards(
                            snapshot,
                            monthNum,
                            "Language/Communication",
                            Colors.green,
                            currentBaby),
                        milestoneHeading(
                            "Cognitive (learning, thinking, problem-solving)",
                            Colors.orange),
                        getMilestoneCards(
                            snapshot,
                            monthNum,
                            "Cognitive (learning, thinking, problem-solving)",
                            Colors.indigo,
                            currentBaby),
                        milestoneHeading(
                            "Movement/Physical Development", Colors.blue),
                        getMilestoneCards(
                            snapshot,
                            monthNum,
                            "Movement/Physical Development",
                            Colors.indigo,
                            currentBaby),
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
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
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

  Widget getMilestoneCards(
      snapshot, monthNum, category, cardColor, currentBaby) {
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
                                milestoneList[monthNum][index]["milestone"],
                                style: TextStyle(
                                    color: int.parse(monthNum) <= initMonth
                                        ? cardColor
                                        : Colors.grey,
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
                              child: int.parse(monthNum) <= initMonth
                                  ? IconButton(
                                      icon: Icon(snapshot.data[monthNum]
                                              [milestoneNum]
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
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
                                        int milestonesCount;
                                        int selectedMilestones = 0;
                                        await Firestore.instance
                                            .collection("milestones")
                                            .document(uid)
                                            .get()
                                            .then((doc) => {
                                                  milestonesCount =
                                                      doc.data[monthNum].length,
                                                  doc.data[monthNum].forEach(
                                                      (index, milestone) => {
                                                            milestone
                                                                ? selectedMilestones++
                                                                : null
                                                          })
                                                });

                                        await Firestore.instance
                                            .collection("summaries")
                                            .document(uid)
                                            .collection(currentBaby)
                                            .document("summary")
                                            .updateData({
                                          'monthNum': monthNum,
                                          'milestonesCompleted':
                                              selectedMilestones,
                                          'milestonesCount': milestonesCount,
                                        });
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

  Stream<DocumentSnapshot> getUserMilestonesStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('milestones')
        .document(uid)
        .snapshots();
  }
}
