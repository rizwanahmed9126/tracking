// import 'package:flutter/material.dart';
// import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// class SearchBar extends StatefulWidget {
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }
//
// class _SearchBarState extends State<SearchBar> {
//   bool _folded=true;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size=MediaQuery.of(context).size;
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 400),
//       width: _folded ? size.height*0.085:size.height*0.3,
//       height: size.width*0.13,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(32),
//
//
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey[50],
//
//               offset: Offset(1.0,2.0),
//               blurRadius: 60,
//               spreadRadius: 35
//           ),
//         ],
//         //color: Colors.white,
//         color: Colors.white
//       ),
//
//       child: Row(
//         children: [
//           Expanded(
//               child:Container(
//                 padding: EdgeInsets.only(left: size.width*0.028),
//                 child: !_folded ? TextField(
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       hintText: LocaleKeys.Searching.tr(),
//                       border: InputBorder.none,
//                       hintStyle: TextStyle(color: Colors.black),
//                     )
//                 ):null,
//               )
//           ),
//           AnimatedContainer(
//             duration: Duration(milliseconds: 400),
//
//             child: Material(
//               type: MaterialType.transparency,
//               child: InkWell(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(_folded ?32:0),
//                     topRight: Radius.circular(32),
//                     bottomLeft: Radius.circular(_folded ?32:0),
//                     bottomRight: Radius.circular(32)
//                 ),
//
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Icon(
//                     _folded? Icons.search :Icons.close,
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: (){
//                   setState(() {
//                     _folded=!_folded;
//                   });
//
//
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
