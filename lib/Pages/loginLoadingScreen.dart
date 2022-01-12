import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/loginPrefs.dart';
import 'package:flutter_map_marker_animation_example/Entities/textSpeaker.dart';
import 'package:flutter_map_marker_animation_example/Pages/LoginPage.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class PreLoginLoadingScreen extends StatefulWidget {
  @override
  _PreLoginLoadingScreenState createState() => _PreLoginLoadingScreenState();
}

class _PreLoginLoadingScreenState extends State<PreLoginLoadingScreen> {
  String tag = 'GIF';
  String textMsg = LocaleKeys.we_are_getting_things_started.tr();
  LoginSharePref prefs = LoginSharePref();

  checkPrefs() async {
    String email = await prefs.getEmailOne();
    String pass = await prefs.getPassOne();
    if (email != null && pass != null) {
      setState(() {
        textMsg = LocaleKeys.preparing_your_smart_tracking_dashboard.tr();
      });
      String dateTime = DateTime.now().toString();
      await logInUser(
              context: context,
              username: email,
              password: pass,
              dateTime: dateTime)
          .then((value) async {
        if (value == "successful") {
          await prefs.setLoginCred(email, pass);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                tag: tag,
              ),
            ),
          );
        } else {
          setState(() {
            textMsg = LocaleKeys.failed_to_login.tr();
          });
          await Future.delayed(Duration(seconds: 3));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          print("Failed to log in");
        }
      });
    } else {
      setState(() {
        textMsg = LocaleKeys.Please_wait_Taking_you_to_Login_screen.tr();
      });
      await Future.delayed(Duration(seconds: 3));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  TextSpeaker speaker = TextSpeaker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   speaker.setLanguageToEnglish().then((value) async {
   await speaker
        .speakInGirlVoice('welcome to track point. Please wait')
        .then((value) {
         checkPrefs();
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Hero(
                        tag: tag,
                        child: Image.asset('assets/trans-anim3.gif'))),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff36b14d)),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          textMsg,
                          style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Text(
                '© 2021-2022 Xtreme Solutions ® All rights reserved.',
                style: GoogleFonts.poppins(
                    fontSize: 14.0, color: Color(0xff36b14d)),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
