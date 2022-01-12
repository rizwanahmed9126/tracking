import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/alertBox.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/historyReplayDropDown.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/Pages/SpeedReports.dart';
import 'package:flutter_map_marker_animation_example/Pages/registeredVehiclesList2.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectSpeedVehicle extends StatefulWidget {
  @override
  _SelectSpeedVehicleState createState() => _SelectSpeedVehicleState();
}

class _SelectSpeedVehicleState extends State<SelectSpeedVehicle> {
  TextEditingController query = TextEditingController();
  List<Vehicleids> suggestionList = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  Future<Widget> getPicker(context, vehicleId, vehicleRegNum,) {
    TextEditingController startDate = TextEditingController();
    TextEditingController endDate = TextEditingController();
    String selectedValue = LocaleKeys.today.tr();
    HistoryReplayDropDown _dropDowns = HistoryReplayDropDown();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
              LocaleKeys.select_duration.tr(),
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.43,
              width: double.maxFinite,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.5)),
                      tileColor: Color(0xff87a564),
                      leading: Container(
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
                      // Hero(
                      //     tag: vehicleId,
                      //     child: Image.asset('assets/images/ic_car.png',height: 50.0,width: 50.0,)),
                      title: Text(
                        vehicleRegNum,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                        child: _dropDowns.dropDownAndroid(list, selectedValue, (newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        })
                    ),
                    // Text(
                    //   LocaleKeys.select_history_reply_duration.tr(),
                    //   style: GoogleFonts.poppins(
                    //       color: Color(0xff87a564),
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: 15.0,
                    // ),
                    // Expanded(
                    //     child: _dropDowns.dropDownAndroid(list, selectedValue,
                    //             (newValue) {
                    //           print("new value----------$newValue");
                    //           setState(() {
                    //             selectedValue = newValue;
                    //           });
                    //         })),
                    // Expanded(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Expanded(
                    //         child: SizedBox(
                    //           width:double.maxFinite,
                    //           child: Divider(
                    //             color: Colors.black.withOpacity(0.4),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text('Or',style: GoogleFonts.italianno(
                    //             fontSize: 12.0,
                    //             color: Color(0xff87a564),
                    //             fontWeight:FontWeight.bold
                    //
                    //         ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: SizedBox(
                    //           width:double.maxFinite,
                    //           child: Divider(
                    //             color: Colors.black.withOpacity(0.4),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Text(
                      LocaleKeys.select_start_date_time.tr(),
                      style: TextStyle(
                          color: Color(0xff87a564),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: LocaleKeys.Start_date_time_cant_be_null.tr())
                        ]),
                        controller: startDate,
                        decoration:
                        InputDecoration(hintText: LocaleKeys.select_start_time.tr(),),
                        readOnly: true,
                        onTap: () async {
                          selectDateTime(
                            context: context,
                            onDateSelected: (value) {
                              setState(() {
                                startDate.text =
                                    value.toString().substring(0, 10);
                              });
                              print(value);
                            },
                            onTimeSelected: (value) {
                              print(value);
                              String date = startDate.text;
                              setState(() {
                                startDate.text =
                                "$date ${value.toString().substring(10, 15)}:00.000";
                              });
                            },
                            confirmTimeText: "Confirm",
                            headingTime: "Select start time",
                            confirmDateText: "Select Time",
                            headingDate: "Select start date",
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      LocaleKeys.select_end_date_time.tr(),
                      style: TextStyle(
                          color: Color(0xff87a564),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'End date & time cannot be null.')
                        ]),
                        controller: endDate,
                        decoration:
                        InputDecoration(hintText: LocaleKeys.select_end_time.tr(),),
                        readOnly: true,
                        onTap: () async {
                          selectDateTime(
                            context: context,
                            onDateSelected: (value) {
                              setState(() {
                                endDate.text =
                                    value.toString().substring(0, 10);
                              });
                              print(value);
                            },
                            onTimeSelected: (value) {
                              print(value);
                              String date = endDate.text;
                              setState(() {
                                endDate.text =
                                "$date ${value.toString().substring(10, 15)}:00.000";
                              });
                            },
                            confirmTimeText: "Confirm",
                            headingTime: "Select End time",
                            confirmDateText: "Select Time",
                            headingDate: "Select end date",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {




                    //if (formKey.currentState.validate()) {

                    //Navigator.pop(context);
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return ProgressDialog1(
                              message: LocaleKeys.loading.tr()
                          );
                        }
                    );
                    if (startDate.text.isEmpty && endDate.text.isEmpty){

                      var now = DateTime.now();
                      if (selectedValue == list[0]) {//Today


                        startDate.text = now.subtract(Duration(hours: now.hour,minutes: now.minute)).toString();
                        endDate.text = now.toString();
                      } else {//Yesterday


                        var hours = now.subtract(Duration(hours: now.hour,minutes: now.minute));
                        startDate.text = hours.subtract(Duration(hours: 24)).toString();
                        hours = hours.subtract(Duration(minutes: 1));
                        endDate.text = hours.toString();
                      }

                      startDate.text = "${startDate.text.substring(0, 16)}:00.000";
                      endDate.text = "${endDate.text.substring(0, 16)}:00.000";


                      int responseTime = DateTime.parse(startDate.text).difference(DateTime.parse(endDate.text)).inMinutes;
                      var streakDuration = convertMinutesToHours(responseTime.abs());



                      await gethistorydata(startDate.text, endDate.text, vehicleId).then((value) async{
                        int check = value.indexWhere((element) => element.vehicleStatus=="Moving");
                        if(check>0) {

                          await getHistoryReports(context, vehicleRegNum, Provider.of<UserDetails>(context, listen: false)
                              .gname).then((value1) {
                            if (value1 != null) {
                              Navigator.pop(context);
                              print('finally---------------------------------------');

                              Navigator.push(context, MaterialPageRoute(builder: (context) => SpeedReport(
                                data: value,
                                data1:value1,
                                streak: streakDuration,
                                vehicleNumber: vehicleRegNum,)));

                            }
                            else{

                              simpleAlertBox(
                                  context, Text(LocaleKeys.error.tr()), Text(LocaleKeys.no_data_exist.tr()),
                                      () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    //pr.hide();
                                  });
                            }

                          });

                        }
                        else{
                          Navigator.pop(context);
                          simpleAlertBox(
                              context, Text(LocaleKeys.error.tr()), Text(LocaleKeys.no_data_exist.tr()),
                                  () async {
                                Navigator.pop(context);
                                Navigator.pop(context);

                                //pr.hide();
                              });
                        }



                        // Navigator.pop(context);

                        // int check = value.indexWhere((element) => element.vehicleStatus=="Moving");
                        // print("Value:---------------$value $check");
                        // if (check>0) {
                        //
                        //
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => SpeedReport(
                        //             data: value,
                        //             streak: streakDuration,
                        //             vehicleNumber: vehicleRegNum,)));
                        // } else {
                        //   simpleAlertBox(
                        //       context, Text(LocaleKeys.error.tr()), Text(LocaleKeys.no_data_exist.tr()),
                        //           () async {
                        //         Navigator.pop(context);
                        //         Navigator.pop(context);
                        //
                        //         //pr.hide();
                        //       });
                        // }
                      });


                    }

                    // }
                  },
                  child: Text(
                    LocaleKeys.create_route.tr(),
                    style: GoogleFonts.poppins(
                        color: Color(0xff87a564), fontWeight: FontWeight.bold),
                  )
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    suggestionList.clear();
    suggestionList =
        Provider.of<UserDetails>(context, listen: false).vehicleids;
  }

  List<String> list = [LocaleKeys.today.tr(), LocaleKeys.yesterday.tr()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        //iconTheme: IconThemeData(
        //color: Color(0xff7EC049)),
        title: Text(
          LocaleKeys.vehicles.tr(),
          style: GoogleFonts.poppins(
              fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.black),
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
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
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
                            suggestionList =
                                Provider.of<UserDetails>(context, listen: false)
                                    .vehicleids;
                          });
                        } else {
                          setState(() {
                            suggestionList =
                                Provider.of<UserDetails>(context, listen: false)
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
                            child: GestureDetector(
                              onTap: () {
                                getPicker(
                                    context,
                                    suggestionList[i].vehicleId.toString(),
                                    suggestionList[i]
                                        .vehicleRegistrationNumber);
                              },
                              child: carTile(
                                context: context,
                                vehicleId: suggestionList[i].vehicleId.toString(),
                                vehRegNum: suggestionList[i].vehicleRegistrationNumber,
                                  vehStat: suggestionList[i].status
                              ),
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
    );
  }
}

selectDateTime({
  context,
  Function onDateSelected,
  Function onTimeSelected,
  String headingDate,
  String headingTime,
  String confirmDateText,
  String confirmTimeText,
}) async {
  DateTime selectedDate = DateTime.now();
  DateTime pickedDate = DateTime.now();
  pickedDate = await showDatePicker(
      helpText: headingDate,
      confirmText: confirmDateText,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate:
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color(0xff87a564),
                onPrimary: Colors.white,
                surface: Color(0xff87a564),
                onSurface: Colors.black,
              ),
            ),
            child: child);
      });
  if (pickedDate != null) {
    onDateSelected(pickedDate);
    //print(startDate.text);
  }
  var pickedTime;
  pickedTime = await showTimePicker(
    helpText: headingTime,
    confirmText: confirmTimeText,
    context: context,
    initialTime: TimeOfDay.now(),
  );
  print(pickedTime);
  if (pickedTime != null) {
    onTimeSelected(pickedTime);
  }
}

String convertMinutesToHours(int minutes) {
  String value;
  String hours;

  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');

  if (minutes > 59 && minutes < 1440)
    value = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')} hours';
  else if (minutes >= 1440) {
    var abc = minutes % 1440;
    double day = minutes / 1440;
    int days = day.toInt();

    if (abc == 0) {
      value = '$days day';
    } else if (abc > 59 && abc < 1440) {
      var c = Duration(minutes: abc);
      List<String> parts1 = c.toString().split(':');
      hours = '${parts1[0].padLeft(2, '0')}:${parts1[1].padLeft(2, '0')} hours';
      value = '$days days $hours hours';
    } else {
      value = '$days days $abc minutes';
    }
  } else
    value = '${minutes.toString()} Minutes';

  print(value);

  return value;
}
