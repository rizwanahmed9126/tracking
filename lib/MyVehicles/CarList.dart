import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/getAllSelectedCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Live_Location/MyVehiclesLiveLocation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';


class CarList extends StatefulWidget {
  String vehicleId;
  String vehRegNum;
  String vehStat;
  String speed, timer;

  CarList(
      {this.vehicleId, this.vehRegNum, this.vehStat, this.speed, this.timer});

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  bool rememberMe = false;
  DateTime nowTime = DateTime.now();
  String dateTime;

  bool isCheck = false;

  void hideFloationButton() {
    setState(() {
      Provider.of<GetSelectedCars>(context, listen: false).getValue(false);
    });
  }

  void showFloationButton() {
    setState(() {
      Provider.of<GetSelectedCars>(context, listen: false).getValue(true);
    });
  }

  void countId() {
    if (Provider.of<GetSelectedCars>(context, listen: false).ids.length > 0) {
      showFloationButton();
    } else {
      hideFloationButton();
    }
  }

 // bool showTruck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (Provider.of<UserDetails>(context, listen: false).gname ==
    //         "Malik Associates (C&amp;B)" ||
    //     Provider.of<UserDetails>(context, listen: false).gname ==
    //         "MALIK ASSOCIATE" ||
    //     Provider.of<UserDetails>(context, listen: false).gname ==
    //         "Noor Ahmed Water Tanker") {
    //   showTruck = true;
    //   StaticClass.showTruck=true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final result = DateTime.parse(widget.timer);
    dateTime = convertMinutesToHours(DateTime.now().difference(result).inMinutes);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        setState(() {
          print('this is the current value---$isCheck');
          isCheck = !isCheck;
          print('this is the after value---$isCheck');

          if (isCheck == true) {
            // print('vehicle id added---${widget.vehicleId}');
            Provider.of<GetSelectedCars>(context, listen: false)
                .ids
                .add(widget.vehicleId);
          } else {
            //print('vehicle id removed---${widget.vehicleId}');
            Provider.of<GetSelectedCars>(context, listen: false)
                .removeCar(widget.vehicleId);
          }
          countId();
        });
      },
      child: Container(
        height: 50,
        width: size.width,
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.vehStat == 'Parked'
                ? Colors.orange[300]
                : widget.vehStat == 'Moving'
                    ? Color(0xff5E8633)
                    : widget.vehStat == "Idle"
                        ? Colors.indigo[300]
                        : Colors.redAccent //blue[400],
            ),
        child: Card(
          elevation: 8.0,
          margin: EdgeInsets.zero,
          color: Color(0xff87a564),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: 50.0,
            width: size.width,
            //padding: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff87a564),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                  padding: EdgeInsets.only(left: 5.0),
                  //color: Colors.blue,
                  child: RotatedBox(
                      quarterTurns: StaticClass.showTruck?9:9,
                      child: StaticClass.showTruck
                          ? Image.asset(
                              'assets/images/truckMarker.png',
                            )
                          : Image.asset('assets/images/ic_car.png')
                  ),
                ),
                Container(
                  width: 80,

                  //color: Colors.green,
                  child: Text(
                    widget.vehRegNum,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                // SizedBox(
                //   width: 15.0,
                // ),
                Container(
                  width: 45,

                  //color: Colors.yellow,
                  child: Text(
                    widget.speed ?? "0.0",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // SizedBox(
                //   width: 15.0,
                // ),
                Container(
                  width: 70,

                  //color: Colors.red,
                  child: Text('$dateTime',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   print('this is the current value---$isCheck');
                    //   isCheck = !isCheck;
                    //   print('this is the after value---$isCheck');
                    //
                    //   if (isCheck == true) {
                    //     // print('vehicle id added---${widget.vehicleId}');
                    //     Provider.of<GetSelectedCars>(context, listen: false)
                    //         .ids
                    //         .add(widget.vehicleId);
                    //   } else {
                    //     //print('vehicle id removed---${widget.vehicleId}');
                    //     Provider.of<GetSelectedCars>(context, listen: false)
                    //         .removeCar(widget.vehicleId);
                    //   }
                    //   countId();
                    // });
                    // print('thi is the length---${Provider.of<GetSelectedCars>(context, listen: false).ids.length}');
                  },
                  child: Container(
                    width: 33,
                    //color: Colors.purple,
                    child: isCheck
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Colors.white,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String convertMinutesToHours(int minutes) {
  String value;
  String hours;

  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');

  if (minutes > 59 && minutes < 1440)
    value = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')} hrs';
  else if (minutes >= 1440) {
    var abc = minutes % 1440;
    double day = minutes / 1440;
    int days = day.toInt();

    if (abc == 0) {
      value = '$days day';
    } else if (abc > 59 && abc < 1440) {
      var c = Duration(minutes: abc);
      List<String> parts1 = c.toString().split(':');
      hours = '${parts1[0].padLeft(2, '0')}:${parts1[1].padLeft(2, '0')} hrs';
      value = '$days days';
    } else {
      value = '$days days';
    }
  } else
    value = '${minutes.toString()} min';

  return value;
}
