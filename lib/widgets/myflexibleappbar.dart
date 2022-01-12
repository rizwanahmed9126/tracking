// import 'package:animated_text/animated_text.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// String user = "User";
//
// class MyFlexiableAppBar extends StatelessWidget {
//   final double appBarHeight = 66.0;
//   List<Marker> allMarkers = [];
//   MyFlexiableAppBar();
//
//   @override
//   Widget build(BuildContext context) {
//     final double statusBarHeight = MediaQuery.of(context).padding.top;
//
//     return new Container(
//       padding: new EdgeInsets.only(top: statusBarHeight),
//       height: statusBarHeight + appBarHeight,
//       child: new Center(
//         child: Stack(
//           children: <Widget>[
//             Container(
//                 height: MediaQuery.of(context).size.height - 80.0,
//                 width: double.infinity,
//                 child: GoogleMap(
//                   //polylines: Set<Polyline>.of(polylines.values),
//                   //polylines: _polyLine.toSet(),
//                   //onMapCreated: onMapCreated,
//                   myLocationButtonEnabled: false,
//                   myLocationEnabled: false,
//                   markers: Set.from(allMarkers),
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(24.8724, 66.9979),
//                     zoom: 10.0,
//                   ),
//                 )),
//           ],
//         ),
//         //     child: Column(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: <Widget>[
//         //     Flexible(
//         //       fit: FlexFit.loose,
//         //       flex: 2,
//         //       child: Container(
//         //         //color: Colors.black,
//         //         margin: EdgeInsets.fromLTRB(25, 20, 0, 0),
//         //         child: AnimatedText(
//         //           repeatCount: 1,
//         //           // speed: Duration(milliseconds: 1000),
//         //           controller: AnimatedTextController.play,
//         //           // displayTime: Duration(milliseconds: 1000),
//         //           alignment: Alignment.topLeft,
//         //           //displayTime: Duration(milliseconds: 4000),
//         //           wordList: [
//         //             'Welcome To',
//         //             'Trackpoint 2.0',
//         //             // 'Serve you.',
//         //             //'Hi, ' + user,
//         //           ],
//         //           textStyle: TextStyle(
//         //               color: Colors.black54,
//         //               fontSize: 33,
//         //               fontWeight: FontWeight.w700),
//         //         ),
//         //       ),
//         //     ),
//         //     // Container(
//         //     //   child: Column(
//         //     //     mainAxisAlignment: MainAxisAlignment.center,
//         //     //     children: <Widget>[
//         //     //       Container(
//         //     //         child: new Text("Balance",
//         //     //             style: const TextStyle(
//         //     //                 color: Colors.white,
//         //     //                 fontFamily: 'Poppins',
//         //     //                 fontSize: 28.0)),
//         //     //       ),
//         //     //       Container(
//         //     //         child: new Text("\u002420,914.33",
//         //     //             style: const TextStyle(
//         //     //                 color: Colors.white,
//         //     //                 fontFamily: 'Poppins',
//         //     //                 fontWeight: FontWeight.w800,
//         //     //                 fontSize: 36.0)),
//         //     //       ),
//         //     //     ],
//         //     //   ),
//         //     // ),
//         //     // Container(
//         //     //   child: Row(
//         //     //     mainAxisAlignment: MainAxisAlignment.center,
//         //     //     children: <Widget>[
//         //     //       Container(
//         //     //         child: Padding(
//         //     //           padding: const EdgeInsets.only(bottom: 16.0),
//         //     //           child: new Text("\u002B24.93\u0025",
//         //     //               style: const TextStyle(
//         //     //                   color: Colors.white70,
//         //     //                   fontFamily: 'Poppins',
//         //     //                   fontSize: 20.0)),
//         //     //         ),
//         //     //       ),
//         //     //       Container(
//         //     //         child: Padding(
//         //     //           padding: const EdgeInsets.only(bottom: 16.0),
//         //     //           child: Icon(
//         //     //             FontAwesomeIcons.longArrowAltUp,
//         //     //             color: Colors.green,
//         //     //           ),
//         //     //         ),
//         //     //       ),
//         //     //     ],
//         //     //   ),
//         //     // ),
//         //     Container(
//         //       child: Row(
//         //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //         children: <Widget>[
//         //           Container(
//         //             child: Padding(
//         //               padding: const EdgeInsets.only(bottom: 18.0, left: 25.0),
//         //               child: new Text("Logged In",
//         //                   style: const TextStyle(
//         //                       color: Colors.black87,
//         //                       fontFamily: 'Poppins',
//         //                       fontSize: 10.0)),
//         //             ),
//         //           ),
//         //           // Container(
//         //           //   child: Padding(
//         //           //     padding: const EdgeInsets.only(bottom: 18.0, right: 26.0),
//         //           //     child: Container(
//         //           //         child: Row(
//         //           //       children: <Widget>[
//         //           //         Container(
//         //           //           child: Icon(
//         //           //             //FontAwesomeIcons.calendarAlt,
//         //           //             Icons.notification_important_rounded,
//         //           //             color: Colors.black87,
//         //           //           ),
//         //           //         ),
//         //           //         SizedBox(
//         //           //           width: 10,
//         //           //         ),
//         //           //         // Container(
//         //           //         //   child: Text(
//         //           //         //     'Janaury 2019',
//         //           //         //     style: const TextStyle(
//         //           //         //         color: Colors.white70,
//         //           //         //         fontFamily: 'Poppins',
//         //           //         //         fontSize: 16.0),
//         //           //         //   ),
//         //           //         // ),
//         //           //       ],
//         //           //     )),
//         //           //   ),
//         //           // ),
//         //         ],
//         //       ),
//         //     ),
//         //   ],
//         // )
//       ),
//       decoration: new BoxDecoration(
//         // image: DecorationImage(
//         //     fit: BoxFit.cover, image: AssetImage('assets/images/map.jpg')),
//         color: Colors.grey[50],
//       ),
//     );
//   }
// }
