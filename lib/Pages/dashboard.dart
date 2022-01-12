// import 'dart:collection';
//
// import 'package:animations/animations.dart';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
// import 'package:flutter_map_marker_animation_example/Entities/Mechanics.dart';
// import 'package:flutter_map_marker_animation_example/Entities/carEntity.dart';
// import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
// import 'package:flutter_map_marker_animation_example/Global/GlobalWidgets.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Currentlocation.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
// import 'package:flutter_map_marker_animation_example/Pages/data.dart';
// import 'package:flutter_map_marker_animation_example/Pages/map.dart';
// import 'package:flutter_map_marker_animation_example/widgets/myappbar.dart';
// import 'package:flutter_map_marker_animation_example/widgets/myflexibleappbar.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:we_slide/we_slide.dart';
//
// class MainDashboard extends StatefulWidget {
//   @override
//   _MainDashboardState createState() => _MainDashboardState();
// }
//
// class _MainDashboardState extends State<MainDashboard> {
//
//   int currentIndex = 0;
//   PageController _pageController;
//   List<String> carNum = []
//       //Provider.of<UserDetails>(context, listen: false).vehicleids[i].vehicleRegistrationNumber
//   //['aBC-123', 'DEF-456', 'GHI-789', 'JKL-101112'];
//
//
//
//
//   TextEditingController editingController = TextEditingController();
//   var items = List<String>();
//
//   void filterSearchResults(String query) {
//     if (query.isNotEmpty) {
//       List<String> dummyListData = List<String>();
//       carNum.forEach((item) {
//         if (item.contains(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();
//         items.addAll(carNum);
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     items.addAll(carNum);
//     super.initState();
//     _pageController = PageController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       bottom: false,
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           body: SizedBox.expand(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() => currentIndex = index);
//               },
//               children: <Widget>[
//                 Container(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
//                           child: TextField(
//                             autofocus: false,
//                             onChanged: (value) {
//
//                               filterSearchResults(value.toUpperCase());
//                             },
//                             controller: editingController,
//                             decoration: InputDecoration(
//                                 labelText: "Search",
//                                 hintText: "Search",
//                                 prefixIcon: Icon(Icons.search),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(30.0)))),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
//                           child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             physics: BouncingScrollPhysics(),
//                             itemCount: items.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return _buildPlayerModelList(
//                                   "${items[index]}", index);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Container(
//                 //   child: VehicleDetailMap(
//                 //     appbarName: "Your",
//                 //   ),
//                 // ),
//
//               ],
//             ),
//           ),
//
//       ),
//     );
//   }
//
//   Widget _buildPlayerModelList(String name, int i) {
//     return Card(
//       child: ExpansionTile(
//         leading: CircleAvatar(
//           backgroundColor: Color(0xff187b20),
//           child: Text((i + 1).toString(),
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         initiallyExpanded: false,
//         childrenPadding: EdgeInsets.only(bottom: 20),
//         title: Text(
//           name,
//           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//         ),
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height / 4,
//
//             child: Container(),
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// // class SearchCars extends StatefulWidget {
// //   @override
// //   _SearchCarsState createState() => _SearchCarsState();
// // }
// //
// // class _SearchCarsState extends State<SearchCars> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_map_marker_animation_example/Pages/markerAnimation copy.dart';
// // import 'package:flutter_map_marker_animation_example/Home.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:flutter_map_marker_animation_example/Pages/Profile.dart';
// //
// //
// // class Dashboard extends StatefulWidget {
// //   @override
// //   _DashboardState createState() => _DashboardState();
// // }
// //
// // class _DashboardState extends State<Dashboard> {
// //
// //   int _selectedIndex=0;
// //
// //   void _onTapTapped(int index){
// //     setState(() {
// //       _selectedIndex=index;
// //     });
// //   }
// //
// //   List<Widget> _pages=<Widget>[
// //
// //     Home(),
// //
// //     Home(),
// //
// //     Profile(),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _pages.elementAt(_selectedIndex),
// //
// //       bottomNavigationBar: BottomNavigationBar(
// //         items: [
// //           BottomNavigationBarItem(icon: Icon(Icons.home_outlined,),label: 'Home',),
// //
// //           BottomNavigationBarItem(icon: Icon(Icons.payment),label: 'Pay'),
// //
// //           BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile'),
// //         ],
// //         currentIndex: _selectedIndex,
// //         selectedLabelStyle: GoogleFonts.poppins(fontSize: 15),
// //         unselectedLabelStyle: GoogleFonts.poppins(fontSize: 15),
// //         selectedItemColor: Color(0xff36b14d),
// //         backgroundColor: Colors.white,
// //         onTap: _onTapTapped,
// //       ),
// //
// //     );
// //   }
// // }
