import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/SelectVehicleForHR.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/main.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Drawer(

      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(context),

                  Text(LocaleKeys.profile.tr(),style: TextStyle(fontSize: 22),),

                  logoutButton(context),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:30,bottom: 20),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: MemoryImage(base64Decode(Provider.of<UserDetails>(context,listen: false).clientImage)),
                              fit: BoxFit.cover
                          )
                      ),

                    ),
                    SizedBox(width: size.width*0.02,),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,

                            child: Text(Provider.of<UserDetails>(context,listen: false).gname, style: TextStyle(fontSize: 19),),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(LocaleKeys.Edit_Profile.tr(), style: TextStyle(fontSize: 15,color: Colors.lightGreen),),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),

              fields(context,LocaleKeys.App_Settings.tr(),Icons.arrow_forward_ios_sharp,Icons.settings),
              fields(context,LocaleKeys.reports.tr(),Icons.arrow_forward_ios_sharp,Icons.analytics_rounded),

              SizedBox(height: size.height*0.32,),

              Container(
                  alignment:Alignment.centerLeft,

                  height: size.height*0.14,
                  width: size.width,
                  decoration:BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 2,
                            spreadRadius: 1
                        )
                      ]
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Icon(Icons.local_taxi,color: Colors.lightGreen,)
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(Provider.of<UserDetails>(context, listen: false).vehicleids.length.toString(),)),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(LocaleKeys.my_vehicles.tr(),style: TextStyle(color: Colors.grey[600]),))
                      ],
                    ),
                  )
              )


            ],
          ),
        ),
      ),

    );
  }
}

