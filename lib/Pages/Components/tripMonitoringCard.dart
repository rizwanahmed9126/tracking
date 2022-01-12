import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:easy_localization/easy_localization.dart';

class TripMonitoringCard extends StatefulWidget {

  final String vrn;
  final String startTime;
  final String endTime;
  final String enRoute;
  final String startLandMark;
  final String endLandMark;
  TripMonitoringCard({
    this.vrn,
    this.startTime,
    this.endTime,
    this.enRoute,
    this.startLandMark,
    this.endLandMark,

  });


  @override
  _TripMonitoringCardState createState() => _TripMonitoringCardState();
}

class _TripMonitoringCardState extends State<TripMonitoringCard> {
  int activeStep = 0;
  int dotCount = 4;
  List<Icon> iconsList = [
    Icon(
      FeatherIcons.truck,
      color: Colors.white,
    ),
    Icon(
      FeatherIcons.truck,
      color: Color(0xff8CC75D),
    ),
    Icon(
      FeatherIcons.truck,
      color: Color(0xff8CC75D),
    ),
    Icon(
      FeatherIcons.truck,
      color: Color(0xff8CC75D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 3.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.vrn,
                    style: GoogleFonts.poppins(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  // Icon(
                  //   FeatherIcons.moreVertical,
                  //   color: Colors.black,
                  //   size: 28.0,
                  // )
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.startTime,
                    style:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 13.0),
                  ),
                  Text(
                    widget.endTime,
                    style:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 13.0),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                    height: 22,
                    width: MediaQuery.of(context).size.width*0.35,
                    child: Text(
                      widget.startLandMark,textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          color: Color(0xff5E8633), fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 22,
                    width: MediaQuery.of(context).size.width*0.35,
                    child: Text(
                      widget.endLandMark,textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                          color: Color(0xff5E8633), fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                  )
                ],
              ),
              IconStepper(
                lineDotRadius: 0.8,
                stepReachedAnimationEffect: Curves.bounceInOut,
                activeStepBorderColor: Color(0xff8CC75D),
                lineColor: Colors.grey,
                lineLength: 40.0,
                activeStepColor: Color(0xff8CC75D),
                stepColor: Color(0xff8CC75D),
                enableNextPreviousButtons: false,
                stepRadius: 8.0,
                icons: iconsList,
                activeStep: activeStep,
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                    for (int i = 0; i < iconsList.length; i++) {
                      if (i == activeStep) {
                        iconsList[i] = Icon(
                          FeatherIcons.truck,
                          color: Colors.white,
                        );
                      } else {
                        iconsList[i] = Icon(
                          FeatherIcons.truck,
                          color: Color(0xff8CC75D),
                        );
                      }
                    }
                  });
                },
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width*0.6,
                child: Center(
                  child: Text(
                    '${LocaleKeys.Enroute_to.tr()}: ${widget.enRoute} ',
                    style: GoogleFonts.poppins(fontSize: 13.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



