import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FoodView extends StatelessWidget {
  final double monthDifference;
  List menus;
  FoodView({
    @required this.monthDifference,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   appBar: AppBar(
        //     title: Text('Baby Teething'),
        //   ),
        //   body: Container(
        //     child: PageView.builder(
        //       // itemCount: activitiesList[monthNum].length,
        //       // store this controller in a State to save the carousel scroll position
        //       controller: PageController(viewportFraction: 0.9),
        //       itemBuilder: (BuildContext context, int index) {
        //         return _buildCarouselItem(
        //             context, index % activitiesList[monthNum].length);
        //       },
        //     ),
        //   ),
        );
  }

  // Widget _buildCarouselItem(BuildContext context, int itemIndex) {
  //   return Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.orange,
  //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(
  //             Icons.extension,
  //             size: 100.0,
  //             color: Colors.white,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(32.0),
  //             child: AutoSizeText(
  //               // activitiesList[monthNum][itemIndex],
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16.0),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
