import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/TextWithIcon.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/constants.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatefulWidget {
  final String numberPLate;
  CarDetails carData;

  CustomListTile({
    this.numberPLate,
    this.carData
  });

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Provider.of<LiveLocationOfSelectedCars>(context,listen: false).addCar(widget.carData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.height * 0.01),
      height: 70,
      //size.height*0.11,
      width: size.width * 0.87,
      decoration: BoxDecoration(
          color: Color(0xff4a843e), borderRadius: BorderRadius.circular(22)
          //color: Colors.black26
          ),
      child: Container(
        margin: EdgeInsets.only(right: size.height * 0.014),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [kBoxShadow]),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.015,
                      horizontal: size.width * 0.023),
                  child: Text(
                    widget.numberPLate,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
             ),
            Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.009,
                      horizontal: size.width * 0.015),
                  child: Row(
                    children: [
                      //Icon(Icons.speed),
                      Text(widget.carData.vehicleStatus,style: TextStyle(color: Colors.teal),),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                     // Icon(Icons.add)
                      Text(widget.carData.ignitionStatus.toString(),style: TextStyle(color: Colors.red),)
                    ],
                  ),
                )),
            SizedBox(
              height: size.height * 0.1,
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: [
                    TextWithIcon(
                      icon: Icons.speed,
                      text: widget.carData.speed.toString(),
                      textColor: Colors.black,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextWithIcon(
                        icon: Icons.access_time,
                        text: '24 Mins',
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (check == true) {
                      check = false;
                      Provider.of<LiveLocationOfSelectedCars>(context,listen: false).removeCar(widget.carData);
                    } else {
                      check = true;
                      //print(widget.numberPLate);
                      Provider.of<LiveLocationOfSelectedCars>(context,listen: false).addCar(widget.carData);
                      print('these are the car lat lng-------${widget.carData}');


                    }
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.09,
                        vertical: size.height * 0.01),
                    decoration: BoxDecoration(
                        color: Color(0xff4a843e),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            topRight: Radius.circular(22))),
                    child: check
                        ? Icon(
                            Icons.done,
                            size: 15,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.white,
                          )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
