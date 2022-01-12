// import 'dart:ui';
//
// import 'package:flutter_map_marker_animation_example/Entities/Mechanics.dart';
// import 'package:location/location.dart';
//
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
//
// class VehicleDetailMap extends StatefulWidget {
//   final String appbarName;
//   VehicleDetailMap({Key key, this.appbarName}) : super(key: key);
//
//   @override
//   _VehicleDetailMapState createState() => _VehicleDetailMapState();
// }
//
// class _VehicleDetailMapState extends State<VehicleDetailMap> {
//   bool mapToogle = false;
//
//   GoogleMapController mapController;
//   List<Marker> allMarkers = [];
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   PageController _pageController;
//   int previousPage;
//   Map<PolylineId, Polyline> polylines = {};
//
//   void onMapCreated(controller) async {
//     setState(() {
//       mapController = controller;
//
//     });
//   }
//
//   moveCamera() {
//     mapController.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//           zoom: 15.0,
//           bearing: 45.0,
//           tilt: 45.0,
//           target: LatLng(mechanicMarkers[_pageController.page.toInt()].latitude,
//               mechanicMarkers[_pageController.page.toInt()].longitude)),
//     ));
//   }
//
//   _getPolyline(index) async {
//     polylineCoordinates.clear();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8',
//       PointLatLng(
//           mechanicMarkers[index].latitude, mechanicMarkers[index].longitude),
//       PointLatLng(currentLocation.latitude, currentLocation.longitude),
//       travelMode: TravelMode.driving,
//       //wayPoints:[new google.maps.LatLng(45.658197,-73.636333)],
//       // wayPoints: [
//       //   PolylineWayPoint(
//       //       location: allDataList[0].responseObject.routeDetail[0].userName),
//       //   // PolylineWayPoint(location: "24.8951528,67.117528")
//       // ]
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     _addPolyLine();
//   }
//
//   _addPolyLine() {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         width: 5,
//         polylineId: id,
//         color: Colors.blueAccent,
//         points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }
//
//   void _onScroll() {
//     if (_pageController.page.toInt() != previousPage) {
//       previousPage = _pageController.page.toInt();
//       moveCamera();
//     }
//   }
//
//   _mechanicsList(index) {
//     return AnimatedBuilder(
//       animation: _pageController,
//       builder: (BuildContext context, Widget widget) {
//         double value = 1;
//         if (_pageController.position.haveDimensions) {
//           value = _pageController.page - index;
//           value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
//         }
//         return Center(
//           child: Container(
//             height: Curves.easeInOut.transform(value) * 325.0,
//             width: Curves.easeInOut.transform(value) * 350.0,
//             child: widget,
//           ),
//         );
//       },
//       child: InkWell(
//         onTap: () {
//           moveCamera();
//           //_getPolyline(index);
//         },
//         child: Stack(
//           children: <Widget>[
//             Center(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//                 height: MediaQuery.of(context).size.height * 0.125,
//                 width: MediaQuery.of(context).size.width * 0.770,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black,
//                         offset: Offset(20.10, 20.8),
//                         blurRadius: 75.0,
//                       )
//                     ]),
//                 child: Container(
//                   //width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: Colors.white,
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         height: MediaQuery.of(context).size.height,
//                         width: 90.0,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(10.0),
//                               topLeft: Radius.circular(10.0),
//                             ),
//                             image: DecorationImage(
//                                 image: NetworkImage(
//                                     'https://www.auto.edu/wp-content/uploads/ATI-76-734x550.png'),
//                                 fit: BoxFit.cover)),
//                       ),
//                       SizedBox(width: 5.0),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             mechanicMarkers[index].firstName,
//                             style: TextStyle(
//                                 fontSize: 12.5, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             mechanicMarkers[index].lastName,
//                             style: TextStyle(
//                                 fontSize: 12.0, fontWeight: FontWeight.w600),
//                           ),
//                           Container(
//                             width: 170.0,
//                             child: Text(
//                               mechanicMarkers[index].phone,
//                               style: TextStyle(
//                                   fontSize: 11.0, fontWeight: FontWeight.w300),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     Geolocator.getCurrentPosition().then((currloc) {
//       setState(() {
//         currentLocation = currloc;
//         mapToogle = true;
//         print('This is current Position ' + currentLocation.toString());
//
//         //populateClients();
//       });
//     });
//     mechanicMarkers.forEach((element) {
//       allMarkers.add(Marker(
//           markerId: MarkerId(element.firstName),
//           draggable: false,
//           position: LatLng(element.latitude, element.longitude),
//           infoWindow:
//               InfoWindow(title: element.phone, snippet: element.lastName)));
//     });
//     _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
//       ..addListener(_onScroll);
//     // setState(() {
//     //   selectedFilter = filters[0];
//     // });
//   }
//
//   Location location = new Location();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           '${widget.appbarName} Cars',
//           style: TextStyle(color: Colors.black87),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//               height: MediaQuery.of(context).size.height,
//               width: double.infinity,
//               child: mapToogle
//                   ? GoogleMap(
//                       polylines: Set<Polyline>.of(polylines.values),
//                       //polylines: _polyLine.toSet(),
//                       onMapCreated: onMapCreated,
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
//                       child: Text(
//                         "Loading.. Please wait.",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     )),
//           Positioned(
//               bottom: 0.0,
//               child: Container(
//                   //color: Colors.black,
//                   height: MediaQuery.of(context).size.height * 0.25,
//                   width: MediaQuery.of(context).size.width,
//                   child: PageView.builder(
//                       controller: _pageController,
//                       itemCount: mechanicMarkers.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return _mechanicsList(index);
//                       })))
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
//   // Widget buildFilterIcon() {
//   //   return Container(
//   //     width: 50,
//   //     height: 50,
//   //     margin: EdgeInsets.symmetric(horizontal: 16),
//   //     decoration: BoxDecoration(
//   //       color: kPrimaryColor,
//   //       borderRadius: BorderRadius.all(
//   //         Radius.circular(15),
//   //       ),
//   //     ),
//   //     child: Center(
//   //       child: Icon(
//   //         Icons.filter_list,
//   //         color: Colors.white,
//   //         size: 24,
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // List<Widget> buildFilters() {
//   //   List<Widget> list = [];
//   //   for (var i = 0; i < filters.length; i++) {
//   //     list.add(buildFilter(filters[i]));
//   //   }
//   //   return list;
//   // }
//
//   // Widget buildFilter(Filter filter) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       setState(() {
//   //         selectedFilter = filter;
//   //       });
//   //     },
//   //     child: Padding(
//   //       padding: EdgeInsets.only(right: 10),
//   //       child: Text(
//   //         filter.name,
//   //         style: TextStyle(
//   //           color: selectedFilter == filter ? kPrimaryColor : Colors.grey[300],
//   //           fontSize: 16,
//   //           fontWeight:
//   //               selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
