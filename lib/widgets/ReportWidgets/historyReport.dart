// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:introduction_screen/introduction_screen.dart';
//
// class ExtractHistoryRepot extends StatefulWidget {
//   @override
//   _ExtractHistoryRepotState createState() => _ExtractHistoryRepotState();
// }
//
// class _ExtractHistoryRepotState extends State<ExtractHistoryRepot> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//   double columnAnimation = 0;
//   String endDateString = 'Date';
//   String startDateString = 'Date';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     const bodyStyle = TextStyle(fontSize: 19.0);
//     const pageDecoration = const PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       //pageColor: Color(0xff1e385d),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//     );
//
//     return IntroductionScreen(
//       globalBackgroundColor: Color(0xff2a4771),
//       //animationDuration: 800,
//       key: introKey,
//       pages: [
//         PageViewModel(
//             title: "",
//             decoration: pageDecoration,
//             bodyWidget: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Transform.translate(
//                       offset: Offset(-15, 5),
//                       child: Container(
//                         child: RichText(
//                           text: TextSpan(
//                             text: 'Extract ',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 36,
//                                 color: Color(0xff1d395c)),
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: 'Report',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w800,
//                                     fontSize: 36,
//                                     color: Colors.green),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     //Text("data"),
//                   ],
//                 ),
//                 Container(
//                   width: 450,
//                   //height: 400,
//                   //bottom: 1 * .15,
//                   child: Card(
//                     shadowColor: Color(0xff2a4771),
//                     margin: EdgeInsets.symmetric(vertical: 30),
//                     //margin: EdgeInsets.symmetric(horizontal: 30),
//                     color: Color(0xfff3f4f6),
//                     elevation: 18,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Container(
//                       margin:
//                           EdgeInsets.symmetric(horizontal: 25, vertical: 40),
//                       child: Column(
//                         children: [
//                           buildTextField('Company', Icons.local_post_office),
//                           SizedBox(height: 10),
//                           buildTextField('Model', Icons.car_repair),
//                           SizedBox(height: 10),
//                           buildTextField('Registration no.',
//                               Icons.card_membership_rounded),
//                           SizedBox(height: 10),
//                           buildTextField(
//                               'Showroom Address', Icons.outlet_rounded),
//                           SizedBox(height: 10),
//                           OutlineButton(
//                               //minWidth: MediaQuery.of(context).size.width * 0.7,
//                               //height: 45,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                   side: BorderSide(color: Color(0xff2a4771))),
//                               onPressed: () {
//                                 DatePicker.showDateTimePicker(context,
//                                     showTitleActions: true,
//                                     minTime: DateTime(2018, 3, 5),
//                                     maxTime: DateTime.now(), onChanged: (date) {
//                                   setState(() {
//                                     startDateString = date.toString();
//                                   });
//                                 }, onConfirm: (date) {
//                                   setState(() {
//                                     startDateString = date.toString();
//                                   });
//
//                                   print('confirm $date');
//                                 },
//                                     currentTime: DateTime.now(),
//                                     locale: LocaleType.en);
//                               },
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.date_range_rounded,
//                                     color: Colors.green,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     'Start ' + startDateString,
//                                     style: TextStyle(color: Color(0xff187b20)),
//                                   ),
//                                 ],
//                               )),
//                           SizedBox(height: 10),
//                           OutlineButton(
//                               //minWidth: MediaQuery.of(context).size.width * 0.7,
//                               //height: 45,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                   side: BorderSide(color: Color(0xff2a4771))),
//                               onPressed: () {
//                                 DatePicker.showDateTimePicker(context,
//                                     currentTime: DateTime.now(),
//                                     showTitleActions: true,
//                                     minTime: DateTime(2018, 3, 5),
//                                     maxTime: DateTime(2019, 6, 7),
//                                     onChanged: (date) {
//                                   setState(() {
//                                     endDateString = date.toString();
//                                   });
//                                   print('change $date');
//                                 }, onConfirm: (date) {
//                                   setState(() {
//                                     endDateString = date.toString();
//                                   });
//                                   print('confirm $date');
//                                 }, locale: LocaleType.en);
//                               },
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.date_range_rounded,
//                                     color: Colors.green,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     'End ' + endDateString,
//                                     style: TextStyle(color: Color(0xff187b20)),
//                                   ),
//                                 ],
//                               )),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ],
//       onDone: () {
//         //application currently support one car.
//
//         //addUserCar();
//         //addUserTracker();
//         Navigator.of(context).pop(
//             //MaterialPageRoute(builder: (_) => Showroom()),
//             );
//       },
//       skipFlex: 0,
//       nextFlex: 0,
//       skip: const Text('Skip'),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Submit', style: TextStyle(fontWeight: FontWeight.w600)),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeColor: Color(0xff2a4771),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//     );
//   }
//
//   buildTextField(String labelText, IconData icon) {
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//         // decoration: BoxDecoration(
//         //   //border: Border(bottom: BorderSide(color: Colors.black, width: 1.0))
//         //   borderRadius: BorderRadius.circular(25),
//         //   color: Colors.grey[200],
//         // ),
//         child: TextField(
//           //controller: tc,
//           autofocus: false,
//           style: TextStyle(height: 1.5), //increases the height of cursor
//           decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderSide:
//                   const BorderSide(color: Color(0xff2a4771), width: 2.0),
//               borderRadius: BorderRadius.circular(25.0),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 15),
//             labelText: labelText,
//             labelStyle: TextStyle(
//               color: Color(0xff2a4771),
//             ),
//             //hintText: labelText,
//             //labelStyle: TextStyle(color: Colors.black87),
//             // icon: Icon(
//             //   icon,
//             //   size: 25,
//             //   color: Colors.black,
//             // ),
//             //prefix: Icon(icon),
//             prefixIcon: Icon(
//               icon,
//               color: Color(0xff04ab64),
//             ),
//
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xff2a4771)),
//                 borderRadius: BorderRadius.circular(40)),
//           ),
//         ));
//   }
// }
