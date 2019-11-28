// import 'package:flutter/material.dart';

// class MeasurementWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Row(children: <Widget>[
//         Expanded(
//               flex: 3,
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: 10.0,
//                             bottom: 10.0,
//                           ),
//                           child: Text(
//                             "Last updated",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.baseline,
//                       textBaseline: TextBaseline.alphabetic,
//                       children: <Widget>[
//                         Text(
//                           lastUpdated == null ? "No data yet" : new DateFormat('MMM. d, yyyy').format(lastUpdated),
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             VerticalDivider(
//               color: Colors.white,
//               indent: 5.0,
//               endIndent: 5.0,
//             ),
//             Expanded(
//               flex: 2,
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                           child: Text(
//                             "Height",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.baseline,
//                       textBaseline: TextBaseline.alphabetic,
//                       children: <Widget>[
//                         Text(
//                           height,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             VerticalDivider(
//               color: Colors.white,
//               indent: 5.0,
//               endIndent: 5.0,
//             ),
//             Expanded(
//               flex: 2,
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                           child: Text(
//                             "Weight",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.baseline,
//                       textBaseline: TextBaseline.alphabetic,
//                       children: <Widget>[
//                         Text(
//                           weight,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//       ],),
//     );
//   }
// }