// import 'dart:async';
// import 'dart:math' as math;
// import 'package:async/async.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
// import 'package:flutter_animarker/lat_lng_interpolation.dart';
// import 'package:flutter_animarker/models/lat_lng_delta.dart';
// import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
// import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
// import 'package:flutter_map_marker_animation_example/Global/GlobalWidgets.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Currentlocation.dart';
// import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
// import 'package:flutter_map_marker_animation_example/Pages/dashboard.dart';
// import 'package:flutter_map_marker_animation_example/mapUtils.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'extensions.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:maps_toolkit/maps_toolkit.dart' as maps_toolkit;
// import 'package:location/location.dart' as loc;
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_compass/flutter_compass.dart';

// const startPosition = LatLng(24.8666, 67.0010);

// class FlutterMapMarkerAnimationRealTimeExample extends StatefulWidget {
//   static const String routeName = "historyreplay";

//   @override
//   _FlutterMapMarkerAnimationExampleState createState() =>
//       _FlutterMapMarkerAnimationExampleState();
// }

// class _FlutterMapMarkerAnimationExampleState
//     extends State<FlutterMapMarkerAnimationRealTimeExample> {
//   //Markers collection, proper way
//   final Map<MarkerId, Marker> _markers = Map<MarkerId, Marker>();

//   MarkerId sourceId = MarkerId("SourcePin");
//   MarkerId source2Id = MarkerId("SourcePin2");
//   MarkerId source3Id = MarkerId("SourcePin3");

//   LatLngInterpolationStream _latLngStream =
//       LatLngInterpolationStream(movementDuration: Duration(seconds: 1000));

//   StreamGroup<LatLngDelta> subscriptions = StreamGroup<LatLngDelta>();

//   StreamSubscription<Position> positionStream;

//   final Completer<GoogleMapController> _controller = Completer();

//   final CameraPosition _kSantoDomingo = CameraPosition(
//     target: startPosition,
//     zoom: 12,
//   );
//   double _direction;
//   BitmapDescriptor cabIcon = BitmapDescriptor.defaultMarker;

//   void getCabIcon() async {
//     try {
//       cabIcon = await IconUtils.createMarkerImageFromAsset();
//     } catch (e) {
//       print("Error $e");
//     }
//   }

//   List<LatLng> polylineCoordinates2 = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};
//   List<double> angleList = List();
//   List<maps_toolkit.LatLng> list = List();
//   int _divideInToParts = 10;
//   Position carLocation;
//   bool mapToogle = false;
//   GoogleMapController mapController;
//   int count = 0;
//   //List<PolylineWayPoint> allwayPoints = [];

//   _getPolyline() async {
//     polylineCoordinates2.clear();
//     angleList.clear();
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

//     _addPolyLine();
//   }

//   PolylineId id = PolylineId("poly");
//   _addPolyLine() {
//     Polyline polyline = Polyline(
//         width: 5,
//         polylineId: id,
//         color: Colors.blueAccent,
//         points: polylineCoordinates2);
//     polylines[id] = polyline;

//     getAngles(LatLng(24.8666, 67.0010), LatLng(24.8724, 66.9979));
//     mapToogle = true;

//     getCabIcon();
//     if (this.mounted) {
//       setState(() {});
//     }
//   }

//   void start() {
//     //setState(() {
//     //subscriptions.add(_latLngStream.getAnimatedPosition(sourceId.value));
//     subscriptions.add(_latLngStream.getAnimatedPosition(source2Id.value));
//     //subscriptions.add(_latLngStream.getAnimatedPosition(source3Id.value));
//     var markerId;

//     //for (int i = 0; i < carCoordinates.length; i++) {

//     subscriptions.stream.listen((LatLngDelta delta) {
//       count++;
//       //Update the marker with animation
//       setState(() {
//         markerId = MarkerId(delta.markerId);
//         Marker sourceMarker = Marker(
//           markerId: markerId,
//           //rotation: carCoordinates[53].angle.toDouble(),
//           rotation: delta.rotation + 145,
//           // >= 300
//           //     ? delta.rotation + 145
//           //     : delta.rotation - 245,
//           icon: cabIcon,
//           anchor: Offset(0.5, 0.5),
//           position: LatLng(
//             delta.from.latitude,
//             delta.from.longitude,
//           ),
//         );
//         _markers[markerId] = sourceMarker;

//         print(delta.rotation + 145);
//         // mapController.animateCamera(CameraUpdate.newCameraPosition(
//         //     CameraPosition(
//         //         target: LatLng(_markers[markerId].position.latitude,
//         //             _markers[markerId].position.longitude),
//         //         zoom: 12.0)));
//       });
//     });

//     //}
//     positionStream = Geolocator.getPositionStream(
//       desiredAccuracy: LocationAccuracy.best,
//       //distanceFilter: 10,
//     ).listen((Position position) {
//       double latitude = position.latitude;
//       double longitude = position.longitude;

//       //Push new location changes
//       //_latLngStream.addLatLng(LatLngInfo(latitude, longitude, sourceId.value));
//       for (int i = 0; i < polylineCoordinates2.length; i++) {
//         _latLngStream.addLatLng(LatLngInfo(polylines[id].points[i].latitude,
//             polylines[id].points[i].longitude, source2Id.value));
//         carLocation = position;
//       }
//       // for (int i = 10; i >= 0; i--) {
//       //   _latLngStream.addLatLng(
//       //       LatLngInfo(latitude - 0.01, longitude - 0.01, source2Id.value));
//       // }
//       // _latLngStream.addLatLng(
//       //     LatLngInfo(latitude + 0.2, longitude + 0.2, source3Id.value));
//     }, onDone: () {
//       subscriptions.close();
//       positionStream.cancel();
//     });
//     //});
//     print("Stream length: " + count.toString());
//   }

//   void getAngles(LatLng from, LatLng to) {
//     maps_toolkit.LatLng tempPre =
//         maps_toolkit.LatLng(from.latitude, from.longitude);
//     for (int start = 1; start <= _divideInToParts; start++) {
//       maps_toolkit.LatLng tempLatlng = maps_toolkit.SphericalUtil.interpolate(
//           maps_toolkit.LatLng(from.latitude, from.longitude),
//           maps_toolkit.LatLng(to.latitude, to.longitude),
//           start / _divideInToParts);
//       list.add(tempLatlng);
//       double angle = MapUtils.getRotation(
//           LatLng(tempPre.latitude, tempPre.longitude),
//           LatLng(tempLatlng.latitude, tempLatlng.longitude));
//       tempPre = tempLatlng;
//       angleList.add(angle);
//     }
//   }

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

//         _getPolyline();
//       });
//       FlutterCompass.events.listen((event) {
//         setState(() {
//           _direction = event.heading;
//         });
//       });
//     } catch (e) {
//       print('Error $e');
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black54),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "History Replay",
//           style: TextStyle(color: Colors.black54),
//         ),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         child: ListView(
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
//       body: SafeArea(
//         child: mapToogle
//             ? Stack(children: <Widget>[
//                 GoogleMap(
//                   polylines: Set<Polyline>.of(polylines.values),
//                   mapType: MapType.terrain,
//                   markers: Set<Marker>.of(_markers.values),
//                   initialCameraPosition: _kSantoDomingo,
//                   zoomGesturesEnabled: true,
//                   onMapCreated: (GoogleMapController controller) {
//                     try {
//                       _controller.complete(controller);
//                       mapController = controller;
//                       mapController.animateCamera(
//                           CameraUpdate.newCameraPosition(CameraPosition(
//                               target: LatLng(polylines[id].points[0].latitude,
//                                   polylines[id].points[0].longitude),
//                               zoom: 12.0)));
//                       if (this.mounted) {
//                         setState(() {
//                           //   Marker sourceMarker = Marker(
//                           //     markerId: sourceId,
//                           //     position: startPosition,
//                           //   );
//                           //   _markers[sourceId] = sourceMarker;

//                           Marker source2Marker = Marker(
//                             markerId: source2Id,
//                             position: LatLng(polylines[id].points[0].latitude,
//                                 polylines[id].points[0].longitude),
//                             anchor: Offset(0.5, 0.5),
//                             icon: cabIcon,
//                           );
//                           _markers[source2Id] = source2Marker;

//                           //   Marker source3Marker = Marker(
//                           //     markerId: source3Id,
//                           //     position: startPosition,
//                           //   );
//                           //   _markers[source3Id] = source3Marker;
//                         });
//                       }
//                       // _latLngStream
//                       //     .addLatLng(startPosition.toLatLngInfo(sourceId.value));
//                       _latLngStream.addLatLng(
//                           startPosition.toLatLngInfo(source2Id.value));
//                       // _latLngStream
//                       //     .addLatLng(startPosition.toLatLngInfo(source3Id.value));
//                     } catch (e) {
//                       print('Error : $e');
//                     }
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 30),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Stack(
//                               alignment: Alignment.bottomCenter,
//                               children: <Widget>[
//                                 ElevatedButton(
//                                   style: ButtonStyle(
//                                     backgroundColor: MaterialStateProperty
//                                         .resolveWith<Color>(
//                                       (Set<MaterialState> states) {
//                                         if (states
//                                             .contains(MaterialState.pressed))
//                                           return Colors.green;
//                                         return Colors
//                                             .white; // Use the component's default.
//                                       },
//                                     ),
//                                   ),
//                                   onPressed: () => start(),
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.play_arrow_rounded,
//                                         size: 28,
//                                         color: Colors.green,
//                                       ),
//                                       Text(
//                                         "START",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.black54),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Stack(
//                               alignment: Alignment.bottomCenter,
//                               children: <Widget>[
//                                 ElevatedButton.icon(
//                                   style: ButtonStyle(
//                                     backgroundColor: MaterialStateProperty
//                                         .resolveWith<Color>(
//                                       (Set<MaterialState> states) {
//                                         if (states
//                                             .contains(MaterialState.pressed))
//                                           return Colors.green;
//                                         return Colors
//                                             .white; // Use the component's default.
//                                       },
//                                     ),
//                                   ),
//                                   onPressed: () => _latLngStream.pause(),
//                                   icon: Icon(
//                                     Icons.pause_circle_outline_rounded,
//                                     size: 28,
//                                     color: Colors.orange,
//                                   ),
//                                   label: Text("PAUSE",
//                                       style: TextStyle(
//                                           fontSize: 18, color: Colors.black54)),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Stack(
//                               alignment: Alignment.bottomCenter,
//                               children: <Widget>[
//                                 ElevatedButton.icon(
//                                   style: ButtonStyle(
//                                     backgroundColor: MaterialStateProperty
//                                         .resolveWith<Color>(
//                                       (Set<MaterialState> states) {
//                                         if (states
//                                             .contains(MaterialState.pressed))
//                                           return Colors.green;
//                                         return Colors
//                                             .white; // Use the component's default.
//                                       },
//                                     ),
//                                   ),
//                                   onPressed: () => _latLngStream.resume(),
//                                   icon: Icon(
//                                     Icons.replay_10_rounded,
//                                     size: 28,
//                                     color: Colors.blueAccent,
//                                   ),
//                                   label: Text("RESUME",
//                                       style: TextStyle(
//                                           fontSize: 18, color: Colors.black54)),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )
//                       ]),
//                 ),
//               ])
//             : Center(
//                 child: SpinKitDoubleBounce(
//                   color: Color(0xff187b20),
//                   size: 50.0,
//                 ),
//               ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     try {
//       if (this.mounted) {
//         subscriptions.close();

//         positionStream.cancel();
//       }
//     } catch (e) {
//       print('"Error" : $e');
//     }
//     super.dispose();
//   }
// }
