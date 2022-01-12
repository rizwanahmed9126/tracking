// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
//
// Widget selectDate(BuildContext context,Function onChanged)  {
//   DateTime selectedDate = DateTime.now();
//   DateTime picked=DateTime.now();
//   final picker = CupertinoDatePicker(
//     use24hFormat: true,
//     initialDateTime: selectedDate,
//     onDateTimeChanged: (date){
//       picked=date;
//       onChanged(date);
//     },
//   );
//   return Container(
//     height: 500.0,
//     width: double.infinity,
//     child: picker,
//   );
//   // showCupertinoModalPopup(context: context, builder: (context){
//   //   return Container(
//   //     height: 250.0,
//   //     child: Column(
//   //       children: [
//   //         Container(
//   //             height: 200.0,
//   //             child: picker
//   //         ),
//   //         CupertinoButton(
//   //           child: Text('OK'),
//   //           onPressed: () {
//   //             print(picked);
//   //             Navigator.pop(context,picked);
//   //           },
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
//  //);
//   //return picked;
//
// }
//
//
// Future<Widget> getDatePicker({BuildContext context, Function onStartDateChanged, Function onEndDateChanged,TabController controller,String vehicleId})async{
//
//   return showDialog(
//     barrierDismissible: false,
//       context: context,
//       builder: (context){
//         return Dialog(
//           elevation: 5.0,
//           insetAnimationCurve: Curves.bounceInOut,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0)
//           ),
//           child: Container(
//             height: 350.0,
//             child: Column(
//               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Material(
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0)),
//                   elevation: 5.0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0))
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
//                     child: TabBar(
//                       indicatorColor: Colors.lightGreen,
//                       labelColor: Color(0xff87a564),
//                       unselectedLabelColor: Colors.green[300],
//                       controller: controller,
//                       tabs: [
//                         Tab(
//                           text: 'From',
//                         ),
//                         Tab(
//                           text: 'To',
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   color: Colors.grey[100],
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   height: 240.0,
//                   child: TabBarView(
//                     controller: controller,
//                     children: [
//                       ///Start date selector
//                       selectDate(context, onStartDateChanged
//                       ),
//                       ///End date Selector
//                       selectDate(context, onEndDateChanged
//                       ),
//                     ],
//                   ),
//                 ),
//
//                // Material(
//                //   borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
//                //   elevation: 10.0,
//                   //child:
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))
//                       ),
//                       child: Card(
//                         elevation: 50.0,
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: TextButton(
//                               onPressed: (){},
//                               child:Text('Done',style: GoogleFonts.poppins(color: Color(0xff87a564),fontWeight: FontWeight.bold ),)
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                // )
//               ],
//             ),
//           )
//         );
//       }
//   );
// }
//
// // selectDate(context, (value){
// // print(value);
// // }
// // ),