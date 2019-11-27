import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class OnboardView extends StatefulWidget {
  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  List<Slide> slides = new List();
  String country;

  @override
  void initState() {
    super.initState();
    country = 'us';

    slides.add(
      new Slide(
        title: "CHECK MILESTONES",
        description: "Check your child’s development against milestones.",
        // pathImage: "images/photo_eraser.png",
        centerWidget: Icon(
          Icons.border_color,
          color: Colors.white,
          size: 225.0,
        ),
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "TRACK GROWTH",
        description:
            "Compare height/weight measurements against growth standards",
        // pathImage: "images/photo_pencil.png",
        centerWidget: Icon(
          Icons.straighten,
          color: Colors.white,
          size: 225.0,
        ),
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "Let us begin!",
        description: "Turalura",
        // pathImage: "images/photo_ruler.png",
        centerWidget: Icon(
          Icons.child_care,
          color: Colors.white,
          size: 225.0,
        ),

        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
     Navigator.of(context).pushReplacementNamed('/country');
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      isShowSkipBtn: false,
    );
  }
}
