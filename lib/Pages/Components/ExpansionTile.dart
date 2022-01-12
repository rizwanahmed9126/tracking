import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryReports.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/CustomDrawer.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/tripMonitoringCard.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class ShowReportsCards extends StatefulWidget {
  List<HistoryReport> data = [];

  ShowReportsCards({
    this.data,
  });

  @override
  _ShowReportsCardsState createState() => _ShowReportsCardsState();
}

class _ShowReportsCardsState extends State<ShowReportsCards> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      //drawer: CustomDrawer(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff5E8633),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            LocaleKeys.oneDay_hours_report.tr(),
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          )),

      body: Stack(
        children: [
          Container(
            height: size.size.height * 0.4,
            width: size.size.width,
            decoration: BoxDecoration(
                color: Color(0xff5E8633),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0))),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              //padding: EdgeInsets.only(top: 100.0, right: 30.0, left: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // start time
                      String s = widget.data[index].time;
                      int idx = s.indexOf("T");
                      List parts = [
                        s.substring(0, idx).trim(),
                        s.substring(idx + 1).trim()
                      ];
                      String dateTime = '${parts[0]} ${parts[1]}';

                      //end time
                      String s1 = widget.data[index].time1;
                      int idx1 = s1.indexOf("T");
                      List parts1 = [
                        s1.substring(0, idx1).trim(),
                        s1.substring(idx1 + 1).trim()
                      ];
                      String dateTime1 = '${parts1[0]} ${parts1[1]}';
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      actions: [
                                        TextButton(
                                          child: Text(LocaleKeys.Ok.tr(),style: GoogleFonts.poppins(
                                              color: Color(0xff5E8633),
                                              fontWeight: FontWeight.bold
                                          ),),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                      contentPadding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      content: showTripTile(
                                        context,
                                        index,
                                        widget.data[index].landmark,
                                        dateTime,
                                        widget.data[index].mileage.toString(),
                                        widget.data[index].ignitionOn,
                                        widget.data[index].landmark1,
                                        dateTime1,
                                        widget.data[index].mileage1.toString(),
                                        widget.data[index].ignitionOff,
                                        widget.data[index].tripDuration,
                                        widget.data[index].distanceTravel,
                                      ));
                                });
                          },
                          child: TripMonitoringCard(
                            vrn: widget.data[index].vRN,
                            startTime: parts[1],
                            endTime: parts1[1],
                            enRoute: widget.data[index].landmark1,
                            startLandMark: widget.data[index].landmark,
                            endLandMark: widget.data[index].landmark1,
                          ));
                    })),
          ),
        ],
      ),
    );
  }
}

Widget showTripTile(
    context,
    int count,
    String location,
    String dateTime,
    String mileage,
    String ignitionStatus,
    String location1,
    String dateTime1,
    String mileage1,
    String ignitionStatus1,
    String duration,
    var distance) {
  double getNumber(double input, {int precision = 2}) =>
      double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));
  return Padding(
    padding: const EdgeInsets.symmetric( vertical: 10),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.52,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: Column(
            children: [
              showData(LocaleKeys.From.tr(), location, dateTime, mileage, ignitionStatus),
              Divider(
                height: 2,
                color: Colors.grey[600],
              ),
              SizedBox(
                height: 4,
              ),
              showData(LocaleKeys.To.tr(), location1, dateTime1, mileage1, ignitionStatus1),
              Divider(
                height: 2,
                color: Colors.grey[600],
              ),
              SizedBox(
                height: 4,
              ),
              Column(
                children: [
                  AutoSizeText(
                    LocaleKeys.Summary.tr(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        LocaleKeys.Distance.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${getNumber(distance, precision: 1)}')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.Duration.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(duration)
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    ),
  );
}

Widget showData(String heading, String location, String dateTime,
    String mileage, String ignitionStatus) {
  return Column(
    children: [
      AutoSizeText(
        heading,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            LocaleKeys.DateTime.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AutoSizeText(dateTime)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            LocaleKeys.mileage.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AutoSizeText(mileage)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            'Ignition',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AutoSizeText(ignitionStatus)
        ],
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            LocaleKeys.near_to.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 70,
          ),
          Expanded(
            child: Container(
                height: 20,
                // width: 247,
                child: AutoSizeText(
                  '$location',
                  maxLines: 2,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  //textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                )),
          )
        ],
      ),
    ],
  );
}
