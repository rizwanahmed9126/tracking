// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
// import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
// import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// //Setting dummies values
// const kStartPosition = LatLng(18.488213, -69.959186);
// const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
// const kMarkerId = MarkerId('MarkerId1');
// const kDuration = Duration(seconds: 2);
// bool isNotPaused = true;
// List<LatLng> kLocations = [];
//
// class SimpleMarkerAnimationExample extends StatefulWidget {
//   static const String routeName = "historyreplay";
//   @override
//   SimpleMarkerAnimationExampleState createState() =>
//       SimpleMarkerAnimationExampleState();
// }
//
// class SimpleMarkerAnimationExampleState
//     extends State<SimpleMarkerAnimationExample> {
//   final markers = <MarkerId, Marker>{};
//   final controller = Completer<GoogleMapController>();
//   Stream<LatLng> stream;
//
//   List<LatLng> polylineCoordinates2 = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};
//   bool mapToogle = false;
//
//   _getPolyline() async {
//     polylineCoordinates2.clear();
//     int i = 0;
//     while (i < carCoordinates.length) {
//       try {
//         PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//           'AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//           PointLatLng(carCoordinates[i].latitude, carCoordinates[i].longitude),
//           PointLatLng(
//               carCoordinates[i + 1].latitude, carCoordinates[i + 1].longitude),
//           travelMode: TravelMode.driving,
//           //wayPoints: allwayPoints
//           // wayPoints: [
//           //   PolylineWayPoint(
//           //       location: allDataList[0].responseObject.routeDetail[0].userName),
//           //   // PolylineWayPoint(location: "24.8951528,67.117528")
//           // ]
//         );
//         // getAngles(
//         //     LatLng(carCoordinates[i].latitude, carCoordinates[i].longitude),
//         //     LatLng(carCoordinates[i + 1].latitude,
//         //         carCoordinates[i + 1].longitude));
//         print(result.errorMessage);
//         if (result.points.isNotEmpty) {
//           result.points.forEach((PointLatLng point) {
//             polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
//           });
//         }
//         i = i + 2;
//       } catch (e) {
//         print('Error: $e');
//       }
//     }
//
//     _addPolyLine();
//   }
//
//   PolylineId id = PolylineId("poly");
//   _addPolyLine() {
//     Polyline polyline = Polyline(
//         width: 5,
//         polylineId: id,
//         color: Colors.blueAccent,
//         points: polylineCoordinates2);
//     polylines[id] = polyline;
//
//     mapToogle = true;
//
//     //getCabIcon();
//     if (this.mounted) {
//       setState(() {
//         kLocations.clear();
//         kLocations = polylineCoordinates2;
//         stream = Stream.periodic(kDuration, (count) => kLocations[count])
//             .take(kLocations.length);
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     try {
//       gethistorydata().then((value) {
//         carCoordinates.clear();
//         carCoordinates.addAll(value);
//         // allwayPoints.clear();
//         // int i = 0;
//         // while (i < carCoordinates.length) {
//         //   allwayPoints.add(PolylineWayPoint(
//         //       location:
//         //           "${carCoordinates[i].latitude},${carCoordinates[i].longitude}"));
//         //   i++;
//         // }
//
//         _getPolyline();
//       });
//     } catch (e) {
//       print('Error $e');
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Maps Markers Animation Example',
//       home: Stack(children: [
//         Animarker(
//           isActiveTrip: isNotPaused,
//           curve: Curves.linearToEaseOut,
//           rippleRadius: 0.2,
//           useRotation: false,
//           duration: Duration(milliseconds: 2300),
//           mapId: controller.future
//               .then<int>((value) => value.mapId), //Grab Google Map Id
//           markers: markers.values.toSet(),
//           child: GoogleMap(
//               polylines: Set<Polyline>.of(polylines.values),
//               mapType: MapType.normal,
//               initialCameraPosition: kSantoDomingo,
//               onMapCreated: (gController) {
//                 controller.complete(gController);
//                 //Complete the future GoogleMapController
//               }),
//         ),
//         Align(
//           alignment: Alignment(0, 0.85),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 style: ButtonStyle(),
//                 onPressed: () {
//                   stream.forEach((value) => newLocationUpdate(value));
//                 },
//                 child: Text('Start Replay'),
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(),
//                 onPressed: () {
//                   setState(() {
//                     isNotPaused = false;
//                   });
//                 },
//                 child: Text('Pause Replay'),
//               ),
//               ElevatedButton(
//                 style: ButtonStyle(),
//                 onPressed: () {
//                   setState(() {
//                     isNotPaused = true;
//                   });
//                 },
//                 child: Text('Resume Replay'),
//               ),
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
//
//   void newLocationUpdate(LatLng latLng) {
//     var marker = RippleMarker(
//         markerId: kMarkerId,
//         position: latLng,
//         ripple: true,
//         onTap: () {
//           print('Tapped! $latLng');
//         });
//     setState(() => markers[kMarkerId] = marker);
//   }
// }
