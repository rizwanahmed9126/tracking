import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/searchCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/LoginPage.dart';
import '../MyVehicles/MyVehicles.dart';
import 'package:flutter_map_marker_animation_example/widgets/HomeTile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';



class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool changeLanguage=true;

  void _toggleLanguage(){
    setState(() {

      changeLanguage=!changeLanguage;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Container(
                        width: size.width*0.9,
                        child: AutoSizeText(

                          Provider.of<UserDetails>(context, listen: false).gname,
                          style: GoogleFonts.poppins(
                              fontSize: 25, fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                ),
                GestureDetector(
                  onTap: () async{
                    _toggleLanguage();
                    changeLanguage? await context.setLocale(Locale('en')):await context.setLocale(Locale('ur'));

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 28),
                              child: Icon(Icons.language),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.languages.tr(),
                                    style: TextStyle(fontSize: 18)),
                                // SizedBox(
                                //   height: 4.0,
                                // ),
                                // Text(
                                //   'Tap to see Details',
                                //   style: TextStyle(
                                //     fontStyle: FontStyle.italic,
                                //     color: Colors.grey[600],
                                //     fontSize: 14,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(LocaleKeys.english.tr(), //changeLanguage?'English':'اردو',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                profileTile(
                  context:context,
                  icon:Icons.notifications_outlined,
                  title:LocaleKeys.notifications.tr(),
                  press:  () {},
                  txtColor: Colors.grey[600],
                  iconColor: Colors.grey[600]
                ),
                profileTile(
                    context:context,
                    icon:Icons.blur_circular_outlined,
                    title:LocaleKeys.help.tr(),
                    press:  () {},
                    txtColor: Colors.grey[600],
                    iconColor: Colors.grey[600]
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Divider(
                  height: 2,
                ),
                profileTile(
                    context:context,
                    icon:Icons.star_border,
                    title:LocaleKeys.rate_the_app.tr(),
                    press:  () {},
                    txtColor: Colors.grey[600],
                    iconColor: Colors.grey[600]

                    ),
                profileTile(
                    context:context,
                    icon:Icons.logout,
                    title:LocaleKeys.sign_out.tr(),
                    press:  () {
                      Provider.of<UserDetails>(context,listen: false).vehicleids.clear();
                      Provider.of<LiveLocationOfSelectedCars>(context,listen: false).cars.clear();
                      Provider.of<LiveLocationOfAllCars>(context,listen: false).cars.clear();
                      Provider.of<SearchForCars>(context,listen: false).cars.clear();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    txtColor: Colors.black,
                    iconColor: Colors.black

                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Divider(
                  height: 2,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 5),
                      child: Text(
                        'Terms and condition',
                        style: GoogleFonts.poppins(
                            fontSize: 17, color: Color(0xff222222)),
                      ),
                    ),
                    Text(
                      'App version 1.1(2021)',
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget profileTile({context, IconData icon, String title, Function press,Color txtColor,Color iconColor}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(title, style: TextStyle(fontSize: 18,color: txtColor)),
      onTap: press,
    ),
  );
}
