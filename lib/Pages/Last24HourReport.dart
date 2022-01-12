import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryReports.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/ExpansionTile.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/alertBox.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Last24HoursReport extends StatefulWidget {
  @override
  _Last24HoursReportState createState() => _Last24HoursReportState();
}

class _Last24HoursReportState extends State<Last24HoursReport> {
  bool atTop = true;
  TextEditingController query = TextEditingController();

  List<Vehicleids> suggestionList = [];

  @override
  void initState() {
    super.initState();

    suggestionList.clear();
    suggestionList =
        Provider.of<UserDetails>(context, listen: false).vehicleids;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),

          title: Text(
              LocaleKeys.oneDay_hours_report.tr(),
            style: GoogleFonts.poppins(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          //centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    child: Container(
                      height: 50.0,
                      width: double.maxFinite,
                      child: TextFormField(
                        onChanged: (value) {
                          if (query.text.isEmpty) {
                            setState(() {
                              suggestionList = Provider.of<UserDetails>(context,
                                      listen: false)
                                  .vehicleids;
                            });
                          } else {
                            setState(() {
                              suggestionList = Provider.of<UserDetails>(context,
                                      listen: false)
                                  .vehicleids
                                  .where((data) => data
                                      .vehicleRegistrationNumber
                                      .contains(RegExp(query.text,
                                          caseSensitive: false)))
                                  .toList();
                            });
                          }
                        },
                        controller: query,
                        cursorColor: Color(0xff87a564),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
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
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none))),
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
                                  padding: EdgeInsets.only(bottom: 18.0),
                                  child: carTile(
                                    context: context,
                                    vehicleId: suggestionList[i].vehicleId.toString(),
                                    vehRegNum: suggestionList[i].vehicleRegistrationNumber,
                                    vehStat: suggestionList[i].status
                                  ),
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
          ),
        ),
      ),
    );
  }
}

Widget carTile({
  BuildContext context,
  String vehicleId,
  String vehRegNum,
  String vehStat
}) {
  Size size = MediaQuery.of(context).size;
  List<HistoryReport> filterData = [];
  return GestureDetector(
    onTap: () async {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ProgressDialog1(
              message: LocaleKeys.loading.tr(),
            );
          });
      await getHistoryReports(context, vehRegNum,
              Provider.of<UserDetails>(context, listen: false).gname)
          .then((value) {
        Navigator.pop(context);

        if (value == null) {
          print('i get to else if--');
          simpleAlertBox(context, Text(LocaleKeys.error.tr()), Text(LocaleKeys.no_data_exist.tr()), () async {
            Navigator.pop(context);
            //pr.hide();
          });
        } else {
          for (int i = 0; i < value.length; i++)
          {
            if (value[i].distanceTravel.round() > 0)
            {
              filterData.add(value[i]);
            }
          }
          if(filterData.isNotEmpty)
            Navigator.push(context,MaterialPageRoute(builder: (context) => ShowReportsCards(data: filterData,)));
        }
      });
    },
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: vehStat=='Parked'?Colors.orange[300]
              : vehStat=='Moving'?Color(0xff5E8633)
              :Colors.indigo[300] //blue[400],
      ),
      child: Container(
        //margin: EdgeInsets.only(left: 15),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xff87a564),
            borderRadius: BorderRadius.circular(12)
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 70,
              child: RotatedBox(
                  quarterTurns: StaticClass.showTruck?9:9,
                  child: StaticClass.showTruck
                      ? Image.asset(
                    'assets/images/truckMarker.png',
                  )
                      : Image.asset('assets/images/ic_car.png')
              ),
            ),
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
    ),
  );
}
