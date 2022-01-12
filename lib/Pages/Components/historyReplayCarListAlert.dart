// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
// import 'package:flutter_map_marker_animation_example/Entities/voiceToTextConvertor.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Components/historyReplayDropDown.dart';
// import 'package:flutter_map_marker_animation_example/home.dart';
// import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
// import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:marquee_widget/marquee_widget.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:provider/provider.dart';
// import '../../HistoryReplay/markerAnimation copy.dart' as tt;
// import 'package:form_field_validator/form_field_validator.dart';
//
// import '../../HistoryReplay/markerAnimation copy.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// Future<Widget> getAlertBoxOfCarList(
//     {BuildContext context,
//     TabController controller,
//     Function startChange,
//     Function endChange,
//     Function onDonePressed,
//     bool withPicker = true}) async {
//   return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return WillPopScope(
//             onWillPop: () async {
//               Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (context) => Home()));
//               return true;
//             },
//             child: AlertContent(
//               withPickers: withPicker,
//               controller: controller,
//               startChange: startChange,
//               endChange: endChange,
//               onDonePressed: onDonePressed,
//             ));
//       });
// }
//
// class AlertContent extends StatefulWidget {
//   TabController controller;
//   Function startChange;
//   Function endChange;
//   Function onDonePressed;
//   bool withPickers;
//
//   AlertContent(
//       {this.controller,
//       this.endChange,
//       this.startChange,
//       this.onDonePressed,
//       this.withPickers});
//
//   @override
//   _AlertContentState createState() => _AlertContentState();
// }
//
// class _AlertContentState extends State<AlertContent>
//     with TickerProviderStateMixin {
//   List<Vehicleids> suggestionList = [];
//   TextEditingController query = TextEditingController();
//   TextEditingController startDate = TextEditingController();
//   TextEditingController endDate = TextEditingController();
//   bool isListening = false;
//   VoiceToText speech = VoiceToText();
//
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   bool searching = false;
//
//   AnimationController _controller;
//   Animation<Offset> _animation;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     suggestionList.clear();
//     suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids;
//
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//     _animation = Tween<Offset>(
//       begin: const Offset(-0.3, 0.0),
//       end: const Offset(1.5, 0.0),
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     ));
//   }
//   List<String> list = [LocaleKeys.today.tr(), LocaleKeys.yesterday.tr()];
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       content: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
//         height: MediaQuery.of(context).size.height * 0.8,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               LocaleKeys.select_vehicle.tr(),
//               style: GoogleFonts.poppins(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Card(
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0)),
//               child: Container(
//                 height: 40.0,
//                 width: double.maxFinite,
//                 child: TextFormField(
//                   onChanged: (value) {
//                     if (query.text.isEmpty) {
//                       setState(() {
//                         suggestionList =
//                             Provider.of<UserDetails>(context, listen: false)
//                                 .vehicleids;
//                       });
//                     } else {
//                       setState(() {
//                         suggestionList = Provider.of<UserDetails>(context,
//                                 listen: false)
//                             .vehicleids
//                             .where((data) => data.vehicleRegistrationNumber
//                                 .contains(
//                                     RegExp(query.text, caseSensitive: false)))
//                             .toList();
//                       });
//                     }
//                   },
//                   controller: query,
//                   cursorColor: Color(0xff87a564),
//                   decoration: InputDecoration(
//                     labelStyle: GoogleFonts.poppins(
//                         color: Color(0xff87a564), fontSize: 14.0),
//                     labelText: LocaleKeys.search_vrn.tr(),
//                     suffixIcon: AvatarGlow(
//                       animate: isListening,
//                       glowColor: Color(0xff87a564),
//                       endRadius: 28.0,
//                       duration: Duration(milliseconds: 1000),
//                       repeat: true,
//                       child: IconButton(
//                         icon: Icon(
//                           isListening ? FeatherIcons.mic : FeatherIcons.mic,
//                           color: Color(0xff87a564),
//                           size: 18.0,
//                         ),
//                         onPressed: () async {
//                           if (!isListening) {
//                             speech.checkIfAvailable().then((value) async {
//                               await speech.listenVoice((recogniseWords) {
//                                 if (value) {
//                                   setState(() {
//                                     isListening = true;
//                                   });
//                                   setState(() {
//                                     query.text = recogniseWords;
//                                     suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids.where((data) => data.vehicleRegistrationNumber.contains(RegExp(query.text, caseSensitive: false))).toList();
//                                     if (query.text.isNotEmpty) {
//                                       isListening = false;
//                                     }
//                                   });
//                                 }
//                               });
//                             });
//                           } else {
//                             setState(() {
//                               isListening = false;
//                               speech.stop();
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(18.0),
//                         borderSide:
//                             BorderSide(width: 0, style: BorderStyle.none)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//             Expanded(
//                 // flex: 10,
//                 child: suggestionList.isNotEmpty
//                     ? ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: suggestionList.length,
//                         itemBuilder: (context, i) {
//                           return Padding(
//                             padding: EdgeInsets.only(bottom: 15.0),
//                             child: Container(
//                                 height: 55.0,
//                                 decoration: BoxDecoration(
//                                     color: Color(0xff87a564),
//                                     borderRadius: BorderRadius.circular(8.5)),
//                                 child: carTile(
//                                     withPickers: widget.withPickers,
//                                     context: context,
//                                     startChange: widget.startChange,
//                                     endChange: widget.endChange,
//                                     onDonePressed: widget.onDonePressed,
//                                     vehicleId: suggestionList[i].vehicleId.toString(),
//                                     vehRegNum: suggestionList[i].vehicleRegistrationNumber,
//                                     controller: widget.controller,
//                                     vehStat:suggestionList[i].status,
//                                     // animationController1: _controller,
//                                     // animation: _animation
//                                 )),
//                           );
//                         })
//                     : Center(
//                         child: Text(
//                           LocaleKeys.no_cars_available.tr(),
//                           style: GoogleFonts.poppins(
//                               color: Color(0xff87a564).withOpacity(0.4),
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   selectDateAndroid({
//     Function onDateSelected,
//     Function onTimeSelected,
//     String headingDate,
//     String headingTime,
//     String confirmDateText,
//     String confirmTimeText,
//   }) async {
//     DateTime selectedDate = DateTime.now();
//     DateTime pickedDate = DateTime.now();
//     pickedDate = await showDatePicker(
//         helpText: headingDate,
//         confirmText: confirmDateText,
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2000, 1),
//         lastDate:
//             DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
//         builder: (context, child) {
//           return Theme(
//               data: ThemeData.light().copyWith(
//                 colorScheme: ColorScheme.dark(
//                   primary: Color(0xff87a564),
//                   onPrimary: Colors.white,
//                   surface: Color(0xff87a564),
//                   onSurface: Colors.black,
//                 ),
//               ),
//               child: child);
//         });
//     if (pickedDate != null) {
//       onDateSelected(pickedDate);
//     }
//     var pickedTime;
//     pickedTime = await showTimePicker(
//       helpText: headingTime,
//       confirmText: confirmTimeText,
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       onTimeSelected(pickedTime);
//     }
//   }
//
//   Future<Widget> getPicker(context, vehicleId, vehicleRegNum, Function onPressed) {
//     TextEditingController startDate = TextEditingController();
//     TextEditingController endDate = TextEditingController();
//     HistoryReplayDropDown _dropDowns = HistoryReplayDropDown();
//     return showDialog(
//         context: context,
//         builder: (context) {
//           String selectedValue = LocaleKeys.today.tr();
//           return StatefulBuilder(builder: (context,setState){
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//               title: Text(
//                 LocaleKeys.select_duration.tr(),
//                 style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//               ),
//               content: Container(
//                 height: MediaQuery.of(context).size.height * 0.43,
//                 width: double.maxFinite,
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.5)),
//                         tileColor: Color(0xff87a564),
//                         leading: RotatedBox(
//                             quarterTurns: 9,
//                             child: Image.asset('assets/images/ic_car.png')),
//                         title: Text(
//                           vehicleRegNum,
//                           style: GoogleFonts.poppins(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Text(
//                         LocaleKeys.select_history_reply_duration.tr(),
//                         style: GoogleFonts.poppins(
//                             color: Color(0xff87a564),
//                             fontSize: 12.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 15.0,
//                       ),
//                       Expanded(
//                           child: _dropDowns.dropDownAndroid(list, selectedValue,
//                                   (newValue) {
//
//                                 setState(() {
//                                   selectedValue = newValue;
//                                 });
//                               })
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Expanded(
//                               child: SizedBox(
//                                 width:double.maxFinite,
//                                 child: Divider(
//                                   color: Colors.black.withOpacity(0.4),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text('Or',style: GoogleFonts.italianno(
//                                 fontSize: 12.0,
//                                 color: Color(0xff87a564),
//                                 fontWeight:FontWeight.bold
//
//                               ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             Expanded(
//                               child: SizedBox(
//                                 width:double.maxFinite,
//                                 child: Divider(
//                                   color: Colors.black.withOpacity(0.4),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         LocaleKeys.select_start_date_time.tr(),
//                         style: GoogleFonts.poppins(
//                             color: Color(0xff87a564),
//                             fontSize: 12.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 4.0,
//                       ),
//                       Expanded(
//                         child: TextFormField(
//                           // validator: MultiValidator([
//                           //   RequiredValidator(
//                           //       errorText: 'Start date & time cannot be null.')
//                           // ]),
//                           controller: startDate,
//                           decoration:
//                           InputDecoration(hintText: LocaleKeys.select_start_time.tr()),
//                           readOnly: true,
//                           onTap: () async {
//                             selectDateAndroid(
//                               onDateSelected: (value) {
//                                 setState(() {
//                                   startDate.text =
//                                       value.toString().substring(0, 10);
//                                 });
//                                 print(value);
//                               },
//                               onTimeSelected: (value) {
//                                 print(value);
//                                 String date = startDate.text;
//                                 setState(() {
//                                   startDate.text =
//                                   "$date ${value.toString().substring(10, 15)}:00.000";
//                                 });
//                               },
//                               confirmTimeText: "Confirm",
//                               headingTime: "Select start time",
//                               confirmDateText: "Select Time",
//                               headingDate: "Select start date",
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Text(
//                         LocaleKeys.select_end_date_time.tr(),
//                         style: TextStyle(
//                             color: Color(0xff87a564),
//                             fontSize: 12.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 4.0,
//                       ),
//                       Expanded(
//                         child: TextFormField(
//                           // validator: MultiValidator([
//                           //   RequiredValidator(
//                           //       errorText: 'End date & time cannot be null.')
//                           // ]),
//                           controller: endDate,
//                           decoration:
//                           InputDecoration(hintText: LocaleKeys.select_end_time.tr()),
//                           readOnly: true,
//                           onTap: () async {
//                             selectDateAndroid(
//                               onDateSelected: (value) {
//                                 setState(() {
//                                   endDate.text =
//                                       value.toString().substring(0, 10);
//                                 });
//                                 print(value);
//                               },
//                               onTimeSelected: (value) {
//                                 print(value);
//                                 String date = endDate.text;
//                                 setState(() {
//                                   endDate.text =
//                                   "$date ${value.toString().substring(10, 15)}:00.000";
//                                 });
//                               },
//                               confirmTimeText: "Confirm",
//                               headingTime: "Select End time",
//                               confirmDateText: "Select Time",
//                               headingDate: "Select end date",
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                     onPressed: () async {
//                       if (formKey.currentState.validate()) {
//                         //Navigator.pop(context);
//                         showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext context) {
//                               return ProgressDialog1(
//                                 message: LocaleKeys.loading.tr(),
//                               );
//                             });
//                         if (startDate.text.isEmpty && endDate.text.isEmpty) {
//                           var now = DateTime.now();
//                           if (selectedValue == list[0]) {//Today
//                             startDate.text = now
//                                 .subtract(Duration(hours: now.hour,minutes: now.minute))
//                                 .toString();
//                             endDate.text = now.toString();
//                           } else {//Yesterday
//
//                             var hours = now.subtract(Duration(hours: now.hour,minutes: now.minute));
//                             startDate.text = hours
//                                 .subtract(Duration(hours: 24))
//                                 .toString();
//                             hours = hours.subtract(Duration(minutes: 1));
//                             endDate.text = hours.toString();
//                           }
//                           print(startDate.text);
//                           print(endDate.text);
//                           startDate.text = "${startDate.text.substring(0, 16)}:00.000";
//                           endDate.text = "${endDate.text.substring(0, 16)}:00.000";
//                         }
//                         onPressed(vehicleId, startDate.text, endDate.text);
//                       }
//                     },
//                     child: Text(
//                       LocaleKeys.create_route.tr(),
//                       style: GoogleFonts.poppins(
//                           color: Color(0xff87a564), fontWeight: FontWeight.bold),
//                     ))
//               ],
//             );
//           });
//         });
//   }
//
//   bool isShow = true;
//
//   Widget carTile(
//       {
//         BuildContext context,
//       bool withPickers,
//       String vehicleId,
//       String vehRegNum,
//       Function startChange,
//       Function endChange,
//       Function onDonePressed,
//       TabController controller,
//         String vehStat,
//       // AnimationController animationController1,
//       // Animation<Offset> animation,
//
//       }) {
//     return GestureDetector(
//       onTap: () {
//         // animationController1.forward();
//         // animationController1.isCompleted;
//         setState(() {
//           isShow = false;
//         });
//         if (withPickers) {
//           getPicker(context, vehicleId, vehRegNum, onDonePressed);
//         } else {
//           onDonePressed(vehicleId, ' ', ' ');
//         }
//       },
//       child: Container(
//         height: 50,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.only(right: 12.0),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: vehStat=='Parked'?Colors.orange[300]
//                 : vehStat=='Moving'?Color(0xff5E8633)
//                 :Colors.indigo[300] //blue[400],
//         ),
//         child: Container(
//           //margin: EdgeInsets.only(left: 15),
//           height: 40,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             color: Color(0xff87a564),
//             borderRadius: BorderRadius.circular(12)
//           ),
//
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               RotatedBox(
//                   quarterTurns: 9,
//                   child: Image.asset('assets/images/ic_car.png')),
//               Text(
//                 vehRegNum,
//                 style: GoogleFonts.poppins(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               Icon(
//                 Icons.arrow_right_alt_outlined,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/voiceToTextConvertor.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/historyReplayDropDown.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:flutter_map_marker_animation_example/widgets/ProgressDialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../HistoryReplay/markerAnimation copy.dart' as tt;
import 'package:form_field_validator/form_field_validator.dart';

import '../../HistoryReplay/markerAnimation copy.dart';
import 'package:easy_localization/easy_localization.dart';

Future<Widget> getAlertBoxOfCarList(
    {BuildContext context,
      TabController controller,
      Function startChange,
      Function endChange,
      Function onDonePressed,
      bool withPicker = true}) async {
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
              withPickers: withPicker,
              controller: controller,
              startChange: startChange,
              endChange: endChange,
              onDonePressed: onDonePressed,
            ));
      });
}

class AlertContent extends StatefulWidget {
  TabController controller;
  Function startChange;
  Function endChange;
  Function onDonePressed;
  bool withPickers;

  AlertContent(
      {this.controller,
        this.endChange,
        this.startChange,
        this.onDonePressed,
        this.withPickers});

  @override
  _AlertContentState createState() => _AlertContentState();
}

class _AlertContentState extends State<AlertContent>
    with TickerProviderStateMixin {
  List<Vehicleids> suggestionList = [];
  TextEditingController query = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  bool isListening = false;
  VoiceToText speech = VoiceToText();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool searching = false;

  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggestionList.clear();
    suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids;

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(-0.3, 0.0),
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }
  List<String> list = [LocaleKeys.today.tr(), LocaleKeys.yesterday.tr()];
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
                    suffixIcon: AvatarGlow(
                      animate: isListening,
                      glowColor: Color(0xff87a564),
                      endRadius: 28.0,
                      duration: Duration(milliseconds: 1000),
                      repeat: true,
                      child: IconButton(
                        icon: Icon(
                          isListening ? FeatherIcons.mic : FeatherIcons.mic,
                          color: Color(0xff87a564),
                          size: 18.0,
                        ),
                        onPressed: () async {
                          if (!isListening) {
                            speech.checkIfAvailable().then((value) async {
                              await speech.listenVoice((recogniseWords) {
                                if (value) {
                                  setState(() {
                                    isListening = true;
                                  });
                                  setState(() {
                                    query.text = recogniseWords;
                                    suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids.where((data) => data.vehicleRegistrationNumber.contains(RegExp(query.text, caseSensitive: false))).toList();
                                    if (query.text.isNotEmpty) {
                                      isListening = false;
                                    }
                                  });
                                }
                              });
                            });
                          } else {
                            setState(() {
                              isListening = false;
                              speech.stop();
                            });
                          }
                        },
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                        BorderSide(width: 0, style: BorderStyle.none)),
                  ),
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
                              withPickers: widget.withPickers,
                              context: context,
                              startChange: widget.startChange,
                              endChange: widget.endChange,
                              onDonePressed: widget.onDonePressed,
                              vehicleId: suggestionList[i].vehicleId.toString(),
                              vehRegNum: suggestionList[i].vehicleRegistrationNumber,
                              controller: widget.controller,
                              vehStat:suggestionList[i].status,
                              // animationController1: _controller,
                              // animation: _animation
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

  selectDateAndroid({
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
    }
    var pickedTime;
    pickedTime = await showTimePicker(
      helpText: headingTime,
      confirmText: confirmTimeText,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      onTimeSelected(pickedTime);
    }
  }

  Future<Widget> getPicker(context, vehicleId, vehicleRegNum, Function onPressed) {
    TextEditingController startDate = TextEditingController();
    TextEditingController endDate = TextEditingController();
    HistoryReplayDropDown _dropDowns = HistoryReplayDropDown();
    return showDialog(
        context: context,
        builder: (context) {
          String selectedValue = LocaleKeys.today.tr();
          return StatefulBuilder(builder: (context,setState){
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
                        leading:Container(
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
                        // RotatedBox(
                        //     quarterTurns: 9,
                        //     child: Image.asset('assets/images/ic_car.png')
                        // ),
                        title: Text(
                          vehicleRegNum,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        LocaleKeys.select_history_reply_duration.tr(),
                        style: GoogleFonts.poppins(
                            color: Color(0xff87a564),
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                          child: _dropDowns.dropDownAndroid(list, selectedValue,
                                  (newValue) {

                                setState(() {
                                  selectedValue = newValue;
                                });
                              })
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width:double.maxFinite,
                                child: Divider(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text('Or',style: GoogleFonts.italianno(
                                  fontSize: 12.0,
                                  color: Color(0xff87a564),
                                  fontWeight:FontWeight.bold

                              ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width:double.maxFinite,
                                child: Divider(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        LocaleKeys.select_start_date_time.tr(),
                        style: GoogleFonts.poppins(
                            color: Color(0xff87a564),
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          // validator: MultiValidator([
                          //   RequiredValidator(
                          //       errorText: 'Start date & time cannot be null.')
                          // ]),
                          controller: startDate,
                          decoration:
                          InputDecoration(hintText: LocaleKeys.select_start_time.tr()),
                          readOnly: true,
                          onTap: () async {
                            selectDateAndroid(
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
                          // validator: MultiValidator([
                          //   RequiredValidator(
                          //       errorText: 'End date & time cannot be null.')
                          // ]),
                          controller: endDate,
                          decoration:
                          InputDecoration(hintText: LocaleKeys.select_end_time.tr()),
                          readOnly: true,
                          onTap: () async {
                            selectDateAndroid(
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
                      if (formKey.currentState.validate()) {
                        //Navigator.pop(context);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return ProgressDialog1(
                                message: LocaleKeys.loading.tr(),
                              );
                            });
                        if (startDate.text.isEmpty && endDate.text.isEmpty) {
                          var now = DateTime.now();
                          if (selectedValue == list[0]) {//Today
                            startDate.text = now
                                .subtract(Duration(hours: now.hour,minutes: now.minute))
                                .toString();
                            endDate.text = now.toString();
                          } else {//Yesterday

                            var hours = now.subtract(Duration(hours: now.hour,minutes: now.minute));
                            startDate.text = hours
                                .subtract(Duration(hours: 24))
                                .toString();
                            hours = hours.subtract(Duration(minutes: 1));
                            endDate.text = hours.toString();
                          }
                          print(startDate.text);
                          print(endDate.text);
                          startDate.text = "${startDate.text.substring(0, 16)}:00.000";
                          endDate.text = "${endDate.text.substring(0, 16)}:00.000";
                        }
                        onPressed(vehicleId, startDate.text, endDate.text);
                      }
                    },
                    child: Text(
                      LocaleKeys.create_route.tr(),
                      style: GoogleFonts.poppins(
                          color: Color(0xff87a564), fontWeight: FontWeight.bold),
                    ))
              ],
            );
          });
        });
  }

  bool isShow = true;

  Widget carTile(
      {
        BuildContext context,
        bool withPickers,
        String vehicleId,
        String vehRegNum,
        Function startChange,
        Function endChange,
        Function onDonePressed,
        TabController controller,
        String vehStat,
        // AnimationController animationController1,
        // Animation<Offset> animation,

      }) {
    return GestureDetector(
      onTap: () {
        // animationController1.forward();
        // animationController1.isCompleted;
        setState(() {
          isShow = false;
        });
        if (withPickers) {
          getPicker(context, vehicleId, vehRegNum, onDonePressed);
        } else {
          onDonePressed(vehicleId, ' ', ' ');
        }
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: vehStat=='Parked'?Colors.orange[300]
                : vehStat=='Moving'?Color(0xff5E8633)
                :Colors.indigo[300] //blue[400],
        ),
        child: Container(
          //margin: EdgeInsets.only(left: 15),
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xff87a564),
              borderRadius: BorderRadius.circular(8)
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
}
