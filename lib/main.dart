import 'dart:async';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/VehicleParkedTime.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/getAllSelectedCars.dart';
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
import 'package:flutter_map_marker_animation_example/translations/codegen_loader.g.dart';
import 'package:flutter_map_marker_animation_example/translations/codegen_loader.g.dart';
import 'MyVehicles/MyVehicles.dart';
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

import 'Entities/voiceToTextConvertor.dart';
import 'Pages/LoginPage.dart';
import 'Pages/loginLoadingScreen.dart';
import 'HistoryReplay/markerAnimation copy.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import 'package:flutter_localizations/flutter_localizations.dart';




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  HttpOverrides.global = new MyHttpOverrides();
  runApp(
      EasyLocalization(
        path: 'assets/translation',
          supportedLocales: [
            Locale('en'),
            Locale('ur'),
          ],
          fallbackLocale: Locale('en'),
          assetLoader: CodegenLoader(),
          child: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginSharePref prefs = LoginSharePref();

  Widget pageSelector = PreLoginLoadingScreen();

  checkPrefs() async {
    String email = await prefs.getEmail();
    String pass = await prefs.getPass();
    if (email != null && pass != null) {
      String dateTime = DateTime.now().toString();
      await logInUser(
          context: context,
          username: email,
          password: pass,
          dateTime: dateTime)
          .then((value) async {
        if (value == "successful") {
          print("Log in successful");
          await prefs.setLoginCred(email, pass);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          setState(() {
            pageSelector = Home();
          });
        } else {
          setState(() {
            pageSelector = LoginScreen();
          });
          print("Failed to log in");
        }
      });
    } else {
      setState(() {
        pageSelector = LoginScreen();
      });
    }
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserDetails()),
          ChangeNotifierProvider(create: (_) => LiveLocationOfSelectedCars()),
          ChangeNotifierProvider(create: (_) => LiveLocationOfAllCars()),
          ChangeNotifierProvider(create: (_) => MarkerPlayerControl()),
          ChangeNotifierProvider(create: (_) => SearchForCars()),
          ChangeNotifierProvider(create: (_) => LiveTrackingControl()),
          ChangeNotifierProvider(create: (_) => TextSpeaker()),
          ChangeNotifierProvider(create: (_) => GetSelectedCars())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.lightGreen,
              primaryColor: Colors.lightGreen,
              accentColor: Colors.lightGreen,
              fontFamily: GoogleFonts.poppins().fontFamily,
              timePickerTheme: TimePickerThemeData(
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Color(0xff87a564))),
                backgroundColor: Colors.white,
                entryModeIconColor: Color(0xff87a564),
                dialHandColor: Color(0xff87a564),
                hourMinuteTextStyle: TextStyle(fontSize: 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                hourMinuteTextColor: Color(0xff87a564),
                hourMinuteColor: Colors.grey[200],
                hourMinuteShape: CircleBorder(),
              ),
            ),
            title: 'Trackpoint',
           supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            home: //GoogleMaps1()
            pageSelector
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

