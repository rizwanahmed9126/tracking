import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/DriveTimeMonitor/DriveTimeMonitor.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryReports.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/searchCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/MyVehicles/CarList.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/TextWithIcon.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/historyReplayCarListAlert.dart';
import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
import 'package:flutter_map_marker_animation_example/Pages/Last24HourReport.dart';
import 'package:flutter_map_marker_animation_example/Pages/LoginPage.dart';
import 'package:flutter_map_marker_animation_example/Pages/SelectSpeedVehicle.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/Pages/Setting.dart';
import 'package:flutter_map_marker_animation_example/Pages/liveTrack.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';

// import 'package:i18n_extension/i18n_widget.dart';
// import 'package:mailer2/mailer.dart';
import 'MyVehicles/MyVehicles.dart';
import 'package:flutter_map_marker_animation_example/Pages/tripMonitoringScreen.dart';
import 'package:flutter_map_marker_animation_example/SelectVehicleForHR.dart';
import 'package:flutter_map_marker_animation_example/main.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
import 'package:flutter_map_marker_animation_example/widgets/PromotionBar.dart';
import 'package:flutter_map_marker_animation_example/widgets/HomeTile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map_marker_animation_example/widgets/Title.dart';
import 'package:flutter_map_marker_animation_example/Pages/Profile.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'HistoryReplay/markerAnimation copy.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_map_marker_animation_example/Live_Location/LiveLocation.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  String tag;

  Home({this.tag});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController _controller;
  bool isMapCreated = false;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool loading = true;

  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  Map<MarkerId, Marker> markers1 = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;

  List<CarDetails> carData = [];
  List<HistoryReport> historyDataCollection = [];

  var temprature = " ";
  var weather = " ";
  var cityName = " ";
  var image = "assets/weather.png";
  var day = " ", date = " ";

  getWeatherData() async {
    var weatherData = await getWeatherDetails();
    if (weatherData != null) {
      setState(() {
        double val = weatherData['main']['temp'];
        int val2 = val.round();
        temprature = val2.toString();
        weather = weatherData['weather'][0]['main'];
        cityName = weatherData['name'];
        if (weather == "Clouds") {
          image = "assets/cloudy.png";
          weather = weather + ",\n" + weatherData['weather'][0]['description'];
        } else if (weather == "Haze") {
          image = "assets/hazeWeather.png";
          weather = weather + ",\n" + weatherData['weather'][0]['description'];
        }

        DateTime now = DateTime.now();
        int weekDay = now.weekday;
        day = weekDay == 1
            ? "Mon"
            : weekDay == 2
                ? "Tue"
                : weekDay == 3
                    ? "Wed"
                    : weekDay == 4
                        ? "Thu"
                        : weekDay == 5
                            ? "Fri"
                            : weekDay == 6
                                ? "Sat"
                                : "Sun";
        date = now.day.toString();
      });
    }
  }

  getAllCars(BuildContext context) async {
    await getAllCarDetails(context).then((value) {
      getWeatherData();
      if (value != null) {
        carData.addAll(value);
        Provider.of<LiveLocationOfAllCars>(context, listen: false)
            .addReferenceList(value);
        setState(() {
          loading = false;
        });
      }
      carData.forEach((element) {
        getCarsOnMap(element);
      });
      //getCarsOnMap(abc);
    });
  }

  getCarsOnMap(var abc) {
    Future.delayed(Duration.zero, () async {
      Provider.of<LiveLocationOfAllCars>(context, listen: false).addCar(abc);
    });
  }

  getMarker() async {
    pinLocationIcon = await IconUtils.createMarkerImageFromAsset(context);
  }

  getCarStatus() async {
    await getAllCarStatus(context).then((value) {
      if (value != null) {
        if (Provider.of<UserDetails>(context, listen: false).loadCarsFirstTime) {
          Provider.of<UserDetails>(context, listen: false).loadCarsFirstTime = false;
          setState(() {
            //showLoader = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    getMarker();
    getAllCars(context);

    if (Provider.of<UserDetails>(context, listen: false).gname ==
        "Malik Associates (C&amp;B)" ||
        Provider.of<UserDetails>(context, listen: false).gname ==
            "MALIK ASSOCIATE" ||
        Provider.of<UserDetails>(context, listen: false).gname ==
            "Noor Ahmed Water Tanker") {
      //showTruck = true;
      StaticClass.showTruck=true;
    }

    getCarStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPopGoToLogIn() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(LocaleKeys.confirmation.tr(),
                  style: new TextStyle(color: Colors.black, fontSize: 20.0)),
              content:
                  new Text('Do you want to exit'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () async {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    // Provider.of<UserDetails>(context, listen: false)
                    //     .vehicleids
                    //     .clear();
                    // Provider.of<LiveLocationOfAllCars>(context, listen: false)
                    //     .cars
                    //     .clear();
                    // Provider.of<LiveLocationOfAllCars>(context, listen: false)
                    //     .cars
                    //     .clear();
                    // Provider.of<SearchForCars>(context, listen: false)
                    //     .cars
                    //     .clear();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: new Text('Yes',
                      style: new TextStyle(fontSize: 18.0)),
                ),
                new FlatButton(
                  onPressed: () => Navigator.pop(context),
                  // this line dismisses the dialog
                  child: new Text(LocaleKeys.cancel.tr(),
                      style: new TextStyle(fontSize: 18.0)),
                )
              ],
            ),
          ) ??
          false;
    }

    final ProgressDialog pr = ProgressDialog(context);
    pr.style(message: LocaleKeys.loading.tr());

    if (isMapCreated) {
      changeMapMode();
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height * 0.51) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        drawer: CustomDrawer(),
        key: _key,
        backgroundColor: Color(0xfff2f5f8),
        body: WillPopScope(
          onWillPop: onWillPopGoToLogIn,
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
            decoration: BoxDecoration(
              color: Color(0xfff2f5f8),
            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            //alignment: Alignment.centerLeft,
                            height: size.height * 0.05,
                            child: Hero(
                                tag: widget.tag ?? "a",
                                child: Image.asset('assets/trans-anim3.gif')),
                          ),
                        ),
                      ],
                    ),

                    PromotionBar(),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          crossAxisSpacing: 9,
                          mainAxisSpacing: 9,
                          childAspectRatio: (itemWidth / itemHeight),
                          //padding: EdgeInsets.only(top: 8),

                          children: [
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisteredVehicles()));
                              },
                              title:
                                  '${LocaleKeys.my_vehicles.tr()}: ${Provider.of<UserDetails>(context, listen: false).vehicleids.length.toString()}',
                              imagePath: 'assets/Icons-09.png',
                            ),
                            HomeTile(
                              colors: Colors.white.withOpacity(0.6),
                              height: size.height * 0.09,
                              press: () async {
                                //await pr.show();
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                              },
                              title: LocaleKeys.live_location.tr(),
                              imagePath: 'assets/Icons-01.png',
                            ),
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SimpleMarkerAnimationExampleTesting()));
                              },
                              title: LocaleKeys.history_reply.tr(),
                              imagePath: 'assets/Icons-02.png',
                            ),
                            HomeTile(
                              colors: Colors.white.withOpacity(0.6),
                              height: size.height * 0.09,
                              press: () async {
                                //Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomDropdown(text: 'select',)));
                              },
                              title: LocaleKeys.alerts.tr(),
                              imagePath: 'assets/Icons-05.png',
                            ),
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Last24HoursReport()));
                              },
                              title: LocaleKeys.trip_monitor.tr(),
                              imagePath: 'assets/Icons-03.png',
                            ),
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LiveTrack()));
                              },
                              title: LocaleKeys.live_tracking.tr(),
                              imagePath: 'assets/Icons-04.png',
                            ),
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                showReports(context);
                              },
                              title: LocaleKeys.reports.tr(),
                              imagePath: 'assets/Icons-08.png',
                            ),
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                driveTimeMonitor(context);
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
                              },
                              title: 'Drive Time Monitor',
                              imagePath: 'assets/Icons-06.png',
                            ),
                            HomeTile(
                              colors: Colors.white,
                              height: size.height * 0.09,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              title: LocaleKeys.profile.tr(),
                              imagePath: 'assets/Icons-07.png',
                            ),
                          ]),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 50,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       CustomTitle(
                    //         title: LocaleKeys.live_location.tr(),
                    //         fontSize: 19,
                    //         colors: Colors.black54,
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Container(
                    //         height: size.height*0.26,
                    //         width: size.width,
                    //         child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(8),
                    //             child: Consumer<LiveLocationOfAllCars>(
                    //               builder: (context,data,_){
                    //                 if (data.cars.isNotEmpty) {
                    //                   for (var i in data.cars){
                    //                     int check =Provider.of<UserDetails>(context,listen:false).vehicleids.indexWhere((element) =>element.vehicleId==i.vehicleId);
                    //                     final MarkerId markerId =
                    //                     MarkerId(i.vehicleId.toString());
                    //                     markers1[markerId] = Marker(
                    //                       rotation: i.angle.toDouble(),
                    //                         markerId: markerId,
                    //                         //MarkerId(i.vehicleId.toString()),
                    //                         position: LatLng(i.latitude, i.longitude),
                    //                         icon: pinLocationIcon ,
                    //                         //anchor: Offset(0.5, 0.5),
                    //                         infoWindow: InfoWindow(
                    //                           title: check>0?
                    //                           Provider.of<UserDetails>(context,listen:false).vehicleids[check].vehicleRegistrationNumber:" ",
                    //                         ));
                    //                     // markers[MarkerId(i .vehicleId.toString())] = marker;
                    //                   }
                    //                 }
                    //                 return !loading?
                    //                 GoogleMap(
                    //                   markers: markers1.values.toSet(),
                    //                   myLocationEnabled: true,
                    //                   compassEnabled: false,
                    //                   tiltGesturesEnabled: false,
                    //                   zoomControlsEnabled: true,
                    //                   zoomGesturesEnabled: true,
                    //                   indoorViewEnabled: true,
                    //                   onMapCreated: (GoogleMapController controller) {
                    //                     _controller = controller;
                    //                     isMapCreated = true;
                    //                     changeMapMode();
                    //                   },
                    //                   initialCameraPosition: CameraPosition(
                    //                     zoom: 8,
                    //                     target: LatLng(
                    //                         24.795861248037244, 67.04488699728579),
                    //                   ),
                    //                   // onMapCreated: onMapCreated
                    //                 ):Stack(
                    //                   children: [
                    //                     GoogleMap(
                    //                       myLocationButtonEnabled: false,
                    //                       myLocationEnabled: false,
                    //                       zoomControlsEnabled: true,
                    //                       initialCameraPosition: CameraPosition(
                    //                         target: LatLng(24.8724, 66.9979),
                    //                         zoom: 10.0,
                    //                       ),
                    //                       onMapCreated: (GoogleMapController controller) {
                    //                         _controller = controller;
                    //                         isMapCreated = true;
                    //                         changeMapMode();
                    //                       },
                    //                     ),
                    //                     Align(
                    //                       alignment:Alignment.center,
                    //                       child: CircularProgressIndicator(
                    //                         valueColor:
                    //                         AlwaysStoppedAnimation<Color>(Color(0xff36b14d)),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 );
                    //               },
                    //             )
                    //
                    //
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                        height: size.height * 0.22,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/weather_background.jpg'),
                                fit: BoxFit.fitWidth,
                                colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.3),
                                    BlendMode.dstATop)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 3,
                                blurRadius: 2,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: loading
                              ? Column(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Image.asset('assets/cloudGif.gif')),
                                    Expanded(
                                      child: Text(
                                        LocaleKeys.loading.tr(),
                                        style: GoogleFonts.poppins(
                                            color: Color(0xff36b14d),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                child: Image.asset(
                                              image,
                                              height: size.height * 0.1,
                                            )),
                                          ),
                                          Expanded(
                                            child: Container(
                                                child: Text(weather,
                                                    style: TextStyle(
                                                        fontSize: 14))),
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Text('Morning',),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 10),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                child: Text(cityName,
                                                    style: TextStyle(
                                                        fontSize: 18))),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                child: Text(
                                              temprature,
                                              style: TextStyle(
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Expanded(
                                            child: Container(
                                                child: Text('$day, $date',
                                                    style: TextStyle(
                                                        fontSize: 18))),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        )),

                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                          height: size.height * 0.23,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(1, 0.1),
                                    color: Colors.grey[200])
                              ]),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            LocaleKeys.manage_your_trips.tr(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey[600],
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 28),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: Icon(
                                                  Icons.repeat_sharp,
                                                  color: Color(0xff36b14d),
                                                ),
                                              )
                                              //Icon(Icons.account_circle),
                                              ),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30),
                                                    child: Text(
                                                        LocaleKeys.live_location
                                                            .tr(),
                                                        //need a Report?
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                LocaleKeys.trip_reports.tr(),
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Align(
                                        alignment: Alignment(0.90, -1),
                                        child: Container(
                                          height: 40,
                                          width: size.width * 0.3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: TextButton(
                                            onPressed: () async {
                                              getAlertBoxOfCarList1(
                                                context: context,
                                              );
                                            },
                                            child: Text(
                                              LocaleKeys.see_details.tr(),
                                              style: TextStyle(
                                                  color: Color(0xff36b14d)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        getContactBottomSheet(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            '© 2021-2022 XTreme Solutions ® All rights reserved.',
                            style: GoogleFonts.poppins(
                                fontSize: 14.0, color: Color(0xff36b14d)),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Support us at:  ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.0, color: Color(0xff36b14d)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Image.asset(
                                'assets/phoneBounce.gif',
                                height: 20.0,
                                width: 20.0,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

Widget driveTimeMonitor(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      context: context,
      builder: (context) {
        return Container(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Select your Preference',
                      style: TextStyle(fontSize: 19, color: Colors.black),
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriveTimeMonitor(
                                  appBartxt: '10 Hours Drive Time Monitor',
                                  isTen: true,
                                ),
                              ),
                            );
                          },
                          child: tenHoursWidget('10 Hours Monitoring')),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriveTimeMonitor(
                                  appBartxt: '4:30 Hours Drive Time Monitor',
                                  isTen: false,
                                ),
                              ),
                            );
                          },
                          child: tenHoursWidget('4:30 Hours Monitoring')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Widget tenHoursWidget(String text) {
  return Card(
    elevation: 10.0,
    child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200], blurRadius: 10, spreadRadius: 8)
            ]),
        child: Center(child: Text(text))),
  );
}

Widget showReports(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.only(top: 23.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // GestureDetector(
                //   onTap:(){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Last24HoursReport()));
                //   },
                //   child: Column(
                //     children: [
                //       Icon(Icons.repeat_on,size: 30,),
                //       Text(LocaleKeys.oneDay_hours_report.tr())
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectSpeedVehicle()));
                  },
                  child: Column(
                    children: [
                      Icon(Icons.auto_graph, size: 30),
                      Text(LocaleKeys.speed_graphs.tr())
                    ],
                  ),
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(Icons.run_circle_outlined, size: 30,color: Colors.grey[500],),
                      Text(LocaleKeys.movement_report.tr(),style: TextStyle(color: Colors.grey[500]),)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Widget backButton(context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            // color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.lightGreen)),
        child: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightGreen,
          ),
        )),
  );
}

Widget logoutButton(context) {
  return GestureDetector(
    onTap: () {
      Provider.of<UserDetails>(context, listen: false).vehicleids.clear();
      Provider.of<LiveLocationOfAllCars>(context, listen: false).cars.clear();
      Provider.of<LiveLocationOfAllCars>(context, listen: false).cars.clear();
      Provider.of<SearchForCars>(context, listen: false).cars.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    },
    child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Color(0xff5f8633),
          borderRadius: BorderRadius.circular(8),
          //border: Border.all(color: Colors.lightGreen)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        )),
  );
}

Widget fields(context, String text, IconData icon, IconData fieldIcon) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextWithIcon(
            icon: fieldIcon,
            text: text,
            textColor: Colors.black,
            iconSize: 18,
          ),
          Icon(
            icon,
            size: 17,
          )
        ]),
      ),
    ),
  );
}

Widget carTile({BuildContext context, String vehicleId, String vehRegNum}) {
  return GestureDetector(
    onTap: () async {
      pdfData(context, vehRegNum,
          Provider.of<UserDetails>(context, listen: false).gname);
    },
    child: Container(
      margin: EdgeInsets.only(left: 15),
      height: 40,
      width: 200,
      decoration: BoxDecoration(
          color: Color(0xff87a564),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
      child: Row(
        children: [
          RotatedBox(
              quarterTurns: 9, child: Image.asset('assets/images/ic_car.png')),
          Text(
            vehRegNum,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.arrow_right_alt_outlined,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

Future<Widget> getAlertBoxOfCarList1({
  BuildContext context,
  TabController controller,
}) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
              return true;
            },
            child: AlertContent(
                //controller: controller,
                ));
      });
}

class AlertContent extends StatefulWidget {
  @override
  _AlertContentState createState() => _AlertContentState();
}

class _AlertContentState extends State<AlertContent>
    with TickerProviderStateMixin {
  List<Vehicleids> suggestionList = [];
  TextEditingController query = TextEditingController();
  bool searching = false;

  //ProgressHUD _progressHUD;

  @override
  void initState() {
    super.initState();
    suggestionList.clear();
    suggestionList =
        Provider.of<UserDetails>(context, listen: false).vehicleids;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Text(
              LocaleKeys.select_vehicle.tr(),
              style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 5.0,
            ),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              child: Container(
                height: 40.0,
                width: double.maxFinite,
                child: TextFormField(
                  onChanged: (value) {
                    if (query.text.isEmpty) {
                      setState(() {
                        suggestionList =
                            Provider.of<UserDetails>(context, listen: false)
                                .vehicleids;
                      });
                    } else {
                      setState(() {
                        suggestionList = Provider.of<UserDetails>(context,
                                listen: false)
                            .vehicleids
                            .where((data) => data.vehicleRegistrationNumber
                                .contains(
                                    RegExp(query.text, caseSensitive: false)))
                            .toList();
                      });
                    }
                  },
                  controller: query,
                  cursorColor: Color(0xff87a564),
                  decoration: InputDecoration(
                      labelStyle: GoogleFonts.poppins(
                          color: Color(0xff87a564), fontSize: 14.0),
                      labelText: LocaleKeys.search_vrn.tr(),
                      suffixIcon: Icon(
                        FeatherIcons.search,
                        color: Color(0xff87a564),
                        size: 18.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none))),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
                // flex: 10,
                child: suggestionList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestionList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 55.0,
                                decoration: BoxDecoration(
                                    color: Color(0xff87a564),
                                    borderRadius: BorderRadius.circular(8.5)),
                                child: carTile(
                                  context: context,
                                  vehicleId:
                                      suggestionList[i].vehicleId.toString(),
                                  vehRegNum: suggestionList[i]
                                      .vehicleRegistrationNumber,
                                )),
                          );
                        })
                    : Center(
                        child: Text(
                          LocaleKeys.no_cars_available.tr(),
                          style: GoogleFonts.poppins(
                              color: Color(0xff87a564).withOpacity(0.4),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

Future<void> pdfData(context, String vrn, String groupName) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog1(
          message: LocaleKeys.loading.tr(),
        );
      });

  List<HistoryReport> historyDataCollection = [];

  await getHistoryReports(context, vrn, groupName).then((value) {
    historyDataCollection.addAll(value);
  });

  PdfDocument document = PdfDocument();

  document.pageSettings.orientation = PdfPageOrientation.landscape;

  PdfGrid grid = PdfGrid();
  grid.columns.add(count: 12);
  PdfGridRow header = grid.headers.add(1)[0];
  header.style.font =
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold);

  //making text in center
  PdfStringFormat format = new PdfStringFormat();
  format.alignment = PdfTextAlignment.center;
  for (int i = 0; i < 12; i++) {
    grid.columns[i].format = format;
  }

  //column titles
  List<String> columnNames = [
    'VRN',
    'Ignition Status',
    'Start Date Time',
    'Start LandMark',
    'Start Mileage',
    'Ignition Status',
    'End Date Time',
    'End LandMark',
    'End Mileage',
    'DistanceTravel',
    'Trip Duration',
    'Total Trip Timing'
  ];

  for (int j = 0; j < 12; j++) {
    header.cells[j].value = columnNames[j];
  }

  historyDataCollection.forEach((element) {
    //Add rows to grid
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = element.vRN;
    row.cells[1].value = element.ignitionOn;
    row.cells[2].value = element.time;
    row.cells[3].value = element.landmark;
    row.cells[4].value = element.mileage.toString();
    row.cells[5].value = element.ignitionOff;
    row.cells[6].value = element.time1;
    row.cells[7].value = element.landmark1;
    row.cells[8].value = element.mileage1.toString();
    row.cells[9].value = element.distanceTravel.toString();
    row.cells[10].value = element.tripDuration;
    row.cells[11].value = element.totalTiming.toString();
  });

  grid.style = PdfGridStyle(
      backgroundBrush: PdfBrushes.white,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 9));

  grid.draw(
    page: document.pages.add(),
    bounds: const Rect.fromLTWH(0, 0, 0, 0),
  );

  List<int> bytes = document.save();
  document.dispose();
  saveAndLaunch(context, bytes, '$vrn $groupName reports.pdf');
}

Future<void> saveAndLaunch(context, List<int> bytes, String fileName) async {
  Navigator.pop(context);
  print('inside pdf open method----------------------------------------------');
  final path = (await getExternalStorageDirectory()).path;
  final file = File('$path/$fileName');

  await file.writeAsBytes(bytes, flush: true);

  //sendMail(path,fileName);
  bytes.isEmpty
      ? Center(
          child: CircularProgressIndicator(),
        )
      : OpenFile.open('$path/$fileName');
}

// sendMail(String path,String fileName) async {
//
//
//   var options = new SmtpOptions()
//     ..hostName = 'mail.ingeniousdigital.systems'
//     ..port = 25
//     ..username = 'mohsin.munir@ingeniousdigital.systems'
//     ..password = 'fee3T03~';
//
//   var transport = new SmtpTransport(options);
//   var envelope = new Envelope()
//     ..from = 'rjunejo96@gmail.com'
//     ..fromName = '$fileName Reports'
//     ..recipients = ['sjunejo95@gmail.com']
//     ..subject = 'Your subject'
//
//     ..attachments.add(Attachment(file:File('$path/$fileName')))
//
//   //..attachments.add(await new Attachment(file: await new File('path')))
//
//     ..text = 'This is the Pdf File';
//
//
//   transport.send(envelope)
//       .then((_) => print('email sent!'))
//       .catchError((e) => print('Error: $e'));
//
//
// }
