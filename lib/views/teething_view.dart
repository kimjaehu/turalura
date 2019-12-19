import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeethingView extends StatelessWidget {
  final String assetName;
  final String scheduleText;

  TeethingView({
    @required this.assetName,
    @required this.scheduleText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Teething'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  "Teething: $scheduleText",
                  style: TextStyle(fontSize: 24, color: Colors.blueGrey[800]),
                  maxLines: 1,
                ),
              ),
              Container(
                child: SvgPicture.asset(
                  assetName,
                  semanticsLabel: 'Baby Teething Chart',
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  "Tips to help your baby",
                  style: TextStyle(fontSize: 24, color: Colors.blueGrey[800]),
                  maxLines: 1,
                ),
              ),
              Container(
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                  child: Container(
                    child: AutoSizeText(
                      "Directly massage an irritated, swollen gum with your finger for a couple of minutes. Massaging the gum with a clean, wet cloth that has been chilled in the refrigerator also works well.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                  child: Container(
                    child: AutoSizeText(
                      "Babies massage their own gums by chewing on hard, smooth objects. Give them a teething ring, or a wet cloth that has been chilled.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                  child: Container(
                    child: AutoSizeText(
                      "Give your child a piece of chilled banana. Avoid hard foods like raw carrots that could cause choking.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                  child: Container(
                    child: AutoSizeText(
                      "If these suggestions don\'t seem to help, an infant\'s dose of acetaminophen (over-thecounter pain reliever) can be given for one day. Over-the-counter gels for teething should not be used unless advised by your doctor.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
