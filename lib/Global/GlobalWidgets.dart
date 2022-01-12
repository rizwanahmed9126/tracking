// import 'package:flutter/material.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Currentlocation.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
// import 'package:flutter_map_marker_animation_example/Pages/TripManagment/tripMangment.dart';
// import 'package:flutter_map_marker_animation_example/Pages/dashboard.dart';
// import 'package:flutter_map_marker_animation_example/Pages/liveTrack.dart';
// import 'package:flutter_map_marker_animation_example/Pages/reports.dart';
// //import 'package:material_dialogs/material_dialogs.dart';
//
// Padding DrawerTiles(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
//     child: Column(
//       //crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ListTile(
//           leading: Icon(Icons.home_rounded),
//           title: Text('Dashboard',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => MainDashboard()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.location_on_rounded),
//           title: Text('Location',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (BuildContext context) => HomeMap()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.history_rounded),
//           title: Text('History Replay',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (BuildContext context) => HomeMap()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.history_rounded),
//           title: Text('Trip Replay',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => HistorySelection()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.history_rounded),
//           title: Text('Trip Monitor',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => HistorySelection()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.navigation_rounded),
//           title: Text('Trip Mangment',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (BuildContext context) => TripMangment24Hour()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.navigation_rounded),
//           title: Text('Speed Track',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => HistorySelection()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.filter),
//           title: Text('Reports',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (BuildContext context) => ReportsPage()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.alarm),
//           title: Text('Alarm',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => HistorySelection()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.location_pin),
//           title: Text('POI Fencing',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (BuildContext context) => HomeMap()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.local_activity_rounded),
//           title: Text('Live Track',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (BuildContext context) => LiveTrack()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.local_activity_rounded),
//           title: Text('ERS',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => HistorySelection()));
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.logout),
//           title: Text('Logout',
//               style: TextStyle(color: Colors.black54, fontSize: 18)),
//           onTap: () {
//             Navigator.of(context).pop();
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //     builder: (BuildContext context) => HistorySelection()));
//           },
//         ),
//       ],
//     ),
//   );
// }
