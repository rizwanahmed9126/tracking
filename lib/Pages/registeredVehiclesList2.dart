import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryReports.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/MyVehiclesLiveTrack.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisteredVehiclesTwo extends StatefulWidget {
  const RegisteredVehiclesTwo({Key key}) : super(key: key);

  @override
  _RegisteredVehiclesTwoState createState() => _RegisteredVehiclesTwoState();
}

class _RegisteredVehiclesTwoState extends State<RegisteredVehiclesTwo> {
  ScrollController _scrollController = ScrollController();
  bool atTop = true;
  TextEditingController query=TextEditingController();

  List<Vehicleids> suggestionList=[];

  @override
  void initState() {
    super.initState();
    suggestionList.clear();
    suggestionList=Provider.of<UserDetails>(context, listen: false).vehicleids;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        //iconTheme: IconThemeData(
            //color: Color(0xff7EC049)),
        title: Text(LocaleKeys.vehicles.tr(),
          style: GoogleFonts.poppins(
          fontSize: 19.0,
          fontWeight: FontWeight.bold,
          color: Colors.black),
        ),
        //centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width ,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)
                  ),
                  child: Container(
                    height: 50.0,
                    width: double.maxFinite,
                    child: TextFormField(
                      onChanged: (value){
                        if(query.text.isEmpty){
                          setState(() {
                            suggestionList=Provider.of<UserDetails>(context, listen: false).vehicleids;
                          });
                        }
                        else{
                          setState(() {
                            suggestionList=Provider.of<UserDetails>(context, listen: false)
                                .vehicleids.where((data) =>data.vehicleRegistrationNumber.contains(RegExp(query.text,caseSensitive: false))).toList();
                          });
                        }
                      },
                      controller: query,
                      cursorColor: Color(0xff87a564),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                          labelStyle: GoogleFonts.poppins(color: Color(0xff87a564),fontSize: 14.0),
                          labelText: LocaleKeys.search_vrn.tr(),
                          suffixIcon: Icon(FeatherIcons.search,color: Color(0xff87a564),size: 18.0,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none
                              )
                          )
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                Expanded(
                  // flex: 10,
                    child: suggestionList.isNotEmpty? ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestionList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding:  EdgeInsets.only(bottom: 18.0),
                            child: carTile(
                                context: context,
                                vehicleId: suggestionList[i].vehicleId.toString(),
                                vehRegNum: suggestionList[i].vehicleRegistrationNumber,
                                vehStat: suggestionList[i].status
                            ),
                          );
                        }
                    ):
                    Center(
                      child: Text(LocaleKeys.no_cars_available.tr(),style: GoogleFonts.poppins(
                          color: Color(0xff87a564).withOpacity(0.4),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),

        // Stack(
        //   children: [
        //
        //
        //     ListView.builder(
        //         controller: _scrollController,
        //         itemCount: Provider.of<UserDetails>(context, listen: false).vehicleids.length,
        //         itemBuilder: (context, i) {
        //           return ListTile(
        //             leading: CircleAvatar(
        //               backgroundColor: Color(0xff7EC049),
        //               child: Text(
        //                 '${i + 1}',
        //                 style: GoogleFonts.poppins(color: Colors.white),
        //               ),
        //             ),
        //             title: Text(
        //                 Provider.of<UserDetails>(context, listen: false).vehicleids[i]
        //                     .vehicleRegistrationNumber,
        //                 style: GoogleFonts.poppins(fontSize: 20)),
        //             subtitle: Text(
        //                 Provider.of<UserDetails>(context, listen: false)
        //                     .vehicleids[i]
        //                     .vehicleId
        //                     .toString(),
        //                 style: GoogleFonts.poppins(fontSize: 16)),
        //           );
        //         }
        //         ),
        //
        //   ],
        // ),
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
  return Container(
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
  );
}


// Widget carTile({
//   BuildContext context,String vehicleId,String vehRegNum,}) {
//   Size size=MediaQuery.of(context).size;
//   return Container(
//
//       height: 50,
//       width: size.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Color(0xff87a564),
//       ),
//
//
//       child: Padding(
//         padding: const EdgeInsets.only(right: 7.0,left: 7),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: 75,
//
//               child: RotatedBox(
//                   quarterTurns: StaticClass.showTruck?9:6,
//                   child: StaticClass.showTruck
//                       ? Image.asset(
//                     'assets/images/truckMarker.png',
//                   )
//                       : Image.asset('assets/images/ic_car.png')
//               ),
//               // RotatedBox(
//               //     quarterTurns: 9,
//               //     child: Image.asset('assets/images/ic_car.png')
//               // ),
//             ),
//             Container(
//
//               width: 100,
//               child: Text(
//                 vehRegNum,textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 19
//                 ),
//               ),
//             ),
//
//             Container(
//               alignment: Alignment.centerRight,
//               width: 65,
//
//               child: Icon(
//                 Icons.arrow_right_alt_outlined, color: Colors.white,
//                 size: 32,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
// }
