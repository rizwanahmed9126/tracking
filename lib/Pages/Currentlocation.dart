// import 'dart:ui';
//
// import 'package:flutter_map_marker_animation_example/Global/GlobalWidgets.dart';
// import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
// import 'package:flutter_map_marker_animation_example/Pages/dashboard.dart';
// import 'package:flutter_map_marker_animation_example/Pages/listen_locations_updates.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
// class HomeMap extends StatefulWidget {
//   static const String routeName = "findme";
//
//   @override
//   _HomeMapState createState() => _HomeMapState();
// }
//
// class _HomeMapState extends State<HomeMap> {
//   bool mapToogle = false;
//   Position currentLocation;
//   BitmapDescriptor cabIcon = BitmapDescriptor.defaultMarker;
//   GoogleMapController mapController;
//   List<Marker> allMarkers = [];
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   PageController _pageController;
//   int previousPage;
//   CameraPosition cPosition;
//   Map<PolylineId, Polyline> polylines = {};
//
//   void getCabIcon() async {
//     cabIcon = await IconUtils.createMarkerImageFromAsset();
//   }
//
//   void onMapCreated(controller) {
//     if (this.mounted) {
//       setState(() {
//         mapController = controller;
//       });
//     }
//   }
//
//   void getCurrentLocation() {
//     Geolocator.getCurrentPosition().then((currloc) {
//       if (this.mounted) {
//         setState(() {
//           currentLocation = currloc;
//
//           mapToogle = true;
//           allMarkers.clear();
//           allMarkers.add(
//             Marker(
//                 markerId: MarkerId("value"),
//                 rotation: 0.0,
//                 icon: cabIcon,
//                 anchor: Offset(0.5, 0.5),
//                 position: LatLng(
//                     currentLocation.latitude, currentLocation.longitude)),
//           );
//
//           //populateClients();
//         });
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     getCabIcon();
//     getCurrentLocation();
//     super.initState();
//   }
//
//   void _onScroll() {
//     if (_pageController.page.toInt() != previousPage) {
//       previousPage = _pageController.page.toInt();
//     }
//   }
//
//   void moveCameratoCurrentlocation() {
//     cPosition = CameraPosition(
//       target: LatLng(currentLocation.latitude, currentLocation.longitude),
//       zoom: 18.0,
//     );
//
//     mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//   }
//
//   Location location = new Location();
//   @override
//   Widget build(BuildContext context) {
//     try {
//       getLocationwithCameraMove();
//     } catch (e) {
//       print('Error in build method : $e');
//     }
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black54),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "Find me",
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
//       body: Stack(
//         children: <Widget>[
//           Container(
//               height: MediaQuery.of(context).size.height - 80.0,
//               width: double.infinity,
//               child: mapToogle
//                   ? GoogleMap(
//                       polylines: Set<Polyline>.of(polylines.values),
//                       //polylines: _polyLine.toSet(),
//                       onMapCreated: onMapCreated,
//
//                       myLocationButtonEnabled: true,
//                       myLocationEnabled: true,
//                       markers: Set.from(allMarkers),
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(currentLocation.latitude,
//                             currentLocation.longitude),
//                         zoom: 18.0,
//                       ),
//                     )
//                   : Center(
//                       child: SpinKitDoubleBounce(
//                         color: Color(0xff187b20),
//                         size: 50.0,
//                       ),
//                     )),
//         ],
//       ),
//       // bottomNavigationBar: Container(
//       //   padding: EdgeInsets.only(bottom: 5),
//       //   child: Padding(
//       //     padding: EdgeInsets.all(10),
//       //     child: TextField(
//       //       decoration: InputDecoration(
//       //         hintText: 'Search',
//       //         hintStyle: TextStyle(fontSize: 16),
//       //         border: OutlineInputBorder(
//       //           borderRadius: BorderRadius.circular(25),
//       //           borderSide: BorderSide(
//       //             width: 0,
//       //             style: BorderStyle.none,
//       //           ),
//       //         ),
//       //         filled: true,
//       //         fillColor: Colors.grey[300],
//       //         contentPadding: EdgeInsets.only(
//       //           left: 30,
//       //         ),
//       //         suffixIcon: Padding(
//       //           padding: EdgeInsets.only(right: 24.0, left: 16.0),
//       //           child: Icon(
//       //             Icons.search,
//       //             color: Colors.black,
//       //             size: 24,
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
//
//   void getLocationwithCameraMove() {
//     Geolocator.getCurrentPosition().then((currloc) {
//       if (this.mounted) {
//         setState(() {
//           try {
//             currentLocation = currloc;
//
//             mapToogle = true;
//             print('This is current Position ' + currentLocation.toString());
//             allMarkers.clear();
//             allMarkers.add(
//               Marker(
//                   markerId: MarkerId("value"),
//                   rotation: 0.0,
//                   icon: cabIcon,
//                   anchor: Offset(0.5, 0.5),
//                   position: LatLng(
//                       currentLocation.latitude, currentLocation.longitude)),
//             );
//
//             // cPosition = CameraPosition(
//             //   target:
//             //       LatLng(currentLocation.latitude, currentLocation.longitude),
//             //   zoom: 18.0,
//             // );
//             // if (mapController != null) {
//             //   mapController
//             //       .animateCamera(CameraUpdate.newCameraPosition(cPosition));
//             // }
//           } catch (e) {
//             print('"Error in getLocationwithCameraMove" : $e');
//           }
//           //populateClients();
//         });
//       }
//     });
//   }
// }
