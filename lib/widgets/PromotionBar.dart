import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';


class PromotionBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height*0.14,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.grey,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(

              //height: 100,
              width: size.width*0.42,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/dashboard_pic.jpg',fit: BoxFit.cover,)),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(



              height: size.height*0.14,
              width: size.width*0.68,
              decoration: BoxDecoration(
                  color: Color(0xff48A23F),

                  borderRadius: BorderRadius.only(

                      topRight:Radius.elliptical(45,170),
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),

                    //top: Radius.circular(20,)
                  )
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      height: size.height*0.04,
                      width: size.width*0.68,
                      //color: Colors.red,
                      child: AutoSizeText(
                        LocaleKeys.promotion_head.tr(),
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,

                      ),
                    ),

                    Container(
                      height: size.height*0.07,
                      width: size.width*0.68,
                      //color: Colors.red,
                      child: AutoSizeText(
                        LocaleKeys.promotion_description.tr(),
                          //maxLines: 5,

                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            //fontSize: 15,

                          ),
                        maxLines: 2,
                        minFontSize: 10,


                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),




        ],
      ),

    );
  }
}


class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
