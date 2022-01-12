import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Entities/getAllSelectedCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/voiceToTextConvertor.dart';
import 'package:flutter_map_marker_animation_example/Live_Location/LiveLocation.dart';
import 'package:flutter_map_marker_animation_example/Live_Location/MyVehiclesLiveLocation.dart';
import 'package:flutter_map_marker_animation_example/MyVehicles/CarList.dart';
import 'package:flutter_map_marker_animation_example/MyVehiclesLiveTrack.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/main.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisteredVehicles extends StatefulWidget {
  const RegisteredVehicles({Key key}) : super(key: key);

  @override
  _RegisteredVehiclesState createState() => _RegisteredVehiclesState();
}

class _RegisteredVehiclesState extends State<RegisteredVehicles> {
  bool atTop = true;
  TextEditingController query = TextEditingController();
  List<Vehicleids> suggestionList = [];
  List<Vehicleids> updatedSuggestionList = [];

  bool isListening = false;
  VoiceToText speech = VoiceToText();
  bool showLoader = true;
  int duration = 15;
  int durationSum = 0;

  getCarStatus() async {


    await getAllCarStatus(context).then((value) {

      if (value != null) {
        if (Provider.of<UserDetails>(context, listen: false).loadCarsFirstTime) {
          Provider.of<UserDetails>(context, listen: false).loadCarsFirstTime = false;
          setState(() {
            showLoader = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //countId();
    print(DateTime.now());
    Provider.of<GetSelectedCars>(context, listen: false).ids.clear();
    Provider.of<GetSelectedCars>(context, listen: false).showFloatingButton = false;
    if (!Provider.of<UserDetails>(context, listen: false).loadCarsFirstTime) {
      showLoader = false;
    } else {
      showLoader = false;
    }
    suggestionList.clear();
    suggestionList=  Provider.of<UserDetails>(context, listen: false).vehicleids;




    
    //getCarStatus();




    Provider.of<GetSelectedCars>(context, listen: false).ids.clear();
  }


  bool toCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<GetSelectedCars>(
        builder: (context, data, child) {
          return Visibility(
            visible: data.showFloatingButton,
            child: FloatingActionButton(
              onPressed: () {
                Provider.of<GetSelectedCars>(context, listen: false).ids.forEach((element) {
                  print('these are the ids---------------------$element');
                });

                setState(() {
                  if (Provider.of<GetSelectedCars>(context, listen: false).ids.length > 1)
                    toCheck = false;
                  else
                    toCheck = true;
                });

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyVehiclesLive(
                              showVehicle: toCheck,
                            )));
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),

        title: Text(
          LocaleKeys.vehicles.tr(),
          style: GoogleFonts.poppins(
              fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        //centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
          return true;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: showLoader
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/movingcar.gif',
                            height: 100.0,
                            width: 100.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            LocaleKeys.loading_please_wait.tr(),
                            style: GoogleFonts.poppins(
                                color: Color(0xff87a564).withOpacity(0.4),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    //suggestionList = updatedSuggestionList;
                                    suggestionList = Provider.of<UserDetails>(
                                            context,
                                            listen: false)
                                        .vehicleids;
                                  });
                                } else {
                                  setState(() {
                                    suggestionList = Provider.of<UserDetails>(
                                            context,
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
                                      isListening
                                          ? FeatherIcons.mic
                                          : FeatherIcons.mic,
                                      color: Color(0xff87a564),
                                      size: 18.0,
                                    ),
                                    onPressed: () async {
                                      if (!isListening) {
                                        speech
                                            .checkIfAvailable()
                                            .then((value) async {
                                          await speech
                                              .listenVoice((recogniseWords) {
                                            if (value) {
                                              setState(() {
                                                isListening = true;
                                              });
                                              setState(() {
                                                query.text = recogniseWords;
                                                suggestionList = Provider.of<
                                                            UserDetails>(
                                                        context,
                                                        listen: false)
                                                    .vehicleids
                                                    .where((data) => data
                                                        .vehicleRegistrationNumber
                                                        .contains(RegExp(
                                                            query.text,
                                                            caseSensitive:
                                                                false)))
                                                    .toList();
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
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                        // CustomDropdown(text: 'Select',),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {

                                    suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids.where((element) => element.status=='Parked'||element.status=='Moving'||element.status=='Idle').toList();

                                    //suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids;
                                    updatedSuggestionList = suggestionList;
                                    //.where((data) => data.status==parked).toList();
                                  });
                                },
                                child: filterIcons(Icons.all_inclusive, 'All')),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    suggestionList = Provider.of<UserDetails>(context, listen: false).vehicleids.where((data) => data.status == 'Moving').toList();
                                    // updatedSuggestionList = suggestionList;
                                  });
                                },
                                child: filterIcons(Icons.moving, 'Moving')),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    suggestionList = Provider.of<UserDetails>(
                                            context,
                                            listen: false)
                                        .vehicleids
                                        .where(
                                            (data) => data.status == 'Parked')
                                        .toList();
                                    updatedSuggestionList = suggestionList;
                                  });
                                },
                                child:
                                    filterIcons(Icons.local_parking, 'Parked')),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    suggestionList = Provider.of<UserDetails>(
                                            context,
                                            listen: false)
                                        .vehicleids
                                        .where((data) => data.status == 'Idle')
                                        .toList();
                                    updatedSuggestionList = suggestionList;
                                  });
                                },
                                child: filterIcons(Icons.location_on, 'Idle')),
                          ],
                        )),
                        SizedBox(
                          height: 25.0,
                        ),

                        Expanded(
                          child: suggestionList.isNotEmpty
                              ? StreamBuilder(
                                  stream: Stream.periodic(Duration(minutes: 2), (i) {
                                      getCarStatus();

                                  }),
                                  builder: (context, snapshot) {

                                    return Consumer<UserDetails>(
                                      builder: (context, data, _) {
                                        //suggestionList.sort((a,b)=>DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime)));


                                        suggestionList=suggestionList.where((element) => element.status=='Parked'||element.status=='Moving'||element.status=='Idle').toList();
                                        suggestionList.sort((a,b)=>DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime)));
                                       // print('consumer refreshed');
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: suggestionList.length,
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: 15.0),
                                                child: CarList(
                                                  timer: suggestionList[i].dateTime??DateTime.now().toString(),
                                                  speed: suggestionList[i].speed,
                                                  vehicleId: suggestionList[i].vehicleId.toString() ?? 'N/A',
                                                  vehRegNum: suggestionList[i].vehicleRegistrationNumber ?? 'N/A',
                                                  vehStat: suggestionList[i].status,
                                                ),
                                              );
                                            });
                                      },
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    LocaleKeys.no_cars_available.tr(),
                                    style: GoogleFonts.poppins(
                                        color:
                                            Color(0xff87a564).withOpacity(0.4),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget filterIcons(IconData icon, String text) {
  return Column(
    children: [
      Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200], blurRadius: 10, spreadRadius: 8)
              ],
              borderRadius: BorderRadius.circular(32)),
          child: Center(
              child: Icon(
            icon,
            color: Color(0xff5f8633),
            size: 27,
          ))),
      SizedBox(
        height: 5,
      ),
      Text(text)
    ],
  );
}
