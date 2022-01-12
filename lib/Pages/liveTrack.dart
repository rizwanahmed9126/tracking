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
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveTrackingControl.dart';
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
import 'IconsUtils.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:flutter_map_marker_animation_example/Live_Location/LiveLocation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map_marker_animation_example/Live_Location/MyVehiclesLiveLocation.dart';


//const kMarkerId = MarkerId('MarkerId1');
const kDuration = Duration(seconds: 2);
List<LatLng> kLocations = [];
const kStartPosition = LatLng(24.859225931916384, 67.04996695200452);
enum Options { all, moving, parked, idle }

class LiveTrack extends StatefulWidget {
  final String carNumber;

  //final String endDateTime;
  final String vehicleId;

  LiveTrack({this.carNumber, this.vehicleId});

  static const String routeName = "historyreplay";

  @override
  LiveTrackState createState() => LiveTrackState();
}

class LiveTrackState extends State<LiveTrack>
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
  CarDetails carDetails;
  PolylineId id = PolylineId("poly2");

  _getPolyline() async {
    polylineCoordinates2.add(LatLng(carDetails.latitude, carDetails.longitude));
    _addPolyLine();
  }

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
      kLocations = polylineCoordinates2;
      stream = Stream.periodic(kDuration, (count) => carCoordinates[count])
          .take(carCoordinates.length);
    });
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

  Future getLiveData(BuildContext context, String vehId) async {
    await liveTracking(context, vehId).then((carData) {
      print(carData);
      if (carData == null) {
        print("Null data received at live tracking");
      } else {
        carDetails = carData;
        Provider.of<LiveTrackingControl>(context, listen: false)
            .newLocationUpdate(carDetails, 0, LatLng(0.0, 0.0),
                MarkerId('MarkerId1'), controller,context);
        _getPolyline();
      }
    });
  }

  TextEditingController _start = TextEditingController();
  TextEditingController _end = TextEditingController();
  var markerPlayerProv;
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    markerPlayerProv = Provider.of<LiveTrackingControl>(context, listen: false);
    prov = Provider.of<MarkerPlayerControl>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getAlertBoxOfCarList(
        withPicker: false,
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
        onDonePressed: (vehicleId, start, end) {
          setState(() {
            this.vehicleId = vehicleId;
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
          try {
            getLiveData(context, vehicleId).then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
              setState(() {
                showLoader = false;
              });
            });
          } catch (e) {
            print('Error: $e');
          }
        }));
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



  @override
  void dispose() {
    tabController.dispose();
    markerPlayerProv.resetAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
          return false;
        },
        child: SafeArea(
          child: Stack(children: [
            StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 3), (i) {
                  getLiveData(context, vehicleId);
                }),
                builder: (context, snapshot) {
                  return Consumer<LiveTrackingControl>(
                    builder: (context, data, _) {
                      return Animarker(
                        onStopover: (value) async {
                          if (value != null) {
                            double speed = 0.0;
                            speed = carDetails.speed == null
                                ? 0.0
                                : carDetails.speed;
                            var mId = MarkerId('${value.latitude} sss');
                            var marker2 = Marker(
                                icon: speed >= 55
                                    ? await IconUtils.createSpeedAlertImageFromAsset()
                                    : await IconUtils.createIdleMarkerImageFromAsset(),
                                markerId: mId,
                                position: value,
                                onTap: () {
                                  print('-----------------onTap pressed');
                                  // carDetails.forEach((element) {
                                  if (carDetails.latitude == value.latitude) {
                                    String registrationNumber = Provider.of<
                                            UserDetails>(context, listen: false)
                                        .vehicleids[Provider.of<UserDetails>(
                                                context,
                                                listen: false)
                                            .vehicleids
                                            .indexWhere((element) =>
                                                element.vehicleId.toString() ==
                                                vehicleId)]
                                        .vehicleRegistrationNumber;
                                    String s = carDetails.receiveDateTime;
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
                                    String seatBelt='';
                                    if(carDetails.seatBelt==false)
                                      seatBelt="Detached";
                                    else
                                      seatBelt="Attached";
                                    bottomSheet1(
                                        context:context,
                                        carNumber:registrationNumber,
                                        address:carDetails.referenceLocation,
                                        box1Text:carDetails.speed.toString(),
                                        box2Text:carDetails.temperatureStatus,
                                        box3Text: carDetails.vehicleStatus,
                                        text1:parts[0],
                                        text2:parts[1],
                                        text3:responseTime,
                                        text4:carDetails.alarmDetails,

                                        seatBelt:seatBelt,
                                        fuelLiters:carDetails.fuelStatus
                                    );
                                  }
                                  //});
                                });
                            if (carDetails.vehicleStatus != "Parked") {
                              //data.markers2[mId] = marker2;
                            }
                            // setState(() {
                            //carDetails.forEach((element) {
                            if (carDetails.latitude == value.latitude) {
                              String s = carDetails.receiveDateTime;
                              int idx = s.indexOf("T");
                              List parts = [
                                s.substring(0, idx).trim(),
                                s.substring(idx + 1).trim()
                              ];

                              dateTime = '${parts[0]} ${parts[1]}';

                              landMark = carDetails.referenceLocation;
                              vehicleStatus = carDetails.vehicleStatus;
                              speed2 = carDetails.speed.toString();
                            }
                            // });
                            // });
                          }
                        },
                        angleThreshold: 1,
                        shouldAnimateCamera: false,
                        isActiveTrip: true,
                        curve: Curves.linear,
                        rippleRadius: 0.0,
                        zoom: 18,
                        useRotation: true,
                        duration: Duration(milliseconds: 1800),

                        mapId:
                            controller.future.then<int>((value) => value.mapId),
                        markers: data.markers.values.toSet(),
                        //Grab Google Map Id
                        child: GoogleMap(
                            compassEnabled: true,
                            markers: data.markers2.values.toSet(),
                            buildingsEnabled: false,
                            zoomControlsEnabled: false,
                            polylines: Set<Polyline>.of(data.polylines.values),
                            initialCameraPosition: CameraPosition(
                                target: kStartPosition, zoom: 18,bearing: 3.0),
                            onMapCreated: (gController) {
                              _controller = gController;
                              controller.complete(gController);
                              //_controller.getZoomLevel();
                              changeMapMode();
                              //Complete the future GoogleMapController
                            }),
                      );
                    },
                  );
                }),
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
                                    builder: (context) => LiveTrack()));
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
                                  child: Image.asset(
                                    'assets/images/ic_car.png',
                                    height: 35.0,
                                    width: 35.0,
                                  ),
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
Widget bottomSheet1
    ({context,
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
  String fuelLiters}

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
                )
              ],
            ),
          ],
        );
      });
}