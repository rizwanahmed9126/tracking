// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
// import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';

// class HistoryReplay extends StatefulWidget {
//   @override
//   _HistoryReplayState createState() => _HistoryReplayState();
// }

// class _HistoryReplayState extends State<HistoryReplay> {
//   final Set<Polyline> _polyline = {};

//   MapType _normalMap = MapType.normal;

//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();

//   List<LatLng> polylineCoordinatesIOT = [];

//   GoogleMapController mapController;
//   // previous
//   static LatLng _lat1 = LatLng(24.85971451594413, 67.06038752481591);
//   static LatLng _lat2 = LatLng(24.859558984233043, 67.05962292386806);
//   static LatLng _lat3 = LatLng(24.8592893555313, 67.05930179057735);
//   static LatLng _lat4 = LatLng(24.858632259267893, 67.05935275254896);

//   //new
//   static LatLng _lat5 =  LatLng(24.859225931916384, 67.04996695200452);
//       static LatLng _lat6 =  LatLng(24.85968833113156, 67.05054362696254);
//       static LatLng _lat7 =LatLng(24.859218630862276, 67.05177207873358);
//       static LatLng _lat8 =LatLng(24.859622621876415, 67.05293079305821);
//       static LatLng _lat9 = LatLng(24.859797878363477, 67.05410485092777);
//       static LatLng _lat10 =LatLng(24.85985628479651, 67.05435161642015);
//       static LatLng _lat11 = LatLng(24.860284611131814, 67.0546413034383);
//       static LatLng _lat12 = LatLng(24.86115100505278, 67.05468423291917);
//       static LatLng _lat13 = LatLng(24.861462518263302, 67.05467350890952);
//       static LatLng _lat14 = LatLng(24.86177403359233, 67.05446966115635);
//       static LatLng _lat15 = LatLng(24.861783771585905, 67.05404049750547);
//       static LatLng _lat16 =LatLng(24.861657220001046, 67.05391174724319);
//   BitmapDescriptor pinLocationIcon;
//   List<LatLng> latLang = [];
//   List<Marker> marker=[]; //for default markers
//   List<Marker> marker2=[]; //for car marker
//   final controller = Completer<GoogleMapController>();
//   Stream<LatLng> stream;
//   bool isNotPaused = true;
//   final markers = <MarkerId, Marker>{}; //testing

//   setStartAndEndMarkers()async{
//     marker.add(Marker(
//       markerId: MarkerId('start'),
//       position: LatLng(24.859225931916384, 67.04996695200452),
//       infoWindow: InfoWindow(
//           title: 'Start'
//       ),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       // rotation:260
//     ));
//     marker.add(Marker(
//       markerId: MarkerId('end'),
//       position:LatLng(24.861657220001046, 67.05391174724319),
//       infoWindow: InfoWindow(
//           title: 'Destination'
//       ),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//       //rotation: 260.0
//     ));
//   }

//   setCustomMarker()async{
//     //pinLocationIcon= await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),'assets/ic_car.png');
//     for(int i=0;i<latLang.length;i++){
//       marker.add(Marker(
//           markerId: MarkerId('$i'),
//           position: latLang[i],
//           icon: await IconUtils.createMarkerImageFromAsset(),
//           rotation:260
//       ));
//       await Future.delayed(const Duration(seconds: 2), (){});
//     }

//   }
//   _addPolyLine() async {
//     latLang.add(_lat5);
//     latLang.add(_lat6);
//     latLang.add(_lat7);
//     latLang.add(_lat8);
//     latLang.add(_lat9);
//     latLang.add(_lat10);
//     latLang.add(_lat11);
//     latLang.add(_lat12);
//     latLang.add(_lat13);
//     latLang.add(_lat14);
//     latLang.add(_lat15);
//     latLang.add(_lat16);

//     for (int i = 0; i < latLang.length - 1; i++) {
//       PolylineResult result = await polylinePoints?.getRouteBetweenCoordinates(
//           'AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//           PointLatLng(latLang[i].latitude, latLang[i].longitude),
//           PointLatLng(latLang[i + 1].latitude, latLang[i + 1].longitude),
//           travelMode: TravelMode.driving);
//       if (result.points.isNotEmpty) {
//         //polylineCoordinates.clear();
//         result.points.forEach((PointLatLng point) {
//           double dist = Geolocator.distanceBetween(
//               latLang[i].latitude,
//               latLang[i].longitude,
//               latLang[i + 1].latitude,
//               latLang[i + 1].longitude);

//           print('in meters for $i and ${i + 1}:- $dist');
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//           //matching.add(LatLng(point.latitude,point.longitude));
//         });
//       }
//     }

//     // PolylineResult result = await polylinePoints?.getRouteBetweenCoordinates('AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//     //     PointLatLng(_lat1.latitude,_lat1.longitude),PointLatLng(_lat2.latitude,_lat2.longitude),);
//     //
//     // PolylineResult result2 = await polylinePoints?.getRouteBetweenCoordinates('AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//     //   PointLatLng(_lat2.latitude,_lat2.longitude),PointLatLng(_lat3.latitude,_lat3.longitude),);
//     //
//     // PolylineResult result3 = await polylinePoints?.getRouteBetweenCoordinates('AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//     //   PointLatLng(_lat3.latitude,_lat3.longitude),PointLatLng(_lat4.latitude,_lat4.longitude),);

//     // if (result.points.isNotEmpty) {
//     //
//     //   //polylineCoordinates.clear();
//     //   result.points.forEach((PointLatLng point) {
//     //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     //matching.add(LatLng(point.latitude,point.longitude));
//     //  });
//     // result2.points.forEach((PointLatLng point) {
//     //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     //   //matching.add(LatLng(point.latitude,point.longitude));
//     // });
//     // result3.points.forEach((PointLatLng point) {
//     //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     //   //matching.add(LatLng(point.latitude,point.longitude));
//     // });
//     //}
//     setState(() {
//       _polyline.add(Polyline(
//         polylineId: PolylineId('id'),
//         visible: true,
//         points: polylineCoordinates,
//         width: 3,
//         color: Colors.teal,
//       ));
//       stream = Stream.periodic(Duration(seconds: 2), (count) => latLang[count])
//           .take(latLang.length);
//     });

//     //  kLocations.clear();
//     // kLocations = polylineCoordinates2;

//   }

//   void onMapCreated(control) async {
//     controller.complete(control);
//     mapController = control;
//     _addPolyLine();
//     void _onMaptype() {
//       setState(() {
//         _normalMap =
//         _normalMap == MapType.normal ? MapType.satellite : MapType.normal;
//       });
//     }
//   }
//   void newLocationUpdate(LatLng latLng,kMarkerId)async {
//     final id=MarkerId('MarkerId1');
//     var mark = RippleMarker(
//         rotation: 265,
//         markerId: id,
//         position: latLng,
//         ripple: true,
//         icon:await IconUtils.createMarkerImageFromAsset() ,
//         onTap: () {
//           print('Tapped! $latLng');
//         });
//     var mark2 = RippleMarker(
//         rotation: 265,
//         markerId: MarkerId('$kMarkerId some'),
//         position: latLng,
//         ripple: true,
//         //icon:await IconUtils.createMarkerImageFromAsset() ,
//         onTap: () {
//           print('Tapped! $latLng');
//         });
//     setState((){
//       marker2.add(mark2);
//      //marker.add(mark);
//       markers[id] = mark;
//      //marker[kMarkerId] = mark;
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     setStartAndEndMarkers();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Animarker(
//               rippleColor: Colors.teal[100],
//               isActiveTrip: isNotPaused,
//               curve: Curves.bounceInOut,
//               rippleRadius: 0.0,
//               useRotation: true,
//               // duration: Duration(milliseconds: 2300),
//               mapId: controller.future
//                   .then<int>((value) => value.mapId), //Grab Google Map Id
//               //markers: Set<Marker>.of(marker2),
//               markers: markers.values.toSet(),

//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                     target: LatLng(24.865731020786423, 67.05632570970778),
//                     zoom: 15.0),
//                 //zoomControlsEnabled: false,

//                 mapType: _normalMap,
//                 polylines: _polyline,
//                 onMapCreated: onMapCreated,
//                 markers: Set<Marker>.of(marker),

//               ),
//             ),
//             CircleAvatar(
//                 child:
//                 IconButton(icon: Icon(Icons.play_arrow),
//                     onPressed: ()async {
//                       //   for(int i=0;i<latLang.length;i++){
//                       //     marker.add(Marker(
//                       //         markerId: MarkerId('$i'),
//                       //         position: latLang[i],
//                       //         icon: await IconUtils.createMarkerImageFromAsset(),
//                       //         rotation:260
//                       //     ));
//                       //     setState(() {
//                       //
//                       //     });
//                       //   await Future.delayed(const Duration(seconds: 1), (){});
//                       //
//                       // }
//                       int i =0;
//                       stream.forEach((value) {
//                         newLocationUpdate(value,i);
//                         i=i+1;
//                       });

//                     }))

//             // Positioned(
//             //   bottom: 0,
//             //     right: 0,
//             //     child: Column(
//             //     children: [
//             //
//             //       RawMaterialButton(
//             //           onPressed: (){},
//             //         child: Icon(Icons.map),
//             //         fillColor: Colors.white,
//             //         shape: CircleBorder(),
//             //         padding: EdgeInsets.all(8),
//             //
//             //           ),
//             //       RawMaterialButton(
//             //         onPressed: (){},
//             //         child: Icon(Icons.map),
//             //         fillColor: Colors.white,
//             //         shape: CircleBorder(),
//             //         padding: EdgeInsets.all(8),
//             //
//             //       ),
//             //       RawMaterialButton(
//             //         onPressed: (){},
//             //         child: Icon(Icons.map),
//             //         fillColor: Colors.white,
//             //         shape: CircleBorder(),
//             //         padding: EdgeInsets.all(8),
//             //
//             //       ),
//             //     ],
//             // ))
//           ],
//         ),
//       ),
//     );
//   }

// }

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
// import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//
// //Setting dummies values
// const kStartPosition = LatLng(24.859225931916384, 67.04996695200452);
// //const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 18);
// const kMarkerId = MarkerId('MarkerId1');
// const kDuration = Duration(seconds: 3);
// const kLocations = [
//   kStartPosition,
//   LatLng(24.859225931916384, 67.04996695200452),
//   LatLng(24.85968833113156, 67.05054362696254),
//   LatLng(24.859218630862276, 67.05177207873358),
//   LatLng(24.859622621876415, 67.05293079305821),
//   LatLng(24.859797878363477, 67.05410485092777),
//   LatLng(24.85985628479651, 67.05435161642015),
//   LatLng(24.860284611131814, 67.0546413034383),
//   LatLng(24.86115100505278, 67.05468423291917),
//   LatLng(24.861462518263302, 67.05467350890952),
//   LatLng(24.86177403359233, 67.05446966115635),
//   LatLng(24.861783771585905, 67.05404049750547),
//   LatLng(24.861657220001046, 67.05391174724319),
// ];
//
// class SimpleMarkerAnimationExample extends StatefulWidget {
//   @override
//   SimpleMarkerAnimationExampleState createState() =>
//       SimpleMarkerAnimationExampleState();
// }
//
// class SimpleMarkerAnimationExampleState
//     extends State<SimpleMarkerAnimationExample> {
//   final markers = <MarkerId, Marker>{};
//   final controller = Completer<GoogleMapController>();
//   final stream = Stream.periodic(kDuration, (count) => kLocations[count])
//       .take(kLocations.length);
//
//   GoogleMapController mapController;
//
//   @override
//   void initState() {
//     super.initState();
//     setSourceAndDestinationIcons();
//   }
//
//   PolylinePoints polylinePoints = PolylinePoints();
// //
//   List<LatLng> polylineCoordinates = [];
//
//   BitmapDescriptor sourceIcon;
//   //Set<Marker> _markers = {};
//   final Set<Polyline> _polyline = {};
//
//   void setSourceAndDestinationIcons() async {
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.0), 'assets/images/ic_car.png');
//   }
//
//   // void setMapPins() {
//   //   setState(() {
//   //
//   //     _markers.add(Marker(
//   //         markerId: MarkerId('${kLocations[1]}'),
//   //         position: kLocations[1],
//   //         icon: sourceIcon));
//   //
//   //   });
//   // }
//   _addPolyLine() async {
//     // latLang.add(_lat1);
//     // latLang.add(_lat2);
//     // latLang.add(_lat3);
//     // latLang.add(_lat4);
//
//     for (int i = 0; i < kLocations.length - 1; i++) {
//       PolylineResult result = await polylinePoints?.getRouteBetweenCoordinates(
//         'AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//         PointLatLng(kLocations[i].latitude, kLocations[i].longitude),
//         PointLatLng(kLocations[i + 1].latitude, kLocations[i + 1].longitude),
//       );
//       if (result.points.isNotEmpty) {
//         result.points.forEach((PointLatLng point) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         });
//       }
//     }
//
//     setState(() {
//       _polyline.add(Polyline(
//         polylineId: PolylineId('id'),
//         visible: true,
//         points: polylineCoordinates,
//         width: 3,
//         color: Colors.teal,
//       ));
//     });
//   }
//
//   void onMapCreated(gController) async {
//     mapController = gController;
//     stream.forEach((value) => newLocationUpdate(value));
//     controller.complete(gController);
//
//     //setMapPins();
//
//     _addPolyLine();
//   }
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Maps Markers Animation Example',
//       home: Animarker(
//         curve: Curves.bounceOut,
//         rippleRadius: 0.0,
//         useRotation: true,
//         duration: Duration(milliseconds: 2500),
//         mapId: controller.future
//             .then<int>((value) => value.mapId), //Grab Google Map Id
//         markers: markers.values.toSet(),
//         child: GoogleMap(
//             mapType: MapType.normal,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(24.859225931916384, 67.04996695200452),
//               zoom: 19,
//             ),
//             onMapCreated: (gController) {
//               stream.forEach((value) => newLocationUpdate(value));
//               controller.complete(gController);
//
//               _addPolyLine();
//             }),
//       ),
//     );
//   }
//
//   void newLocationUpdate(LatLng latLng) async {
//     var marker = RippleMarker(
//         icon: await IconUtils.createMarkerImageFromAsset(),
//         markerId: kMarkerId,
//         position: latLng,
//         ripple: true,
//         onTap: () {
//           print('Tapped! $latLng');
//         });
//     setState(() => markers[kMarkerId] = marker);
//   }
// }
