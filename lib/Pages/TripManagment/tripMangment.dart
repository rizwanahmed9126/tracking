// import 'package:flutter/material.dart';
// import 'package:flutter_map_marker_animation_example/Global/GlobalWidgets.dart';
//
// class TripMangment24Hour extends StatefulWidget {
//   @override
//   _TripMangment24HourState createState() => _TripMangment24HourState();
// }
//
// class _TripMangment24HourState extends State<TripMangment24Hour> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black54),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "Trip Managment",
//           style: TextStyle(color: Colors.black54),
//         ),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         elevation: 50,
//         child: ListView(
//           physics: BouncingScrollPhysics(),
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             Column(
//                 //color: Colors.black,
//                 //margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 50, bottom: 10),
//                     child: DrawerHeader(
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                             image: AssetImage('assets/images/profile.png')),
//                       ),
//                       child: null,
//                     ),
//                   ),
//                   Text(
//                     "First Name",
//                     style: TextStyle(color: Colors.black54, fontSize: 22),
//                   ),
//                   Text(
//                     "Email",
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 ]),
//             DrawerTiles(context),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
//         child: ListView.builder(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           physics: BouncingScrollPhysics(),
//           itemCount: 5,
//           itemBuilder: (BuildContext context, int index) {
//             return _buildPlayerModelList();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlayerModelList() {
//     return Card(
//       child: ExpansionTile(
//         initiallyExpanded: false,
//         childrenPadding: EdgeInsets.only(bottom: 20),
//         title: Text(
//           "Car Name",
//           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//         ),
//         children: <Widget>[
//           Column(),
//           ListTile(
//             title: Text(
//               "Trip Start",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             trailing: Text("Start time"),
//             //subtitle: ,
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Start time: "),
//                     Text("123"),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Mileage: "),
//                     Text("123"),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Driving duration: "),
//                     Text("123"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           ListTile(
//             title: Text(
//               "Trip End",
//               style: TextStyle(fontWeight: FontWeight.w700),
//             ),
//             trailing: Text("End time"),
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Start time: "),
//                     Text("123"),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Mileage: "),
//                     Text("123"),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Driving duration: "),
//                     Text("123"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
