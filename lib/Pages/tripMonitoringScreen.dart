import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/tripMonitoringBody.dart';
import 'package:flutter_map_marker_animation_example/Pages/dashboard.dart';
import 'package:flutter_map_marker_animation_example/main.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:easy_localization/easy_localization.dart';

class TripMonitoring extends StatefulWidget {
  @override
  _TripMonitoringState createState() => _TripMonitoringState();
}

class _TripMonitoringState extends State<TripMonitoring> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
          return true;
        },
        child: Stack(
          children: [
            Container(
              height: size.size.height * 0.7,
              width: size.size.width,
              decoration: BoxDecoration(
                  color: Color(0xff5E8633),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.0, right: 15.0, left: 15.0),
                child: Container(
                  width: 300.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Container(
                          height: 38.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              color: Color(0xff7DC049),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Icon(
                            FeatherIcons.alignLeft,
                            color: Colors.white,
                            size: 20.0,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 45.0,
                      ),
                      Text(
                        LocaleKeys.trip_monitor.tr(),
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 100.0, right: 40.0, left: 40.0),
                child: TripMonitoringBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}