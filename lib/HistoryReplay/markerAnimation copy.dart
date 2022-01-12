import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_animarker/infrastructure/interpolators/angle_interpolator_impl.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/markerPlayerControl.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/TextWithIcon.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/alertBox.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/historyReplayCarListAlert.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/loadingContainer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/makerPlayer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/Pages/dashboard.dart';
import 'package:flutter_map_marker_animation_example/SelectVehicleForHR.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/main.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:polyline/polyline.dart' as PolyLine;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
//import 'package:segment_display/segment_display.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../Pages/IconsUtils.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:flutter_map_marker_animation_example/Live_Location/LiveLocation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map_marker_animation_example/Live_Location/MyVehiclesLiveLocation.dart';

const kDuration = Duration(seconds: 2);
List<LatLng> kLocations = [];
const kStartPosition = LatLng(24.859225931916384, 67.04996695200452);
enum Options { all, moving, parked, idle }

class SimpleMarkerAnimationExampleTesting extends StatefulWidget {
  final String carNumber;

  //final String endDateTime;
  final String vehicleId;

  SimpleMarkerAnimationExampleTesting({this.carNumber, this.vehicleId});

  static const String routeName = "historyreplay";

  @override
  SimpleMarkerAnimationExampleTestingState createState() =>
      SimpleMarkerAnimationExampleTestingState();
}

class SimpleMarkerAnimationExampleTestingState
    extends State<SimpleMarkerAnimationExampleTesting>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic kStartPosition = LatLng(30.509889, 68.985478);
  dynamic kSantoDomingo;
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  Stream<CarLocationDetails> stream;
  var streamSub, progress;
  bool isNotPaused = true;
  List<LatLng> polylineCoordinates2 = [];
  GoogleMapController _controller;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String date;
  String time;
  var prov;

  Map<PolylineId, Polyline> polylines = {};
  bool mapToogle = false;
  List<int> angles = [];
  bool showLoader = true;
  String vehicleId;
  int arrayI = 0;
  PolylinePoints polylinePoints = PolylinePoints();

  _getPolyline() async {
    polylineCoordinates2.clear();
    for (var data in carCoordinates) {
      polylineCoordinates2.add(LatLng(data.latitude, data.longitude));
    }
    polylineCoordinates2.forEach((element) {});
    _addPolyLine();
  }

  String encodeCoordinatedIntoString() {
    PolyLine.Polyline poly;
    List<List<double>> points = [];
    polylineCoordinates2.forEach((value) {
      points.add([value.latitude, value.longitude]);
    });
    poly = PolyLine.Polyline.Encode(decodedCoords: points, precision: 5);
    return poly.encodedString;
  }

  PolylineId id = PolylineId("poly2");

  _addPolyLine() {
    if (kIsWeb) {
      //PolyLine.Polyline poly;
      //String encodedPolyLines = encodeCoordinatedIntoString();
      //polylineCoordinates2 = decodeEncodedPolyline(encodedPolyLines);
    }
    Polyline polyline = Polyline(
        width: 6,
        polylineId: id,
        color: Colors.green[300],
        points: polylineCoordinates2);

    mapToogle = true;
    //getCabIcon();
    // if (this.mounted) {
    setState(() {
      polylines[id] = polyline;
      kLocations.clear();
      kLocations = polylineCoordinates2;
      //stream=Stream.fromIterable(carCoordinates).take(carCoordinates.length);
      stream = Stream.periodic(kDuration, (count) => carCoordinates[count])
          .take(carCoordinates.length);
    });
    // }
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  TextEditingController _start = TextEditingController();
  TextEditingController _end = TextEditingController();
  var markerPlayerProv;
  TabController tabController;
  bool showTruck=false;
  @override
  void initState() {
    Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount=0;
    tabController = TabController(length: 2, vsync: this);
    markerPlayerProv = Provider.of<MarkerPlayerControl>(context, listen: false);
    prov = Provider.of<MarkerPlayerControl>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getAlertBoxOfCarList(
        context: context,
        controller: tabController,
        startChange: (value) {
          _start.text = value.toString();
          print(_start.text);
        },
        endChange: (value) {
          _end.text = value.toString();
          print(_end.text);
        },
        onDonePressed: (vehicleId, start, end) async {
          setState(() {
            this.vehicleId = vehicleId;
            this._start.text = start;
            this._end.text = end;

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ProgressDialog1(
                    message: LocaleKeys.loading.tr(),
                  );
                });
          });

          print(vehicleId);
          if (_start.text.isEmpty && _end.text.isEmpty) {
            showInSnackBar("the value can not be null");
          } else {
            print('this is start ${_start.text}');
            print('this is start ${_end.text}');
            Provider.of<MarkerPlayerControl>(context, listen: false)
                .clearMakerList();
            Provider.of<MarkerPlayerControl>(context, listen: false)
                .markers2
                .clear();
            Navigator.pop(context);
            //_selectDateTime1(context);
            try {
              kSantoDomingo = CameraPosition(
                  target: kStartPosition, zoom: 10, bearing: 30.0);
              gethistorydata(_start.text, _end.text, vehicleId)
                  .then((value) async {
                if (value.length > 0) {
                  carCoordinates.clear();
                  carCoordinates.addAll(value);
                  _getPolyline();
                  prov.updateCameraPosition(
                      CameraPosition(
                          target: LatLng(carCoordinates[0].latitude,
                              carCoordinates[0].longitude),
                          zoom: 10,
                          bearing: 30.0),
                      controller);
                  var marker = Marker(
                      flat: true,
                      //rotation: 90,
                      icon: await IconUtils.createMarkerImageFromAsset(context),
                      markerId: MarkerId('MarkerId1'),
                      position:
                          LatLng(value.first.latitude, value.first.longitude),
                      //LatLng(latLng.latitude,latLng.longitude),
                     // anchor: Offset(0.6, 0.5),
                     // zIndex: 1,
                      // ripple: true,
                      onTap: () {});
                  prov.addMarker(MarkerId('MarkerId1'), marker);
                  prov.addCarCoordinates(carCoordinates);
                  setState(() {
                    showLoader = false;
                  });
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text(
                                LocaleKeys.no_data_exist.tr(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0, color: Color(0xff5E8633)),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SimpleMarkerAnimationExampleTesting()));
                                  },
                                  child: Text(
                                    'Go to car selection',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                        color: Colors.black.withOpacity(0.7)),
                                  ))
                            ],
                          ));
                  // setState(() {
                  //   showLoader = false;
                  // });
                }
                //prog.dismiss();
              });
            } catch (e) {
              setState(() {
                showLoader = false;
              });
              print('Error $e');
            }
          }
        }));
    if (Provider.of<UserDetails>(context, listen: false).gname ==
        "Malik Associates (C&amp;B)" ||
        Provider.of<UserDetails>(context, listen: false).gname ==
            "MALIK ASSOCIATE" ||
        Provider.of<UserDetails>(context, listen: false).gname ==
            "Noor Ahmed Water Tanker") {
      showTruck = true;
    }
  }

  String landMark = ' ';
  String dateTime = '';
  String vehicleStatus;
  String speed2 = '';
  String showTime = '';

  bool visible = false;
  int timeValue = 0;

  bool playSelected = false;
  bool pauseSelected = false;
  bool resumeSelected = false;
  double startCountValue=0.0;

  @override
  void dispose() {
    print('dispose called');
    tabController.dispose();
    markerPlayerProv.resetAll();
    super.dispose();
  }

  double _speedValue=0;
  int speed;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          markerPlayerProv.resetAll();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
          return false;
        },
        child: SafeArea(
          child: Stack(children: [
            Consumer<MarkerPlayerControl>(
              builder: (context, data, _) {
                return Animarker(
                  ///stop over method
                  onStopover: (value) async {
                    double speed=0.0;
                    int index = carCoordinates.indexWhere((element) => element.latitude==value.latitude);
                    if(index>=0){
                      speed = carCoordinates[index].speed;
                    }
                    var mId = MarkerId('${value.latitude} sss');
                    var marker2 = Marker(
                        icon:  speed>=55?await IconUtils.createSpeedAlertImageFromAsset():await IconUtils.createIdleMarkerImageFromAsset(),
                        markerId: mId,
                        position: value,
                        onTap: () {
                          carCoordinates.forEach((element) {
                            if (element.latitude == value.latitude) {
                              String registrationNumber =
                                  Provider.of<UserDetails>(context,
                                          listen: false)
                                      .vehicleids[Provider.of<UserDetails>(
                                              context,
                                              listen: false)
                                          .vehicleids
                                          .indexWhere((element) =>
                                              element.vehicleId.toString() ==
                                              vehicleId)]
                                      .vehicleRegistrationNumber;
                              String s = element.receiveDateTime;
                              int idx = s.indexOf("T");
                              List parts = [
                                s.substring(0, idx).trim(),
                                s.substring(idx + 1).trim()
                              ];

                              //difference in minutes from serverTime and currentTime
                              String datetime = '${parts[0]} ${parts[1]}';
                              DateTime today = DateTime.now();
                              String responseTime =
                                  '${today.difference(DateTime.parse(datetime)).inMinutes.toString()} Minutes ago';
                              String temperature = '${0}';

                              // String seatBelt='';
                              // if(i.seatBelt==false)
                              //   seatBelt="Detached";
                              // else
                              //   seatBelt="Attached";
                              bottomSheet2(
                                  context,
                                  registrationNumber,
                                  element.referenceLocation,
                                  element.speed.toString(),
                                  element.temperatureStatus,
                                  element.vehicleStatus,
                                  parts[0],
                                  parts[1],
                                  responseTime,
                                  element.alarmDetails,
                                element.temperatureStatus,
                                element.fuelStatus,
                              );
                            }
                          });
                        });
                    if (carCoordinates[carCoordinates.indexWhere((element) =>
                                element.latitude == value.latitude)]
                            .vehicleStatus !=
                        "Parked") {
                      data.markers2[mId] = marker2;
                    }
                    setState(() {
                      carCoordinates.forEach((element) {
                        if (element.latitude == value.latitude) {
                          String s = element.receiveDateTime;
                          int idx = s.indexOf("T");
                          List parts = [
                            s.substring(0, idx).trim(),
                            s.substring(idx + 1).trim()
                          ];

                          dateTime = '${parts[0]} ${parts[1]}';

                          landMark = element.referenceLocation;
                          vehicleStatus = element.vehicleStatus;
                          speed2 = element.speed.toString();
                          _speedValue=element.speed;
                          if(startCountValue<carCoordinates.length)
                          {
                            Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount+=1;
                            startCountValue+=1;
                          }




                           //speed=int.parse(_speedValue);_speedValue.toInt();
                        }
                      });
                    });
                  },
                  angleThreshold: 15,
                  shouldAnimateCamera: false,
                  isActiveTrip: true,
                  curve: Curves.linear,
                  rippleRadius: 0.0,
                  zoom: 10,
                  useRotation: true,
                  duration: Duration(milliseconds: 1800),
                  mapId: controller.future.then<int>((value) => value.mapId),
                  markers: data.markers.values.toSet(),
                  //Grab Google Map Id
                  child: GoogleMap(
                      compassEnabled: true,
                      markers: data.markers2.values.toSet(),
                      buildingsEnabled: false,
                      zoomControlsEnabled: false,
                      polylines: Set<Polyline>.of(polylines.values),
                      initialCameraPosition: CameraPosition(
                          target: kStartPosition, zoom: 10, bearing: 3.0),
                      onMapCreated: (gController) {
                        _controller = gController;
                        controller.complete(gController);
                        changeMapMode();
                        //Complete the future GoogleMapController
                      }),
                );
              },
            ),
            Positioned(
              top: 70,
              left: MediaQuery.of(context).size.width*0.33,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 75,//MediaQuery.of(context).size.height * 0.35,
                  width: 75,//MediaQuery.of(context).size.width,
                  child: Center(child: _getRadialGauge(context,_speedValue)),
                ),
              ),
            ),

            !showLoader
                ? Visibility(
                    visible: true,
                    child: Positioned(
                      top: MediaQuery.of(context).size.height * 0.66,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        height: 90,
                        width: double.infinity,
                        //MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                            boxShadow: []),
                        child: Column(
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${LocaleKeys.near_to.tr()} : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        height: 20,
                                        width: 247,
                                        child: Text(
                                          ' $landMark',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${LocaleKeys.at_speed.tr()} : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('$speed2 km/h')
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${LocaleKeys.DateTime.tr()} : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('$dateTime'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Text(' '),
            !showLoader
                ? MarkerPlayerButtons(
                    controller: controller,
              //runTimeValue: Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount,
                  )
                : Text(' '),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                          child: Icon(
                        FeatherIcons.alignLeft,
                        color: Color(0xff5E8633),
                        size: 20.0,
                      )),
                    ),
                  ),
                  !showLoader
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SimpleMarkerAnimationExampleTesting()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Provider.of<UserDetails>(context,
                                          listen: false)
                                      .vehicleids[Provider.of<UserDetails>(
                                              context,
                                              listen: false)
                                          .vehicleids
                                          .indexWhere((element) =>
                                              element.vehicleId.toString() ==
                                              vehicleId)]
                                      .vehicleRegistrationNumber,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff5E8633),
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child: showTruck
                                      ? RotatedBox(
                                    quarterTurns: 9,
                                        child: Image.asset(
                                    'assets/images/truckMarker.png',
                                          height: 80.0,
                                          width: 80.0,
                                  ),
                                      )
                                      : Image.asset('assets/images/ic_car.png',height: 40.0,width: 40.0,),
                                )
                              ],
                            ),
                          ),
                        )
                      : Text(' ')
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: new Text(value)));
  }
}


Widget _getRadialGauge(context,double _value) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.45,
    width: MediaQuery.of(context).size.width * 0.78,
    child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
        GaugeRange(
            startValue: 0,
            endValue: 50,
            color: Colors.lightGreen[300],
            startWidth: 6,
            endWidth: 6),
        GaugeRange(
            startValue: 50,
            endValue: 100,
            color: Colors.green[400],
            startWidth: 6,
            endWidth: 6),
        GaugeRange(
            startValue: 100,
            endValue: 150,
            color: Color(0xff5E8633),
            startWidth: 6,
            endWidth: 6)
      ], pointers: <GaugePointer>[
        NeedlePointer(
            value: _value??0,
            needleLength: 0.85,
            enableAnimation: true,
            animationType: AnimationType.ease,
            needleStartWidth: 1.5,
            needleEndWidth: 4,
            needleColor: Colors.black.withOpacity(0.5),

            knobStyle:
            KnobStyle(knobRadius: 0.09, sizeUnit: GaugeSizeUnit.factor))
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Padding(
              padding: const EdgeInsets.only(top: 30,),
              child: Container(
                  child: Center(
                    child:
                    Text('$_value',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)
                    ),
                  )),
            ),
            angle: 90,
            positionFactor: 0.5)
      ])
    ]),
  );
}


LatLng calculateIntermediatePoint(LatLng point1, LatLng point2, double perc) {
//const φ1 = this.lat.toRadians(), λ1 = this.lon.toRadians();
//const φ2 = point.lat.toRadians(), λ2 = point.lon.toRadians();
  double lat1 = degreesToRadians(point1.latitude);
  double lng1 = degreesToRadians(point1.longitude);
  double lat2 = degreesToRadians(point2.latitude);
  double lng2 = degreesToRadians(point2.longitude);

//const Δφ = φ2 - φ1;
//const Δλ = λ2 - λ1;
  double deltaLat = lat2 - lat1;
  double deltaLng = lng2 - lng1;

//const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) + Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ/2) * Math.sin(Δλ/2);
//const δ = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  double calcA = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
  double calcB = 2 * atan2(sqrt(calcA), sqrt(1 - calcA));

//const A = Math.sin((1-fraction)δ) / Math.sin(δ);
//const B = Math.sin(fractionδ) / Math.sin(δ);
  double A = sin((1 - perc) * calcB) / sin(calcB);
  double B = sin(perc * calcB) / sin(calcB);

//const x = A * Math.cos(φ1) * Math.cos(λ1) + B * Math.cos(φ2) * Math.cos(λ2);
//const y = A * Math.cos(φ1) * Math.sin(λ1) + B * Math.cos(φ2) * Math.sin(λ2);
//const z = A * Math.sin(φ1) + B * Math.sin(φ2);
  double x = A * cos(lat1) * cos(lng1) + B * cos(lat2) * cos(lng2);
  double y = A * cos(lat1) * sin(lng1) + B * cos(lat2) * sin(lng2);
  double z = A * sin(lat1) + B * sin(lat2);

//const φ3 = Math.atan2(z, Math.sqrt(xx + yy));
//const λ3 = Math.atan2(y, x);
  double lat3 = atan2(z, sqrt(x * x + y * y));
  double lng3 = atan2(y, x);

//const lat = φ3.toDegrees();
//const lon = λ3.toDegrees();
  return LatLng(radiansToDegrees(lat3), radiansToDegrees(lng3));
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double radiansToDegrees(double radians) {
  return radians * (180 / pi);
}
Widget bottomSheet2
    (context,
  String carNumber,
  String address,
  String box1Text,
  String box2Text,
  String box3Text,
  String text1,
  String text2,
  String text3,
  String text4,
  String seatBelt,
  String fuelLiters

    ) {
  Size size = MediaQuery.of(context).size;

  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          direction: Axis.horizontal,
          children: [
            Column(
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 5,
                    width: size.width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(22)),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 6,
                  child: Container(
                    //height: 200,
                    // width: 200,
                      child: Image.asset('assets/images/ic_car.png',
                          height: size.height * 0.2, fit: BoxFit.fill)),
                ),
                Text(
                  '$carNumber',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                  child: Container(
                      child: Text(
                        '$address',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23,right: 23,top: 8.0),
                  child: Container(

                    width: size.width*0.9,
                    child: GridView.count(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: (0.3 / 0.24),
                      children: [
                        customTile(box1Text, TextWithIcon(
                          icon: Icons.speed,
                          text: 'km/h',
                          textColor: Colors.black,
                          iconSize: 16,
                          fontSize: 13,
                        ),
                            'Speed'

                        ),
                        customTile(box3Text,Icon(Icons.vpn_key,size: 13,),'Status'),
                        customTile(box2Text,Icon(Icons.thermostat_outlined,size: 13,),'Temperature'),
                        customTile('$seatBelt', iconImage('assets/seat.png'),'Seat Belt'),


                        customTile(fuelLiters, iconImage('assets/fuel.png',),'Fuel'),
                        customTile('---', Icon(Icons.group,size: 13,),'Group'),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 23,
                    left: 23,
                    top: 10,
                  ),
                  child: tile(context, Icons.calendar_today_rounded,
                      Icons.access_time, text1, text2),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 23, left: 23, top: 10, bottom: 10),
                  child: tile(context, Icons.timer, Icons.update, text3, text4),
                ),
                // Container(
                //   height: 60,
                //   width: size.width, //* 0.68,
                //   decoration: BoxDecoration(
                //       color: Color(0xffD6E8C8), borderRadius: BorderRadius.circular(12)),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 10.0,right: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         TextWithIcon(
                //           icon: icon1,
                //           text: text1,
                //           textColor: Colors.black,
                //         ),
                //         TextWithIcon(
                //           icon: icon2,
                //           text: text2,
                //           textColor: Colors.black,
                //         )
                //       ],
                //     ),
                //   ),
                // )



              ],
            ),
          ],
        );
      });
}

Widget customTile(String data, Widget icon,String name
    //IconData icon, String iconText
    ) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      //height: 100,
      //width: 120,
      decoration: BoxDecoration(
          color: Color(0xffD6E8C8), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Text(data, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            icon,
            Text('$name',style: TextStyle(fontSize: 12),)

          ],
        ),
      ),
    ),
  );
}
