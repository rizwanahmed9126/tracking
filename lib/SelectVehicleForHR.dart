//import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/faltu.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawer.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'HistoryReplay/markerAnimation copy.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SelectVehicleForHR extends StatefulWidget {
  @override
  _SelectVehicleForHRState createState() => _SelectVehicleForHRState();
}

class _SelectVehicleForHRState extends State<SelectVehicleForHR> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _start = TextEditingController();
  TextEditingController _end = TextEditingController();
  String date;
  String time;

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: new Text(value)));
  }

  Future<Null> _selectDateTime1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2111),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.lightGreen,
              surface: Colors.lightGreen,
            ),
          ),
          child: child,
        );
      },
    );

    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        cancelText: (LocaleKeys.cancel.tr()),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child,
          );
        });

    if (picked_s != null && picked != null)
      setState(() {
        selectedTime = picked_s;
        selectedDate = picked;

        time = "${selectedTime.hour}:${selectedTime.minute}";
        date = "${selectedDate.toLocal()}".split(' ')[0];

        _start.text = '$date $time';
      });
  }

  Future<Null> _selectDateTime2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2111),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.green,
              surface: Colors.green,
            ),
          ),
          child: child,
        );
      },
    );

    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (picked_s != null && picked != null)
      setState(() {
        selectedTime = picked_s;
        selectedDate = picked;

        time = "${selectedTime.hour}:${selectedTime.minute}";
        date = "${selectedDate.toLocal()}".split(' ')[0];

        _end.text = '$date $time';
      });
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomDrawer(),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.green,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(top: size.width * 0.25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        right: size.width * 0.68,
                        top: 20,
                        bottom: size.width * 0.03),
                    child: Text(
                      LocaleKeys.search_vrn.tr(),
                      style: TextStyle(fontSize: 19, color: Colors.grey[700]),
                    )
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Provider.of<UserDetails>(context,listen: false).vehicleids.length,
                      itemBuilder: (context,i){
                      return   vehicleNumber(
                        context,
                        Provider.of<UserDetails>(context,listen: false).vehicleids[i].vehicleRegistrationNumber,
                            () {

                          _start.clear();
                          _selectDateTime1(context,);
                        },
                            () {
                          _end.clear();
                          _selectDateTime2(context,);
                        },
                            () {
                          print(_start.text);
                          print(_end.text);
                          if (_start.text.isEmpty && _end.text.isEmpty) {
                            showInSnackBar("the value can not be null");
                          } else {

                          }
                        },
                        _start,
                        _end,
                      );
                      }
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.2,
            child: Container(
              child: Text(
                LocaleKeys.history_reply.tr(),
                style: TextStyle(fontSize: 19,),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
                icon: Icon(Icons.menu),
                disabledColor: Colors.white,
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                }),
          ),
        ],
      ),
    );
  }
}

Widget vehicleNumber(
  BuildContext context,
  String carNumber,
  Function startPress,
  Function endPress,
  Function pushScreenPress,
  var start,
  var end,
) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SimpleMarkerAnimationExampleTesting(
        carNumber: carNumber,
        vehicleId: '29270',
      )));

    },
    child: Container(
      margin: EdgeInsets.only(top: 10),
      height: size.height * 0.07,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 9, spreadRadius: 2, color: Colors.grey[300])
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Text(
          carNumber,
          style: TextStyle(fontSize: 19),
        ),
      ),
    ),
  );
}

Widget showCustomTile(context, String title, double titlePadding,
    String hintText, var start, Function press, IconData icon) {
  Size size = MediaQuery.of(context).size;
  return Column(
    children: [
      SizedBox(
        height: size.height * 0.03,
      ),
      Container(
        margin: EdgeInsets.only(right: titlePadding),
        child: Text(title),
      ),
      SizedBox(
        height: size.height * 0.01,
      ),
      Container(
        height: size.height * 0.05,
        width: size.width * 0.55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          readOnly: true,
          onTap: press,
          controller: start,
          autofocus: false,
          decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                icon,
                color: Colors.green,
              ),
            ),
            contentPadding: EdgeInsets.only(bottom: 11),
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    ],
  );
}


class GoogleMaps1 extends StatefulWidget {
  const GoogleMaps1({Key key}) : super(key: key);

  @override
  _GoogleMaps1State createState() => _GoogleMaps1State();
}

class _GoogleMaps1State extends State<GoogleMaps1> {
  GoogleMapController mapController;

  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  double _originLatitude = 24.868772414921736, _originLongitude = 67.08584182270377;
  double _destLatitude = 24.870291386138554, _destLongitude = 67.03313796504295;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDDv4e_mpv99OiroZz7MKkGxcWPZ80vmn8";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
      width: 2
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        //wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
         );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}