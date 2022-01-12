// import 'package:animations/animations.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map_marker_animation_example/Global/GlobalWidgets.dart';
// import 'package:flutter_map_marker_animation_example/Pages/Currentlocation.dart';
// import 'package:flutter_map_marker_animation_example/Pages/data.dart';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter_map_marker_animation_example/widgets/ReportWidgets/historyReport.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// class ReportsPage extends StatefulWidget {
//   @override
//   _ReportsPageState createState() => _ReportsPageState();
// }
//
// class _ReportsPageState extends State<ReportsPage> {
//   int currentIndex = 0;
//   PageController _pageController;
//   List<NavigationItem> navigationItems = getNavigationItemList();
//   NavigationItem selectedItem;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: Colors.black54),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Text(
//             "Reports",
//             style: TextStyle(color: Colors.black54),
//           ),
//           centerTitle: true,
//         ),
//         drawer: Drawer(
//           elevation: 50,
//           child: ListView(
//             physics: BouncingScrollPhysics(),
//             // Important: Remove any padding from the ListView.
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               Column(
//                   //color: Colors.black,
//                   //margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(top: 50, bottom: 10),
//                       child: DrawerHeader(
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               image: AssetImage('assets/images/profile.png')),
//                         ),
//                         child: null,
//                       ),
//                     ),
//                     Text(
//                       "First Name",
//                       style: TextStyle(color: Colors.black54, fontSize: 22),
//                     ),
//                     Text(
//                       "Email",
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ]),
//               DrawerTiles(context),
//             ],
//           ),
//         ),
//         body: SizedBox.expand(
//           child: PageView(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() => currentIndex = index);
//             },
//             children: <Widget>[
//               //SingleChildScrollView(
//               //  physics: BouncingScrollPhysics(),
//               //child:
//
//               Container(
//                 child: CustomScrollView(
//                   physics: BouncingScrollPhysics(),
//                   slivers: <Widget>[
//                     SliverAppBar(
//                       backgroundColor: Colors.white,
//                       stretch: true,
//                       // title: Text(
//                       //   "data",
//                       //   style: TextStyle(color: Colors.black),
//                       // ),
//                       //pinned: true,
//                       expandedHeight:
//                           MediaQuery.of(context).size.height * 0.150,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Padding(
//                           padding: const EdgeInsets.only(top: 50, left: 30),
//                           child: Text(
//                             "Reports",
//                             style: TextStyle(color: Colors.black, fontSize: 52),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverList(
//                         delegate: SliverChildListDelegate(<Widget>[
//                       SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[50],
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30),
//                               topRight: Radius.circular(30),
//                             ),
//                           ),
//                           child: AnimationLimiter(
//                             child: Column(
//                                 children:
//                                     AnimationConfiguration.toStaggeredList(
//                               duration: const Duration(milliseconds: 500),
//                               childAnimationBuilder: (widget) => SlideAnimation(
//                                 horizontalOffset: 50.0,
//                                 child: FadeInAnimation(
//                                   child: widget,
//                                 ),
//                               ),
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(25, 16, 25, 5),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "SEARCH REPORTS",
//                                         style: TextStyle(
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.grey[400],
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           OpenContainer(
//                                               useRootNavigator: true,
//                                               closedElevation: 0,
//                                               transitionType:
//                                                   ContainerTransitionType
//                                                       .fadeThrough,
//                                               transitionDuration:
//                                                   Duration(milliseconds: 500),
//                                               //openElevation: 6.0,
//                                               openColor: Color(0xff187b20),
//                                               closedShape:
//                                                   RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               50)),
//                                               openShape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           50)),
//                                               //closedColor: Color(0xff187b20),
//                                               openBuilder: (context, _) =>
//                                                   HomeMap(),
//                                               closedBuilder: (context,
//                                                       VoidCallback
//                                                           openContainer) =>
//                                                   Icon(
//                                                     Icons.add_circle_rounded,
//                                                     size: 30,
//                                                     color: Color(0xff04ab64),
//                                                   )
//                                               // IconButton(
//                                               //     icon: Icon(
//                                               //       Icons.add_circle_rounded,
//                                               //       size: 30,
//                                               //       color: Color(0xff04ab64),
//                                               //     ),
//                                               //     onPressed: () {
//                                               //       // Navigator.push(
//                                               //       //     context,
//                                               //       //     MaterialPageRoute(
//                                               //       //         builder: (_) =>
//                                               //       //             AddCar()));
//                                               //     }),
//                                               ),
//                                           // SizedBox(
//                                           //   width: 8,
//                                           // ),
//                                           // Icon(
//                                           //   Icons.arrow_forward_ios,
//                                           //   size: 12,
//                                           //   color: Color(0xff2a4771),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 reportTile("History report (Vehicle)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Trip Alarm report (Vehicle)",
//                                     Colors.white, HomeMap()),
//                                 reportTile(
//                                     "Trip report (Ignition on/off) (Vehicle)",
//                                     Colors.white,
//                                     HomeMap()),
//                                 reportTile(
//                                     "Overspeeding Vehicle Report (Vehicle)",
//                                     Colors.white,
//                                     HomeMap()),
//                                 reportTile("Mileage Report (Vehicle)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("General Alarm Report (Vehicle)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Full Usage Report (Vehicle)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Driver Movement (Vehicle)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Fleet History report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile(
//                                     "Trip Assignment Detailed report (Fleet)",
//                                     Colors.white,
//                                     HomeMap()),
//                                 reportTile("Alarm Diffuse Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Daily Performance Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Overspeeding Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Excess Driving Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Suspicious Movement Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Geo-Fence (In/Out) (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("NR Report (Fleet)", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Trip Fleet Alarm Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Night Violation Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("General Alarm Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Mileage Fleet Report (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile(
//                                     "PortFolio Reporting/NR Vehicles (Fleet)",
//                                     Colors.white,
//                                     HomeMap()),
//                                 reportTile("Daily Total Summary (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Fleet Working Hour (Fleet)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Daily Total Alert (Fleet)",
//                                     Colors.white, HomeMap()),
//                               ],
//                             )),
//                           ),
//                         ),
//                       ),
//                       // ),
//                     ]))
//                   ],
//                 ),
//               ),
//
//               Container(
//                 color: Colors.white,
//                 child: CustomScrollView(
//                   physics: BouncingScrollPhysics(),
//                   slivers: <Widget>[
//                     SliverAppBar(
//                       backgroundColor: Colors.white,
//                       stretch: true,
//                       // title: Text(
//                       //   "data",
//                       //   style: TextStyle(color: Colors.black),
//                       // ),
//                       //pinned: true,
//                       expandedHeight:
//                           MediaQuery.of(context).size.height * 0.150,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Padding(
//                           padding: const EdgeInsets.only(top: 50, left: 30),
//                           child: Text(
//                             "Reports",
//                             style: TextStyle(color: Colors.black, fontSize: 52),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverList(
//                         delegate: SliverChildListDelegate(<Widget>[
//                       SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[50],
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30),
//                               topRight: Radius.circular(30),
//                             ),
//                           ),
//                           child: AnimationLimiter(
//                             child: Column(
//                                 children:
//                                     AnimationConfiguration.toStaggeredList(
//                               duration: const Duration(milliseconds: 500),
//                               childAnimationBuilder: (widget) => SlideAnimation(
//                                 horizontalOffset: 50.0,
//                                 child: FadeInAnimation(
//                                   child: widget,
//                                 ),
//                               ),
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(25, 16, 25, 5),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "SEARCH REPORTS",
//                                         style: TextStyle(
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.grey[400],
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           OpenContainer(
//                                               useRootNavigator: true,
//                                               closedElevation: 0,
//                                               transitionType:
//                                                   ContainerTransitionType
//                                                       .fadeThrough,
//                                               transitionDuration:
//                                                   Duration(milliseconds: 500),
//                                               //openElevation: 6.0,
//                                               openColor: Color(0xff187b20),
//                                               closedShape:
//                                                   RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               50)),
//                                               openShape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           50)),
//                                               //closedColor: Color(0xff187b20),
//                                               openBuilder: (context, _) =>
//                                                   HomeMap(),
//                                               closedBuilder: (context,
//                                                       VoidCallback
//                                                           openContainer) =>
//                                                   Icon(
//                                                     Icons.add_circle_rounded,
//                                                     size: 30,
//                                                     color: Color(0xff04ab64),
//                                                   )
//                                               // IconButton(
//                                               //     icon: Icon(
//                                               //       Icons.add_circle_rounded,
//                                               //       size: 30,
//                                               //       color: Color(0xff04ab64),
//                                               //     ),
//                                               //     onPressed: () {
//                                               //       // Navigator.push(
//                                               //       //     context,
//                                               //       //     MaterialPageRoute(
//                                               //       //         builder: (_) =>
//                                               //       //             AddCar()));
//                                               //     }),
//                                               ),
//                                           // SizedBox(
//                                           //   width: 8,
//                                           // ),
//                                           // Icon(
//                                           //   Icons.arrow_forward_ios,
//                                           //   size: 12,
//                                           //   color: Color(0xff2a4771),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 reportTile("History report", Colors.white,
//                                     ExtractHistoryRepot()),
//                                 reportTile("Trip Alarm report", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Trip report (Ignition on/off)",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Overspeeding Vehicle Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile(
//                                     "Mileage Report", Colors.white, HomeMap()),
//                                 reportTile("General Alarm Report", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Full Usage Report", Colors.white,
//                                     HomeMap()),
//                                 reportTile(
//                                     "Driver Movement", Colors.white, HomeMap()),
//                               ],
//                             )),
//                           ),
//                         ),
//                       ),
//                       // ),
//                     ]))
//                   ],
//                 ),
//               ),
//
//               Container(
//                 child: CustomScrollView(
//                   physics: BouncingScrollPhysics(),
//                   slivers: <Widget>[
//                     SliverAppBar(
//                       backgroundColor: Colors.white,
//                       stretch: true,
//                       // title: Text(
//                       //   "data",
//                       //   style: TextStyle(color: Colors.black),
//                       // ),
//                       //pinned: true,
//                       expandedHeight:
//                           MediaQuery.of(context).size.height * 0.150,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Padding(
//                           padding: const EdgeInsets.only(top: 50, left: 30),
//                           child: Text(
//                             "Reports",
//                             style: TextStyle(color: Colors.black, fontSize: 52),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverList(
//                         delegate: SliverChildListDelegate(<Widget>[
//                       SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[50],
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30),
//                               topRight: Radius.circular(30),
//                             ),
//                           ),
//                           child: AnimationLimiter(
//                             child: Column(
//                                 children:
//                                     AnimationConfiguration.toStaggeredList(
//                               duration: const Duration(milliseconds: 500),
//                               childAnimationBuilder: (widget) => SlideAnimation(
//                                 horizontalOffset: 50.0,
//                                 child: FadeInAnimation(
//                                   child: widget,
//                                 ),
//                               ),
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(25, 16, 25, 5),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "SEARCH REPORTS",
//                                         style: TextStyle(
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.grey[400],
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           OpenContainer(
//                                               useRootNavigator: true,
//                                               closedElevation: 0,
//                                               transitionType:
//                                                   ContainerTransitionType
//                                                       .fadeThrough,
//                                               transitionDuration:
//                                                   Duration(milliseconds: 500),
//                                               //openElevation: 6.0,
//                                               openColor: Color(0xff187b20),
//                                               closedShape:
//                                                   RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               50)),
//                                               openShape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           50)),
//                                               //closedColor: Color(0xff187b20),
//                                               openBuilder: (context, _) =>
//                                                   HomeMap(),
//                                               closedBuilder: (context,
//                                                       VoidCallback
//                                                           openContainer) =>
//                                                   Icon(
//                                                     Icons.add_circle_rounded,
//                                                     size: 30,
//                                                     color: Color(0xff04ab64),
//                                                   )
//                                               // IconButton(
//                                               //     icon: Icon(
//                                               //       Icons.add_circle_rounded,
//                                               //       size: 30,
//                                               //       color: Color(0xff04ab64),
//                                               //     ),
//                                               //     onPressed: () {
//                                               //       // Navigator.push(
//                                               //       //     context,
//                                               //       //     MaterialPageRoute(
//                                               //       //         builder: (_) =>
//                                               //       //             AddCar()));
//                                               //     }),
//                                               ),
//                                           // SizedBox(
//                                           //   width: 8,
//                                           // ),
//                                           // Icon(
//                                           //   Icons.arrow_forward_ios,
//                                           //   size: 12,
//                                           //   color: Color(0xff2a4771),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 reportTile("Fleet History report", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Trip Assignment Detailed report",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Alarm Diffuse Report", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Daily Performance Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Overspeeding Report", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Excess Driving Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Suspicious Movement Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Geo-Fence (In/Out)", Colors.white,
//                                     HomeMap()),
//                                 reportTile(
//                                     "NR Report", Colors.white, HomeMap()),
//                                 reportTile("Trip Fleet Alarm Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile("Night Violation Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile("General Alarm Report", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Mileage Fleet Report", Colors.white,
//                                     HomeMap()),
//                                 reportTile(
//                                     "PortFolio Reporting/NR Vehicles (TDI)",
//                                     Colors.white,
//                                     HomeMap()),
//                                 reportTile("Daily Total Summary", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Fleet Working Hour", Colors.white,
//                                     HomeMap()),
//                                 reportTile("Daily Total Alert", Colors.white,
//                                     HomeMap()),
//                               ],
//                             )),
//                           ),
//                         ),
//                       ),
//                       // ),
//                     ]))
//                   ],
//                 ),
//               ),
//
//               Container(
//                 child: CustomScrollView(
//                   physics: BouncingScrollPhysics(),
//                   slivers: <Widget>[
//                     SliverAppBar(
//                       backgroundColor: Colors.white,
//                       stretch: true,
//                       // title: Text(
//                       //   "data",
//                       //   style: TextStyle(color: Colors.black),
//                       // ),
//                       //pinned: true,
//                       expandedHeight:
//                           MediaQuery.of(context).size.height * 0.150,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Padding(
//                           padding: const EdgeInsets.only(top: 50, left: 30),
//                           child: Text(
//                             "Reports",
//                             style: TextStyle(color: Colors.black, fontSize: 52),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverList(
//                         delegate: SliverChildListDelegate(<Widget>[
//                       SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[50],
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30),
//                               topRight: Radius.circular(30),
//                             ),
//                           ),
//                           child: AnimationLimiter(
//                             child: Column(
//                                 children:
//                                     AnimationConfiguration.toStaggeredList(
//                               duration: const Duration(milliseconds: 500),
//                               childAnimationBuilder: (widget) => SlideAnimation(
//                                 horizontalOffset: 50.0,
//                                 child: FadeInAnimation(
//                                   child: widget,
//                                 ),
//                               ),
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(25, 16, 25, 5),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "SEARCH REPORTS",
//                                         style: TextStyle(
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.grey[400],
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           OpenContainer(
//                                               useRootNavigator: true,
//                                               closedElevation: 0,
//                                               transitionType:
//                                                   ContainerTransitionType
//                                                       .fadeThrough,
//                                               transitionDuration:
//                                                   Duration(milliseconds: 500),
//                                               //openElevation: 6.0,
//                                               openColor: Color(0xff187b20),
//                                               closedShape:
//                                                   RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               50)),
//                                               openShape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           50)),
//                                               //closedColor: Color(0xff187b20),
//                                               openBuilder: (context, _) =>
//                                                   HomeMap(),
//                                               closedBuilder: (context,
//                                                       VoidCallback
//                                                           openContainer) =>
//                                                   Icon(
//                                                     Icons.add_circle_rounded,
//                                                     size: 30,
//                                                     color: Color(0xff04ab64),
//                                                   )
//                                               // IconButton(
//                                               //     icon: Icon(
//                                               //       Icons.add_circle_rounded,
//                                               //       size: 30,
//                                               //       color: Color(0xff04ab64),
//                                               //     ),
//                                               //     onPressed: () {
//                                               //       // Navigator.push(
//                                               //       //     context,
//                                               //       //     MaterialPageRoute(
//                                               //       //         builder: (_) =>
//                                               //       //             AddCar()));
//                                               //     }),
//                                               ),
//                                           // SizedBox(
//                                           //   width: 8,
//                                           // ),
//                                           // Icon(
//                                           //   Icons.arrow_forward_ios,
//                                           //   size: 12,
//                                           //   color: Color(0xff2a4771),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 reportTile("Managment Summary Report",
//                                     Colors.white, HomeMap()),
//                                 reportTile(
//                                     "PMP Report", Colors.white, HomeMap()),
//                                 reportTile(
//                                     "Local Report", Colors.white, HomeMap()),
//                                 reportTile("PMP+Local Report", Colors.white,
//                                     HomeMap()),
//                               ],
//                             )),
//                           ),
//                         ),
//                       ),
//                       // ),
//                     ]))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           //color: Colors.amber,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.all(
//               Radius.circular(90),
//             ),
//           ),
//           child: BottomNavyBar(
//             backgroundColor: Colors.white,
//             showElevation: true,
//             containerHeight: 63,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             animationDuration: Duration(milliseconds: 400),
//             curve: Curves.easeInOutBack,
//             selectedIndex: currentIndex,
//             onItemSelected: (index) {
//               setState(() => currentIndex = index);
//               _pageController.jumpToPage(index);
//             },
//             items: <BottomNavyBarItem>[
//               BottomNavyBarItem(
//                 textAlign: TextAlign.center,
//                 icon: Icon(Icons.report_gmailerrorred_rounded),
//                 title: Text("All Reports"),
//                 activeColor: Color(0xff00adb5),
//                 inactiveColor: Colors.black54,
//               ),
//               BottomNavyBarItem(
//                 textAlign: TextAlign.center,
//                 icon: Icon(Icons.car_repair),
//                 title: Text("Vehical"),
//                 activeColor: Colors.red,
//                 inactiveColor: Colors.black54,
//               ),
//               BottomNavyBarItem(
//                 textAlign: TextAlign.center,
//                 icon: Icon(Icons.emoji_transportation_rounded),
//                 title: Text("Fleet"),
//                 activeColor: Colors.red,
//                 inactiveColor: Colors.black54,
//               ),
//               BottomNavyBarItem(
//                 textAlign: TextAlign.center,
//                 icon: Icon(Icons.settings),
//                 title: Text("Customized"),
//                 activeColor: Colors.green,
//                 inactiveColor: Colors.black54,
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Widget reportTile(String name, Color color, Widget ow) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           CupertinoPageRoute(builder: (context) => ow),
//         );
//       },
//       child: Padding(
//         padding: EdgeInsets.only(right: 10, left: 10),
//         child: Card(
//           //color: Color(0xff00adb5),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           elevation: 0.1,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                   colors: [
//                     //Colors.green[300],
//                     Colors.black12,
//                     color,
//                   ]),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(30),
//               ),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
//             height: 80,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             name,
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                             overflow: TextOverflow.clip,
//                           ),
//                         ),
//                         // Text(
//                         //   "Nearest and all",
//                         //   style: TextStyle(
//                         //     fontSize: 16,
//                         //     color: Colors.white,
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(25),
//                     ),
//                   ),
//                   height: 50,
//                   width: 50,
//                   child: Center(
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
