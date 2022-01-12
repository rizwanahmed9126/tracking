import 'dart:async';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/VehicleParkedTime.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveTrackingControl.dart';
import 'package:flutter_map_marker_animation_example/Entities/loginPrefs.dart';
import 'package:flutter_map_marker_animation_example/Entities/markerPlayerControl.dart';
import 'package:flutter_map_marker_animation_example/Entities/searchCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/textSpeaker.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/MyVehiclesLiveTrack.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawerIcon.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomListTile.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/SearchBar.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/TextWithIcon.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/alertBox.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/historyReplayCarListAlert.dart';
import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/Pages/dashboard.dart';
import 'package:flutter_map_marker_animation_example/Pages/liveTrack.dart';
import 'package:flutter_map_marker_animation_example/Pages/markerAnimation.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import '../MyVehicles/MyVehicles.dart';
import 'package:flutter_map_marker_animation_example/SelectVehicleForHR.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/Pages/map.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:we_slide/we_slide.dart';
import 'package:flutter_map_marker_animation_example/Entities/voiceToTextConvertor.dart';
import 'package:flutter_map_marker_animation_example/Pages/loginLoadingScreen.dart';
import 'package:flutter_map_marker_animation_example/Pages/LoginPage.dart';
import '../HistoryReplay/markerAnimation copy.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  bool showVehicle;
  String vehicleId;

  HomePage({this.showVehicle = false, this.vehicleId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool loading = true;
  bool showLoading = true;
  List<CarDetails> carData = [];
  BitmapDescriptor pinLocationIcon;
  GoogleMapController _controller;
  bool isMapCreated = false;
  //List abc = [];
  List markersIdList = [];

  openInfoWindow() {
    print('Rec veh ID:------------${widget.vehicleId}');
    _controller.showMarkerInfoWindow(MarkerId(widget.vehicleId));
    int index = carData.indexWhere(
            (element) => element.vehicleId.toString() == widget.vehicleId);
    if (index < 0) {
      double lat = carData[index].latitude;
      double long = carData[index].longitude;
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, long), zoom: 20, bearing: 30.0)));
    }
  }

  changeMapMode() async {
    await getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  getAllCars(BuildContext context) async {

    print("-----------${widget.showVehicle}");
    if(!widget.showVehicle) {
      await getAllCarDetails(context).then((value) {
        if (value != null) {

          carData.clear();
          carData.addAll(value);
          Provider.of<LiveLocationOfSelectedCars>(context, listen: false).clearList();

          setState(() {
            loading = false;
            showLoading = false;
          });
        }
        carData.forEach((element) {
          getCarsOnMap(element);
        });
      });
    }
    else{
      await liveTracking(context, widget.vehicleId).then((value) {
        print('value------$value');
        if(value==null)
        {
          simpleAlertBox(context, Text(LocaleKeys.error.tr(),), Text(LocaleKeys.no_data_exist.tr(),),
                  () async {
                Navigator.pop(context);
                Navigator.pop(context);
                //pr.hide();
              });
        }
        else {
          carData.clear();
          carData.add(value);
          Provider.of<LiveLocationOfSelectedCars>(context, listen: false).clearList();
          setState(() {
            loading = false;
            showLoading = false;
          });
        }

        getCarsOnMap(carData.first);

      });
    }
  }


  getMarker(context) async {
    pinLocationIcon = await IconUtils.createMarkerImageFromAsset(context);
  }

  //var countProv;
  @override
  void initState() {
    getMarker(context);
    filterSearchList('All');
    getAllCars(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }

  getCarsOnMap(CarDetails abc) {
    Future.delayed(Duration.zero, () async {
      Provider.of<LiveLocationOfSelectedCars>(context, listen: false).addCar(abc);
    });
  }

  Map<MarkerId, Marker> markers1 = <MarkerId, Marker>{};

  String parked = 'Parked';
  String moving = 'Moving';
  String idle = 'Idle';

  final controller = ScrollController();


  int parkedCount = 0;
  int movingCount = 0;
  int idleCount = 0;
  int totalCount = 0;

  Color _totalColor = Color(0xff5f8633);
  Color _movingColor = Colors.transparent;
  Color _parkedColor = Colors.transparent;
  Color _idleColor = Colors.transparent;

  MapType _currentMapType = MapType.normal;

  void _toggleMapType(){
    setState(() {
      _currentMapType = (_currentMapType == MapType.normal) ? MapType.satellite : MapType.normal;
    });
  }


  //var list;
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Provider.of<LiveLocationOfSelectedCars>(context, listen: false)
            .clearList();
        if (widget.showVehicle) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RegisteredVehicles()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: CustomDrawer(),
        body: carData.isEmpty //showLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.lightGreen,
          ),
        )
            : Container(
          child: StreamBuilder(
            stream: Stream.periodic(Duration(minutes: 1),(i){
              print('stream builder refreshed');
              getAllCars(context);
            }),
            builder: (context, snapshot) {

              parkedCount=0;
              idleCount=0;
              movingCount=0;


              if (snapshot.hasError) {
              }
              return Consumer<LiveLocationOfSelectedCars>(
                builder: (context, data, _) {
                  // data.movingCount=0;
                  // data.parkedCount=0;
                  // data.idleCount=0;
                  if (data.cars.isNotEmpty) {

                    for (var i in data.cars) {
                      int index = Provider.of<UserDetails>(context, listen: false).vehicleids.indexWhere((element) => element.vehicleId == i.vehicleId);
                      if (parkedCount + movingCount + idleCount
                          < Provider.of<UserDetails>(context,listen: false).vehicleids.length) {

                        if (i.vehicleStatus == 'Parked') {
                          //data.parkedCount=data.parkedCount+1;
                          parkedCount = parkedCount + 1;
                        }

                        if (i.vehicleStatus == 'Moving') {
                          movingCount = movingCount + 1;

                          //data.movingCount=data.movingCount+1;

                        }

                        if (i.vehicleStatus == 'Idle') {

                          idleCount = idleCount + 1;
                          //data.idleCount=data.idleCount+1;


                        }
                      }


                      if (i.vehicleStatus == parked || i.vehicleStatus == moving || i.vehicleStatus == idle) {

                        final MarkerId markerId = MarkerId(i.vehicleId.toString());
                        var marker = Marker(
                            rotation: i.angle.toDouble(),
                            markerId: markerId,
                            position: LatLng(i.latitude, i.longitude),
                            icon: pinLocationIcon,
                            infoWindow: InfoWindow(
                                title: Provider.of<UserDetails>(context,
                                    listen: false)
                                    .vehicleids[index > -1 ? index : 0]
                                    .vehicleRegistrationNumber),
                            onTap: () {
                              //Splitting date from time
                              String s = i.receiveDateTime;
                              int idx = s.indexOf("T");
                              List parts = [
                                s.substring(0, idx).trim(),
                                s.substring(idx + 1).trim()
                              ];

                              //difference in minutes from serverTime and currentTime
                              String datetime = '${parts[0]} ${parts[1]}';
                              DateTime today = DateTime.now();
                              int convertedTime = today
                                  .difference(DateTime.parse(datetime))
                                  .inMinutes;
                              String responseTime =
                                  '${today.difference(DateTime.parse(datetime)).inMinutes.toString()} Minutes ago';


                              if (convertedTime > 59) {
                                print('i get into if-----------------------------------------');
                                double hours = convertedTime / 60.toInt();
                                int abc = hours.toInt();
                                responseTime = '${abc.toString()} Hours ago';
                              } else {
                                print('i get into else-----------------------------------------');
                                responseTime = responseTime;
                              }
                              //temperature=i.temperatureStatus;
                              bottomSheet(
                                  context,
                                  Provider.of<UserDetails>(context,
                                      listen: false)
                                      .vehicleids[index]
                                      .vehicleRegistrationNumber,
                                  i.referenceLocation,
                                  i.speed.toString(),
                                  i.temperatureStatus,
                                  i.vehicleStatus,
                                  parts[0],
                                  parts[1],
                                  responseTime,
                                  i.alarmDetails,
                                  i.seatBelt,
                                  i.fuelStatus
                              );
                            });
                        data.addMarker(marker, markerId);
                        // final GoogleMapController controlle = await _controller.;
                        //  _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(i.latitude,i.longitude),zoom:5,bearing: 30.0 )));
                      }
                      data.parkedCount = parkedCount;
                      data.movingCount = movingCount;
                      data.idleCount = idleCount;



                    }
                    print('provider value---parked ${data.parkedCount}');
                    print('provider value---moving ${data.movingCount}');
                    print('provider value---idle ${data.idleCount}');

                  }
                  //setState(() {

                  // });


                  return Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        child: GoogleMap(
                          markers: data.markers1.values.toSet(),
                          //markers.values.toSet(),
                          myLocationButtonEnabled: false,
                          myLocationEnabled: false,
                          zoomControlsEnabled: false,
                          mapType: _currentMapType,


                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                29.37305483237195, 69.4631413988821),
                            zoom: 5.0,
                          ),
                          onMapCreated: (GoogleMapController controller) async {
                            _controller = controller;
                            await changeMapMode();
                            if (widget.showVehicle) {
                              openInfoWindow();
                            }
                            isMapCreated = true;

                          },
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.05,
                        left: 15,
                        child: Container(
                          width: size.width,
                          child: Row(
                            children: [
                              Padding(
                                  padding:
                                  const EdgeInsets.only(right: 50),
                                  child: GestureDetector(
                                    onTap: () {
                                      scaffoldKey.currentState
                                          .openDrawer();
                                    },
                                    child: Container(
                                        height: size.height * 0.05,
                                        width: size.width * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          color: Color(0xff5f8633),
                                        ),
                                        child: Icon(
                                          FeatherIcons.alignLeft,
                                          color: Colors.black,
                                        )),
                                  )
                              ),
                              SizedBox(width: 5,),
                              Container(
                                child: Text(
                                  LocaleKeys.live_location.tr(),
                                  style: TextStyle(fontSize: 24),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: !widget.showVehicle?Container(
                          height: 105,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                ]),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black87,
                                  offset: Offset(16.0, 0.1),
                                  blurRadius: 60,
                                  spreadRadius: 90),
                            ],
                          ),
                          child:  Center(
                            child: Container(
                                height: 105,
                                width: size.width * 0.9,
                                child: ListView(
                                  controller: controller,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        filterSearchList('All');
                                        setState(() {
                                          moving = 'Moving';
                                          parked = 'Parked';
                                          idle = 'Idle';
                                          _totalColor = Color(0xff5f8633);
                                          _movingColor =
                                              Colors.transparent;
                                          _parkedColor =
                                              Colors.transparent;
                                          _idleColor = Colors.transparent;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: size.width * 0.27,
                                          height: size.height * 0.27,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 6),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.list,
                                                  size: 31,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  LocaleKeys.total.tr(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                    widget.showVehicle? carData.length.toString(): Provider.of<UserDetails>(context,listen: false).vehicleids.length.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                              color:
                                              _totalColor //Color(0xff5f8633)
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        filterSearchList('Moving');
                                        data.markers1.clear();
                                        setState(() {
                                          //abc.clear();
                                          markers1.clear();
                                          moving = 'Moving';
                                          parked = 'Moving';
                                          idle = 'Moving';
                                          _totalColor =
                                              Colors.transparent;
                                          _movingColor =
                                              Color(0xff5f8633);
                                          _parkedColor =
                                              Colors.transparent;
                                          _idleColor = Colors.transparent;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: size.width * 0.27,
                                          height: size.height * 0.27,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 6.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.local_taxi,
                                                  size: 31,
                                                  color: Colors.white,
                                                ),
                                                Text(LocaleKeys.moving.tr(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                                Text(
                                                    movingCount.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                              color: _movingColor),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        filterSearchList('Parked');
                                        data.markers1.clear();
                                        setState(() {
                                          //abc.clear();
                                          markers1.clear();
                                          moving = 'Parked';
                                          parked = 'Parked';
                                          idle = 'Parked';
                                          _totalColor =
                                              Colors.transparent;
                                          _movingColor =
                                              Colors.transparent;
                                          _parkedColor =
                                              Color(0xff5f8633);
                                          _idleColor = Colors.transparent;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: size.width * 0.27,
                                          height: size.height * 0.27,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                              color: _parkedColor),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 6.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 31,
                                                  color: Colors.white,
                                                ),
                                                Text(LocaleKeys.parked.tr(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                                Text(
                                                    parkedCount.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        //pr.show();
                                        filterSearchList('Idle');
                                        data.markers1.clear();
                                        setState(() {
                                          //abc.clear();
                                          markers1.clear();
                                          moving = 'Idle';
                                          parked = 'Idle';
                                          idle = 'Idle';
                                          _totalColor =
                                              Colors.transparent;
                                          _movingColor =
                                              Colors.transparent;
                                          _parkedColor =
                                              Colors.transparent;
                                          _idleColor = Color(0xff5f8633);
                                        }
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: size.width * 0.27,
                                          height: size.height * 0.27,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                              color: _idleColor),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 6.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.edit_location,
                                                  size: 31,
                                                  color: Colors.white,
                                                ),
                                                Text(LocaleKeys.idle.tr(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                                Text(
                                                    idleCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ):Text(''),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: BuildFloatingSearchBar(
                          controller: _controller,
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.22,
                        right: size.width*0.03,
                        child: Column(
                          children: [

                            GestureDetector(
                              onTap:(){
                                _toggleMapType();

                              },
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(32)),
                                  child: Center(
                                      child: Icon(
                                        Icons.map_sharp,color: Color(0xff5f8633),
                                        size: 27,
                                      ))),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  filterSearchList(String status) {
    final provider = Provider.of<UserDetails>(context, listen: false);
    if (status != 'All') {
      print(status);
      var list = carData.where((element) => element.vehicleStatus == status);
      List<Vehicleids> suggestion = [];
      list.forEach((element) {
        suggestion.add(provider.vehicleids[provider.vehicleids
            .indexWhere((p) => p.vehicleId == element.vehicleId)]);
      });

      Provider.of<SearchForCars>(context, listen: false).addList(suggestion);
    } else {
      Provider.of<SearchForCars>(context, listen: false).addList(
          Provider.of<UserDetails>(context, listen: false).vehicleids.toList());
    }
  }
}

class BuildFloatingSearchBar extends StatefulWidget {
  final GoogleMapController controller;

  BuildFloatingSearchBar({@required this.controller});

  @override
  _BuildFloatingSearchBarState createState() => _BuildFloatingSearchBarState();
}

class _BuildFloatingSearchBarState extends State<BuildFloatingSearchBar> {
  VoiceToText speech = VoiceToText();
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final buttonController = FloatingSearchBarController();
    //final provider = Provider.of<UserDetails>(context, listen: false);
    return FloatingSearchBar(
      borderRadius: BorderRadius.circular(22.0),
      elevation: 8.0,
      iconColor: Colors.grey[500],
      backdropColor: Colors.transparent,
      controller: buttonController,
      automaticallyImplyDrawerHamburger: false,
      automaticallyImplyBackButton: false,
      hintStyle: TextStyle(color: Color(0xff7EC049)),
      hint: LocaleKeys.search_vrn.tr(),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 750),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? size.width * 0.9 : 250,
      debounceDelay: const Duration(milliseconds: 500),
      actions: [
        AvatarGlow(
          animate: isListening,
          glowColor: Color(0xff87a564),
          endRadius: 28.0,
          duration: Duration(milliseconds: 1000),
          repeat: true,
          child: IconButton(
              onPressed: () {
                if (!isListening) {
                  speech.checkIfAvailable().then((value) async {
                    await speech.listenVoice((recogniseWords) {
                      if (value) {
                        setState(() {
                          isListening = true;
                        });
                        setState(() {
                          buttonController.open();
                          buttonController.query = recogniseWords;
                          if (recogniseWords.isNotEmpty) {
                            isListening = false;
                          }
                        });
                      }
                    });
                  });
                } else {
                  setState(() {
                    isListening = false;
                    speech.stop();
                  });
                }
              },
              icon: Icon(
                isListening ? FeatherIcons.mic : FeatherIcons.mic,
                color: Color(0xff7EC049),
              )),
        )
      ],
      onQueryChanged: (query) {
        print(Provider.of<SearchForCars>(context, listen: false).cars);
        if (query.isEmpty) {
          Provider.of<SearchForCars>(context, listen: false).clearSuggestions();
        } else {
          Provider.of<SearchForCars>(context, listen: false).addSuggestionList(
              Provider.of<SearchForCars>(context, listen: false)
                  .cars
                  .where((element) => element.vehicleRegistrationNumber
                  .contains(RegExp(query, caseSensitive: false)))
                  .toList());
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return Consumer<SearchForCars>(
          builder: (context, data, _) {
            return Container(
                height: 200.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: data.suggestionList.isNotEmpty
                    ? ListView.builder(
                    itemCount: data.suggestionList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          buttonController.close();
                          int abc = Provider.of<LiveLocationOfAllCars>(
                              context,
                              listen: false)
                              .cars
                              .indexWhere((element) =>
                          element.vehicleId ==
                              data.suggestionList[index].vehicleId);
                          if (abc >= 0) {
                            double lat = Provider.of<LiveLocationOfAllCars>(
                                context,
                                listen: false)
                                .cars[abc]
                                .latitude;
                            double long =
                                Provider.of<LiveLocationOfAllCars>(context,
                                    listen: false)
                                    .cars[abc]
                                    .longitude;
                            LatLng latLng = LatLng(lat, long);
                            CameraPosition pos =
                            CameraPosition(target: latLng, zoom: 12);
                            widget.controller.animateCamera(
                                CameraUpdate.newCameraPosition(pos));
                            widget.controller.showMarkerInfoWindow(MarkerId(
                                Provider.of<LiveLocationOfAllCars>(context,
                                    listen: false)
                                    .cars[abc]
                                    .vehicleId
                                    .toString()));
                          }
                          //data.clearList();
                        },
                        trailing: Icon(
                          Icons.my_location,
                          color: Colors.lightGreen,
                        ),
                        title: Text(
                          data.suggestionList[index]
                              .vehicleRegistrationNumber,
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                        subtitle: Text(
                          data.suggestionList[index].vehicleId.toString(),
                          style: GoogleFonts.poppins(fontSize: 16.0),
                        ),
                      );
                    })
                    : Center(
                  child: Text(
                      LocaleKeys.no_search_items.tr(),
                    style: GoogleFonts.poppins(
                        fontSize: 16.0, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ),
                ));
          },
        );
      },
    );
  }
}

Widget bottomSheet(
    context,
    String carNumber,
    String address,
    String box1Text,
    String box2Text,
    String box3Text,
    String text1,
    String text2,
    String text3,
    String text4,
    bool seatBelt,
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
                  '$carNumber (Self)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                    child: Text(
                      '$address',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
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
                        )

                        ),
                        customTile(box3Text,Icon(Icons.vpn_key)),
                        customTile(box2Text,Icon(Icons.thermostat_outlined)),
                        customTile('$seatBelt', iconImage('assets/seat.png'),),


                        customTile(fuelLiters, iconImage('assets/fuel.png'),),
                        customTile('---', Icon(Icons.group),),

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

Widget customTile(String data, Widget icon,
    //IconData icon, String iconText
    ) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      //height: 100,
      //width: 120,
      decoration: BoxDecoration(
          color: Color(0xffD6E8C8), borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              data,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            icon

          ],
        ),
      ),
    ),
  );
}

Widget tile(
    context, IconData icon1, IconData icon2, String text1, String text2) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: 60,
    width: size.width, //* 0.68,
    decoration: BoxDecoration(
        color: Color(0xffD6E8C8), borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWithIcon(
            icon: icon1,
            text: text1,
            textColor: Colors.black,
          ),
          TextWithIcon(
            icon: icon2,
            text: text2,
            textColor: Colors.black,
          )
        ],
      ),
    ),
  );
}
Widget iconImage(String iconPath){
  return  ImageIcon(
    AssetImage(iconPath),
    size: 23,
  );
}