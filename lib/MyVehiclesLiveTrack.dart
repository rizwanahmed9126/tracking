// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
// import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
// import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawerIcon.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
// class MyVehiclesLiveTrack extends StatefulWidget {
//    CarDetails carData;
//   //final String number;
//
//   MyVehiclesLiveTrack({
//    this.carData,
//     //this.number,
// });
//
//   @override
//   _MyVehiclesLiveTrackState createState() => _MyVehiclesLiveTrackState();
// }
//
// class _MyVehiclesLiveTrackState extends State<MyVehiclesLiveTrack> {
//
//   GoogleMapController _controller;
//   BitmapDescriptor pinLocationIcon;
//   Set<Marker> _marker={};
//
//   changeMapMode() {
//     getJsonFile("assets/light.json").then(setMapStyle);
//   }
//   Future<String> getJsonFile(String path) async {
//     return await rootBundle.loadString(path);
//   }
//   void setMapStyle(String mapStyle) {
//     _controller.setMapStyle(mapStyle);
//   }
//
//   //LatLng pinPosition = LatLng(widget.carData.latitude, widget.carData.longitude);
//
//   void setCustomMapPin() async {
//     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5),
//         'assets/images/ic_car.png');
//   }
//
//   @override
//   void initState() {
//
//     setCustomMapPin();
//     //Provider.of<LiveLocationOfSelectedCars>(context,listen: false).addCar(widget.carData);
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             markers: _marker,
//               initialCameraPosition:CameraPosition(
//                 target: LatLng(widget.carData.latitude, widget.carData.longitude),
//                 zoom: 15
//               ),
//             onMapCreated: (GoogleMapController controller){
//                 _controller=controller;
//
//
//                 changeMapMode();
//                 setState(() {
//                   _marker.add(Marker(
//                     markerId: MarkerId('${widget.carData.vehicleId}'),
//                     position: LatLng(widget.carData.latitude, widget.carData.longitude),
//                     icon: pinLocationIcon,
//                     infoWindow: InfoWindow(
//                       title: widget.carData.vehicleId.toString(),
//                     )
//
//                   ));
//                 });
//
//             },
//
//           ),
//           Positioned(
//             top: 20,
//               left: 10,
//               child: CustomDrawerIcon(
//                 iconPadding: IconButton(
//                   icon: Icon(Icons.clear),
//                   disabledColor: Colors.white,
//                   onPressed: (){
//                     Navigator.pop(context);
//                   },
//                 ),
//
//               )
//           )
//         ],
//       ),
//     );
//   }
// }
