import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turalura/widgets/progress_indicator.dart';
import 'package:turalura/widgets/provider_widget.dart';

class ActivitiesView extends StatefulWidget {
  @override
  _ActivitiesViewState createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
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

  Map<String, dynamic> activitiesList = {
    "2": [
      "Cuddle, talk, and play with your baby during feeding, dressing, and bathing.",
      "Help your baby learn to calm herself. It\'s okay for her to suck on her fingers.",
      "Begin to help your baby get into a routine, such as sleeping at night more than in the day, and have regular schedules.",
      "Getting in tune with your baby\'s likes and dislikes can help you feel more comfortable and confident.",
      "Act excited and smile when your baby makes sounds.",
      "Copy your baby\'s sounds sometimes, but also use clear language.",
      "Pay attention to your baby\'s different cries so that you learn to know what he wants.",
      "Talk, read, and sing to your baby.",
      "Play peek-a-boo. Help your baby play peek-a-boo, too.",
      "Place a baby-safe mirror in your baby\'s crib so she can look at herself.",
      "Look at pictures with your baby and talk about them.",
      "Lay your baby on his tummy when he is awake and put toys near him.",
      "Encourage your baby to lift his head by holding toys at eye level in front of him.",
      "Hold a toy or rattle above your baby\'s head and encourage her to reach for it.",
      "Hold your baby upright with his feet on the floor. Sing or talk to your baby as he is upright.",
    ],
    "4": [
      "Hold and talk to your baby; smile and be cheerful while you do.",
      "Set steady routines for sleeping and feeding.",
      "Pay close attention to what your baby likes and doesn\'t like; you will know how best to meet his needs and what you can do to make your baby happy.",
      "Copy your baby\'s sounds.",
      "Act excited and smile when your baby makes sounds.",
      "Have quiet play times when you read or sing to your baby.",
      "Give age-appropriate toys to play with, such as rattles or colorful pictures.",
      "Play games such as peek-a-boo.",
      "Provide safe opportunities for your baby to reach for toys and explore his surroundings.",
      "Put toys near your baby so that she can reach for them or kick her feet.",
      "Put toys or rattles in your baby\'s hand and help him to hold them.",
      "Hold your baby upright with feet on the floor, and sing or talk to your baby as she \"stands\" with support."
    ],
    "6": [
      "Play on the floor with your baby every day.",
      "Learn to read your baby\'s moods. If he\'s happy, keep doing what you are doing. If he\'s upset, take a break and comfort your baby.",
      "Show your baby how to comfort herself when she\'s upset. She may suck on her fingers to self soothe.",
      "Use \"reciprocal\" play—when he smiles, you smile; when he makes sounds, you copy them.",
      "Repeat your child\'s sounds and say simple words with those sounds. For example, if your child says \"bah\", say \"bottle\" or \"book\".",
      "Read books to your child every day. Praise her when she babbles and \"reads\" too.",
      "When your baby looks at something, point to it and talk about it.",
      "When he drops a toy on the floor, pick it up and give it back. This game helps him learn cause and effect.",
      "Read colorful picture books to your baby",
      "Point out new things to your baby and name them.",
      "Show your baby bright pictures in a magazine and name them.",
      "Hold your baby up while she sits or support her with pillows. Let her look around and give her toys to look at while she balances.",
      "Put your baby on his tummy or back and put toys just out of reach. Encourage him to roll over to reach the toys."
    ],
    "9": [
      "Put your baby on his tummy or back and put toys just out of reach. Encourage him to roll over to reach the toys.",
      "As she moves around more, stay close so she knows that you are near.",
      "Continue with routines; they are especially important now.",
      "Play games with \"my turn, your turn.\"",
      "Say what you think your baby is feeling. For example, say, \"You are so sad, let\'s see if we can make you feel better.\"",
      "Describe what your baby is looking at; for example, \"red, round ball\"."
          "Talk about what your baby wants when he points at something.",
      "Copy your baby\'s sounds and words.",
      "Ask for behaviors that you want. For example, instead of saying \"don\'t stand\", say \"time to sit\".",
      "Teach cause-and-effect by rolling balls back and forth, pushing toy cars and trucks, and putting blocks in and out of a container",
      "Play peek-a-boo and hide-and-seek.",
      "Read and talk to your baby.",
      "Provide lots of room for your baby to move and explore in a safe area.",
      "Put your baby close to things that she can pull up on safely"
    ],
    "12": [
      "Give your child time to get to know a new caregiver. Bring a favorite toy, stuffed animal, or blanket to help comfort your child.",
      "In response to unwanted behaviors, say \"no\" firmly. Do not yell, spank, or give long explanations. A time out for 30 seconds to 1 minute might help redirect your child.",
      "Give your child lots of hugs, kisses, and praise for good behavior.",
      "Spend a lot more time encouraging wanted behaviors than punishing unwanted behaviors (4 times as much encouragement for wanted behaviors as redirection for unwanted behaviors).",
      "Talk to your child about what you\'re doing. For example, \"Mommy is washing your hands with a washcloth.\"",
      "Read with your child every day. Have your child turn the pages. Take turns labeling pictures with your child.",
      "Build on what your child says or tries to say, or what he points to. If he points to a truck and says \"t\" or \"truck,\" say, \"Yes, that\'s a big, blue truck.\"",
      "Give your child crayons and paper, and let your child draw freely. Show your child how to draw lines up and down and across the page. Praise your child when she tries to copy them.",
      "Play with blocks, shape sorters, and other toys that encourage your child to use his hands.",
      "Hide small toys and other things and have your child find them.",
      "Ask your child to label body parts or things you see while driving in the car",
      "Sing songs with actions, like \"The Itsy Bitsy Spider\" and \"Wheels on the Bus.\" Help your child do the actions with you.",
      "Give your child pots and pans or a small musical instrument like a drum or cymbals. Encourage your child to make noise.",
      "Provide lots of safe places for your toddler to explore. (Toddler-proof your home. Lock away products for cleaning, laundry, lawn care, and car care. Use a safety gate and lock doors to the outside and the basement.)",
      "Give your child push toys like a wagon or \"kiddie push car.\""
    ],
    "18": [
      "Provide a safe, loving environment. It\'s important to be consistent and predictable.",
      "Praise good behaviors more than you punish bad behaviors (use only very brief time outs).",
      "Describe her emotions. For example, say, \"You are happy when we read this book.\"",
      "Encourage pretend play.",
      "Encourage empathy. For example, when he sees a child who is sad, encourage him to hug or pat the other child.",
      "Read books and talk about the pictures using simple words.",
      "Copy your child\'s words.",
      "Use words that describe feelings and emotions.",
      "Use simple, clear phrases.",
      "Ask simple questions.",
      "Hide things under blankets and pillows and encourage him to find them.",
      "Play with blocks, balls, puzzles, books, and toys that teach cause and effect and problem solving.",
      "Name pictures in books and body parts.",
      "Provide toys that encourage pretend play; for example, dolls, play telephones.",
      "Provide safe areas for your child to walk and move around in.",
      "Provide toys that she can push or pull safely.",
      "Provide balls for her to kick, roll, and throw.",
      "Encourage him to drink from his cup and use a spoon, no matter how messy.",
      "Blow bubbles and let your child pop them.",
    ],
    "24": [
      "Encourage your child to help with simple chores at home, like sweeping and making dinner. Praise your child for being a good helper.",
      "At this age, children still play next to (not with) each other and don\'t share well. For play dates, give the children lots of toys to play with. Watch the children closely and step in if they fight or argue.",
      "Give your child attention and praise when he follows instructions. Limit attention for defiant behavior. Spend a lot more time praising good behaviors than punishing bad ones.",
      "Teach your child to identify and say body parts, animals, and other common things.",
      "Do not correct your child when he says words incorrectly. Rather, say it correctly. For example, \"That is a ball.\"",
      "Encourage your child to say a word instead of pointing. If your child can\'t say the whole word (\"milk\"), give her the first sound (\"m\") to help. Over time, you can prompt your child to say the whole sentence — \"I want milk.\"",
      "Hide your child\'s toys around the room and let him find them.",
      "Help your child do puzzles with shapes, colors, or farm animals. Name each piece when your child puts it in place.",
      "Encourage your child to play with blocks. Take turns building towers and knocking them down.",
      "Do art projects with your child using crayons, paint, and paper. Describe what your child makes and hang it on the wall or refrigerator.",
      "Ask your child to help you open doors and drawers and turn pages in a book or magazine.",
      "Once your child walks well, ask her to carry small things for you.",
      "Kick a ball back and forth with your child. When your child is good at that, encourage him to run and kick.",
      "Take your child to the park to run and climb on equipment or walk on nature trails. Watch your child closely",
    ],
    "36": [
      "Go to play groups with your child or other places where there are other children, to encourage getting along with others.",
      "Work with your child to solve the problem when he is upset.",
      "Talk about your child\'s emotions. For example, say, \"I can tell you feel mad because you threw the puzzle piece.\" Encourage your child to identify feelings in books."
          "Set rules and limits for your child, and stick to them. If your child breaks a rule, give him a time out for 30 seconds to 1 minute in a chair or in his room. Praise your child for following the rules",
      "Give your child instructions with 2 or 3 steps. For example, \"Go to your room and get your shoes and coat.\"",
      "Read to your child every day. Ask your child to point to things in the pictures and repeat words after you.",
      "Give your child an \"activity box\" with paper, crayons, and coloring books. Color and draw lines and shapes with your child.",
      "Play matching games. Ask your child to find objects in books or around the house that are the same.",
      "Play counting games. Count body parts, stairs, and other things you use or see every day.",
      "Hold your child\'s hand going up and down stairs. When she can go up and down easily, encourage her to use the railing.",
      "Play outside with your child. Go to the park or hiking trail. Allow your child to play freely and without structured activities.",
    ],
    "48": [
      "Play make-believe with your child. Let her be the leader and copy what she is doing.",
      "Suggest your child pretend play an upcoming event that might make him nervous, like going to preschool or staying overnight at a grandparent\'s house.",
      "Give your child simple choices whenever you can. Let your child choose what to wear, play, or eat for a snack. Limit choices to 2 or 3.",
      "During play dates, let your child solve her own problems with friends, but be nearby to help out if needed.",
      "Encourage your child to use words, share toys, and take turns playing games of one another\'s choice.",
      "Give your child toys to build imagination, like dress-up clothes, kitchen sets, and blocks.",
      "Use good grammar when speaking to your child. Instead of \"Mommy wants you to come here,\" say, \"I want you to come here.\"",
      "Use words like \"first,\" \"second,\" and \"finally\" when talking about everyday activities. This will help your child learn about sequence of events.",
      "Take time to answer your child\'s \"why\" questions. If you don\'t know the answer, say \"I don\'t know,\" or help your child find the answer in a book, on the Internet, or from another adult.",
      "When you read with your child, ask him to tell you what happened in the story as you go.",
      "Say colors in books, pictures, and things at home. Count common items, like the number of snack crackers, stairs, or toy trains.",
      "Teach your child to play outdoor games like tag, follow the leader, and duck, duck, goose.",
      "Play your child\'s favorite music and dance with your child. Take turns copying each other\'s moves.",
    ],
    "60": [
      "Continue to arrange play dates, trips to the park, or play groups. Give your child more freedom to choose activities to play with friends, and let your child work out problems on her own.",
      "Your child might start to talk back or use profanity (swear words) as a way to feel independent. Do not give a lot of attention to this talk, other than a brief time out. Instead, praise your child when he asks for things nicely and calmly takes \"no\" for an answer.",
      "This is a good time to talk to your child about safe touch. No one should touch \"private parts\" except doctors or nurses during an exam or parents when they are trying to keep the child clean.",
      "Teach your child her address and phone number.",
      "When reading to your child, ask him to predict what will happen next in the story",
      "Encourage your child to \"read\" by looking at the pictures and telling the story.",
      "Teach your child time concepts like morning, afternoon, evening, today, tomorrow, and yesterday. Start teaching the days of the week.",
      "Explore your child\'s interests in your community. For example, if your child loves animals, visit the zoo or petting farm. Go to the library or look on the Internet to learn about these topics.",
      "Keep a handy box of crayons, paper, paint, child scissors, and paste. Encourage your child to draw and make art projects with different supplies.",
      "Play with toys that encourage your child to put things together.",
      "Teach your child how to pump her legs back and forth on a swing.",
      "Help your child climb on the monkey bars.",
      "Go on walks with your child, do a scavenger hunt in your neighborhood or park, help him ride a bike with training wheels (wearing a helmet)."
    ]
  };

  @override
  Widget build(BuildContext context) {
    if (monthNum == null) return circularProgress();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0,20.0,8.0,10.0),
          child: AutoSizeText(
            "Help Your Baby Learn and Grow",
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),maxLines: 1,
          ),
        ),
        Expanded(
          // you may want to use an aspect ratio here for tablet support
          child: PageView.builder(
            // itemCount: activitiesList[monthNum].length,
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 1.0),
            itemBuilder: (BuildContext context, int index) {
              return _buildCarouselItem(
                  context, index % activitiesList[monthNum].length);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange[400],
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.extension,
              size: 200.0,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: AutoSizeText(
                activitiesList[monthNum][itemIndex],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
