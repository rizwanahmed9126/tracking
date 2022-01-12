import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryReports.dart';
import 'package:flutter_map_marker_animation_example/Entities/Mechanics.dart';
import 'package:flutter_map_marker_animation_example/Entities/VehicleParkedTime.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/faltu.dart';
import 'package:flutter_map_marker_animation_example/Entities/getAllSelectedCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/liveLocationCars.dart';
import 'package:flutter_map_marker_animation_example/Entities/payload.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/SelectSpeedVehicle.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import '../HistoryReplay/markerAnimation copy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
import 'package:provider/provider.dart';

Future<String> getAllCarStatus(BuildContext context)async {
  try {
    String token = Provider.of<UserDetails>(context, listen: false).token.token;
    for (var data in Provider.of<UserDetails>(context, listen: false).vehicleids) {
      String url = "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETVEHICLELIVE?vehicleid=${data.vehicleId}&token=$token";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.substring(77, response.body.length - 10).length > 0) {
          var jsonDecoded = json.decode(response.body.substring(77, response.body.length - 10));





            data.status = jsonDecoded['VehicleStatus'];
            data.speed = jsonDecoded['Speed'].toString();
            data.dateTime = jsonDecoded['ReceiveDateTime'].toString();

            Provider.of<UserDetails>(context, listen: false).notify();

        }
      }
    }
    return 'done';
  } catch (e) {
    print(e);
    return null;
  }
}

// Future<List<Mechanics>> getallMechanics() async {
//   var url = 'http://10.0.0.14/app/api/mechanic';
//   var response = await http.get(Uri.parse(url));
//   var users = List<Mechanics>();
//
//   if (response.statusCode == 200) {
//     var usersjson = json.decode(response.body);
//     for (var userjson in usersjson) {
//       users.add(Mechanics.fromJson(userjson));
//     }
//   }
//   return users;
// }

// Future<List<CarLocationDetails>> gethistorydata(String startDateTime, String endDateTime, String vehicleId) async {
//
//   // ParkedMarkers.putMarkers.clear();
//   ParkedMarkers.time.clear();
//   //ParkedMarkers.extra.clear();
//   ParkedMarkers.idleTime.clear();
//
//
//   List parkedTime=[];
//   List calculatedTime=[];
//   int parkCount=0;
//   int parkedSum = 0;
//
//   String responseTime='';
//   LatLng parkedLatlng;
//   bool takeOnePark=true;
//
//
//
//
//   List idleTime=[];
//   List calculateIdleTime=[];
//   int idleSum = 0;
//
//
//   LatLng idleLatLng;
//   bool takeOneIdle=true;
//
//
//
//
//   print("vehicle ID:- $vehicleId");
//   print("start time:- $startDateTime");
//   print("endDateTime:- $endDateTime");
//   var carlocation = List<CarLocationDetails>();
//   var carLocationUpdated = List<CarLocationDetails>();
//
//   var url =
//       'http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETHISTORYDATA?VEHICLEID=$vehicleId&start=$startDateTime&end=$endDateTime&token=Trackpoint@Xtreme';
//   print(url);
//   var response = await http.get(Uri.parse(url),
//
//   );
//   print('body substring ----${response.body.substring(76,response.body.length - 9)}');
//   print('body length --- ${response.body.length}');
//   String a = response.body.substring(76);
//   if (a != null && a.length >= 9) {
//     a = a.substring(0, a.length - 9);
//   }
//   if (response.statusCode == 200) {
//     var usersjson = json.decode(a);
//     for (var userjson in usersjson) {
//       carlocation.add(CarLocationDetails.fromJson(userjson));
//     }
//   }
//
//   carlocation.forEach((element) {
//
//
//     if(element.vehicleStatus=='Idle')
//     {
//       //  trim date time
//       String s = element.receiveDateTime;
//       int idx = s.indexOf("T");
//       List parts = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
//       String dateTime='${parts[0]} ${parts[1]}';
//
//       idleTime.add(dateTime);
//       idleLatLng=LatLng(element.latitude,element.longitude);
//
//
//       if(takeOneIdle==true)
//       {
//         carLocationUpdated.add(element);
//         takeOneIdle=false;
//       }
//
//       // calculate parked time
//       if(parkedTime.length>0) {
//         for (int i = 1; i < parkedTime.length; i++) {
//           responseTime = '${DateTime.parse(parkedTime[i - 1]).difference(DateTime.parse(parkedTime[i])).inMinutes.toString()}';
//           calculatedTime.add(responseTime);
//         }
//
//
//         for (int j = 0; j < calculatedTime.length; j++) {
//           parkedSum = parkedSum + int.parse(calculatedTime[j]);
//         }
//
//         if (parkedLatlng != null) {
//           ParkedMarkers.putMarkers.add(parkedLatlng);
//
//           ParkedMarkers.parkedTimeGraph.add(parkedSum.abs());
//
//           var parkedDuration=  convertMinutesToHours(idleSum.abs());
//           ParkedMarkers.time.add(parkedDuration);
//
//         }
//
//
//         parkedTime.clear();
//         calculatedTime.clear();
//         parkedLatlng = null;
//         parkedSum = 0;
//       }
//
//     }
//
//     if(element.vehicleStatus=='Parked')
//     {
//       takeOneIdle=true;
//       String s = element.receiveDateTime;
//       int idx = s.indexOf("T");
//       List parts = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
//
//       String dateTime='${parts[0]} ${parts[1]}';
//
//       parkedTime.add(dateTime);
//       parkCount=parkCount+1;
//       parkedLatlng=LatLng(element.latitude,element.longitude);
//
//
//       if(takeOnePark==true)
//       {
//         carLocationUpdated.add(element);
//         takeOnePark=false;
//       }
//
//
//       // getting sum of idle
//       if(idleTime.length>0) {
//         for (int i = 1; i < idleTime.length; i++) {
//           responseTime = '${DateTime.parse(idleTime[i - 1]).difference(DateTime.parse(idleTime[i])).inMinutes.toString()}';
//           calculateIdleTime.add(responseTime);
//         }
//
//
//         for (int j = 0; j < calculateIdleTime.length; j++) {
//           idleSum = idleSum + int.parse(calculateIdleTime[j]);
//         }
//
//         if (idleLatLng != null) {
//           var idleDuration=  convertMinutesToHours(idleSum.abs());
//           ParkedMarkers.idleTime.add(idleDuration);
//
//           ParkedMarkers.idleTimeGraph.add(idleSum.abs());
//
//         }
//
//
//         idleTime.clear();
//         calculateIdleTime.clear();
//         idleLatLng = null;
//         idleSum = 0;
//       }
//
//     }
//
//
//
//
//
//     if(element.vehicleStatus=='Moving')
//     {
//
//
//       takeOnePark=true;
//       takeOneIdle=true;
//
//       if(parkedTime.length>0) {
//         for (int i = 1; i < parkedTime.length; i++) {
//           responseTime = '${DateTime.parse(parkedTime[i - 1]).difference(DateTime.parse(parkedTime[i])).inMinutes.toString()}';
//           calculatedTime.add(responseTime);
//         }
//
//
//         for (int j = 0; j < calculatedTime.length; j++) {
//           parkedSum = parkedSum + int.parse(calculatedTime[j]);
//         }
//
//         if (parkedLatlng != null) {
//           ParkedMarkers.putMarkers.add(parkedLatlng);
//
//
//           ParkedMarkers.parkedTimeGraph.add(parkedSum.abs());
//
//
//           var parkedDuration=  convertMinutesToHours(idleSum.abs());
//           ParkedMarkers.time.add(parkedDuration);
//         }
//
//
//         parkedTime.clear();
//         calculatedTime.clear();
//         parkedLatlng = null;
//         parkedSum = 0;
//       }
//
//
//       if(idleTime.length>0) {
//
//
//         for (int i = 1; i < idleTime.length; i++) {
//           responseTime = '${DateTime.parse(idleTime[i - 1]).difference(DateTime.parse(idleTime[i])).inMinutes.toString()}';
//           calculateIdleTime.add(responseTime);
//         }
//
//
//         for (int j = 0; j < calculateIdleTime.length; j++) {
//           idleSum = idleSum + int.parse(calculateIdleTime[j]);
//         }
//
//
//         if (idleLatLng != null) {
//           var idleDuration=  convertMinutesToHours(idleSum.abs());
//           ParkedMarkers.idleTime.add(idleDuration);
//
//           ParkedMarkers.idleTimeGraph.add(idleSum.abs());
//         }
//
//
//         idleTime.clear();
//         calculateIdleTime.clear();
//         idleLatLng = null;
//         idleSum = 0;
//       }
//
//
//
//       carLocationUpdated.add(element);
//
//     }
//
//
//
//   });
//
//
//   if(parkedTime.length>0) {
//     for (int i = 1; i < parkedTime.length; i++) {
//
//       responseTime = '${DateTime.parse(parkedTime[i - 1]).difference(DateTime.parse(parkedTime[i])).inMinutes.toString()}';
//       calculatedTime.add(responseTime);
//
//     }
//     for (int j = 0; j < calculatedTime.length; j++) {
//       parkedSum = parkedSum + int.parse(calculatedTime[j]);
//     }
//
//
//     if (parkedLatlng != null) {
//       ParkedMarkers.putMarkers.add(parkedLatlng);
//       ParkedMarkers.parkedTimeGraph.add(parkedSum.abs());
//
//       var parkedDuration=  convertMinutesToHours(idleSum.abs());
//       ParkedMarkers.time.add(parkedDuration);
//
//     }
//
//     parkedTime.clear();
//     calculatedTime.clear();
//     parkedLatlng = null;
//     parkedSum = 0;
//   }
//
//
//   if(idleTime.length>0) {
//     for (int i = 1; i < idleTime.length; i++) {
//       responseTime = '${DateTime.parse(idleTime[i - 1]).difference(DateTime.parse(idleTime[i])).inMinutes.toString()}';
//       calculateIdleTime.add(responseTime);
//     }
//
//
//     for (int j = 0; j < calculateIdleTime.length; j++) {
//       idleSum = idleSum + int.parse(calculateIdleTime[j]);
//     }
//
//     if (idleLatLng != null) {
//       var idleDuration=  convertMinutesToHours(idleSum.abs());
//       ParkedMarkers.idleTime.add(idleDuration);
//
//       ParkedMarkers.idleTimeGraph.add(idleSum.abs());
//
//     }
//
//
//     idleTime.clear();
//     calculateIdleTime.clear();
//     idleLatLng = null;
//     idleSum = 0;
//   }
//
//
//
//
//   //  converting mintues into hours
//   //  String convertMinutesToHours(int minutes){
//   //   String value;
//   //
//   //   var d = Duration(minutes:minutes);
//   //   List<String> parts = d.toString().split(':');
//   //
//   //   if(minutes>59 &&minutes<1440)
//   //     value='${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')} hours ago';
//   //
//   //   else if(minutes>1440)
//   //   {
//   //     var days1=Duration(minutes: minutes).inDays;
//   //     print('in days----------$days1');
//   //      var abc=minutes%1440;
//   //
//   //
//   //
//   //     double day = minutes / 1440;
//   //     int days=day.toInt();
//   //     value=days.toString();
//   //   }
//   //
//   //   else
//   //     value='${minutes.toString()} Minutes ago';
//   //
//   //
//   //   print(value);
//   //
//   //   return value;
//   //
//   // }
//
//
//
//
//
//
//
//
//
//   ParkedMarkers.putMarkers.forEach((element) {
//     print('static markers latlng----$element');
//
//   });
//   ParkedMarkers.time.forEach((element) {
//     print('static time parked----$element');
//   });
//
//   ParkedMarkers.idleTime.forEach((element) {
//     print('static time idle----$element');
//   });
//
//   print('length of idle time-------------------------------------${ParkedMarkers.idleTime.length}');
//
//   carLocationUpdated.forEach((element) {
//     print('vehicle status----${element.vehicleStatus}');
//     print('vehicle latitute----${element.latitude}');
//
//   });
//
//
//
//   return carLocationUpdated;
//
// }

Future<List<CarLocationDetails>> gethistorydata(
    String startDateTime, String endDateTime, String vehicleId) async {
  ParkedMarkers.time.clear();
  ParkedMarkers.idleTime.clear();
  ParkedMarkers.parkedTimeGraph.clear();
  ParkedMarkers.idleTimeGraph.clear();
  ParkedMarkers.putMarkers.clear();

  List parkedTime = [];
  List calculatedTime = [];
  int parkedSum = 0;
  String responseTime = '';
  LatLng parkedLatlng;
  bool takeOnePark = true;

  List idleTime = [];
  List calculateIdleTime = [];
  int idleSum = 0;

  LatLng idleLatLng;
  bool takeOneIdle = true;
  var carlocation = List<CarLocationDetails>();
  var carLocationUpdated = List<CarLocationDetails>();

  var url =
      'http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETHISTORYDATA?VEHICLEID=$vehicleId&start=$startDateTime&end=$endDateTime&token=Trackpoint@Xtreme';
  print(url);
  var response = await http.get(
    Uri.parse(url),
  );
  String a = response.body.substring(76);
  if (a != null && a.length >= 9) {
    a = a.substring(0, a.length - 9);
  }
  if (response.statusCode == 200) {
    var usersjson = json.decode(a);
    for (var userjson in usersjson) {
      carlocation.add(CarLocationDetails.fromJson(userjson));
    }
  }
  carlocation.forEach((element) {
    if (element.vehicleStatus == 'Idle') {
      //  trim date time
      String s = element.receiveDateTime;
      int idx = s.indexOf("T");
      List parts = [s.substring(0, idx).trim(), s.substring(idx + 1).trim()];
      String dateTime = '${parts[0]} ${parts[1]}';
      idleTime.add(dateTime);
      idleLatLng = LatLng(element.latitude, element.longitude);

      if (takeOneIdle == true) {
        carLocationUpdated.add(element);
        takeOneIdle = false;
      }
      // calculate parked time
      if (parkedTime.length > 0) {
        for (int i = 1; i < parkedTime.length; i++) {
          responseTime =
              '${DateTime.parse(parkedTime[i - 1]).difference(DateTime.parse(parkedTime[i])).inMinutes.toString()}';
          calculatedTime.add(responseTime);
        }

        for (int j = 0; j < calculatedTime.length; j++) {
          parkedSum = parkedSum + int.parse(calculatedTime[j]);
        }
        if (parkedLatlng != null) {
          ParkedMarkers.putMarkers.add(parkedLatlng);
          ParkedMarkers.time.add(parkedSum.abs());

          var duration = convertMinutesToHours(parkedSum.abs());
          ParkedMarkers.parkedTimeGraph.add(duration);
        }

        parkedTime.clear();
        calculatedTime.clear();
        parkedLatlng = null;
        parkedSum = 0;
      }
    }
    if (element.vehicleStatus == 'Parked') {
      takeOneIdle = true;
      String s = element.receiveDateTime;
      int idx = s.indexOf("T");
      List parts = [s.substring(0, idx).trim(), s.substring(idx + 1).trim()];
      String dateTime = '${parts[0]} ${parts[1]}';
      parkedTime.add(dateTime);
      //parkCount=parkCount+1;
      parkedLatlng = LatLng(element.latitude, element.longitude);

      if (takeOnePark == true) {
        carLocationUpdated.add(element);
        takeOnePark = false;
      }

      // getting sum of idle
      if (idleTime.length > 0) {
        for (int i = 1; i < idleTime.length; i++) {
          responseTime =
              '${DateTime.parse(idleTime[i - 1]).difference(DateTime.parse(idleTime[i])).inMinutes.toString()}';
          calculateIdleTime.add(responseTime);
        }

        for (int j = 0; j < calculateIdleTime.length; j++) {
          idleSum = idleSum + int.parse(calculateIdleTime[j]);
        }
        if (idleLatLng != null) {
          ParkedMarkers.idleTime.add(idleSum.abs());
          var duration = convertMinutesToHours(idleSum.abs());
          ParkedMarkers.idleTimeGraph.add(duration);
        }

        idleTime.clear();
        calculateIdleTime.clear();
        idleLatLng = null;
        idleSum = 0;
      }
    }

    if (element.vehicleStatus == 'Moving') {
      takeOnePark = true;
      takeOneIdle = true;

      if (parkedTime.length > 0) {
        for (int i = 1; i < parkedTime.length; i++) {
          responseTime =
              '${DateTime.parse(parkedTime[i - 1]).difference(DateTime.parse(parkedTime[i])).inMinutes.toString()}';
          calculatedTime.add(responseTime);
        }

        for (int j = 0; j < calculatedTime.length; j++) {
          parkedSum = parkedSum + int.parse(calculatedTime[j]);
        }
        if (parkedLatlng != null) {
          ParkedMarkers.putMarkers.add(parkedLatlng);
          ParkedMarkers.time.add(parkedSum.abs());

          var duration = convertMinutesToHours(parkedSum.abs());
          ParkedMarkers.parkedTimeGraph.add(duration);
        }

        parkedTime.clear();
        calculatedTime.clear();
        parkedLatlng = null;
        parkedSum = 0;
      }

      if (idleTime.length > 0) {
        for (int i = 1; i < idleTime.length; i++) {
          responseTime =
              '${DateTime.parse(idleTime[i - 1]).difference(DateTime.parse(idleTime[i])).inMinutes.toString()}';
          calculateIdleTime.add(responseTime);
        }

        for (int j = 0; j < calculateIdleTime.length; j++) {
          idleSum = idleSum + int.parse(calculateIdleTime[j]);
        }

        if (idleLatLng != null) {
          ParkedMarkers.idleTime.add(idleSum.abs());

          var duration = convertMinutesToHours(idleSum.abs());
          ParkedMarkers.idleTimeGraph.add(duration);
        }

        idleTime.clear();
        calculateIdleTime.clear();
        idleLatLng = null;
        idleSum = 0;
      }

      carLocationUpdated.add(element);
    }
  });

  if (parkedTime.length > 0) {
    for (int i = 1; i < parkedTime.length; i++) {
      responseTime =
          '${DateTime.parse(parkedTime[i - 1]).difference(DateTime.parse(parkedTime[i])).inMinutes.toString()}';
      calculatedTime.add(responseTime);
    }
    for (int j = 0; j < calculatedTime.length; j++) {
      parkedSum = parkedSum + int.parse(calculatedTime[j]);
    }

    if (parkedLatlng != null) {
      ParkedMarkers.putMarkers.add(parkedLatlng);
      ParkedMarkers.time.add(parkedSum.abs());

      var duration = convertMinutesToHours(parkedSum.abs());
      ParkedMarkers.parkedTimeGraph.add(duration);
    }
    parkedTime.clear();
    calculatedTime.clear();
    parkedLatlng = null;
    parkedSum = 0;
  }

  if (idleTime.length > 0) {
    for (int i = 1; i < idleTime.length; i++) {
      responseTime =
          '${DateTime.parse(idleTime[i - 1]).difference(DateTime.parse(idleTime[i])).inMinutes.toString()}';
      calculateIdleTime.add(responseTime);
    }

    for (int j = 0; j < calculateIdleTime.length; j++) {
      idleSum = idleSum + int.parse(calculateIdleTime[j]);
    }
    if (idleLatLng != null) {
      ParkedMarkers.idleTime.add(idleSum.abs());

      var duration = convertMinutesToHours(idleSum.abs());
      ParkedMarkers.idleTimeGraph.add(duration);
    }

    idleTime.clear();
    calculateIdleTime.clear();
    idleLatLng = null;
    idleSum = 0;
  }

  //  converting mintues into hours
  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  return carLocationUpdated;
}

Future<String> logInUser(
    {BuildContext context,
    String username,
    String password,
    String dateTime}) async {
  try {
    String url =
        "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/LOGINVERIFY?username=$username&password=$password&datetime=$dateTime&imei=865339041446804";
    var response = await http.get(Uri.parse(url));
    //print(response.body.substring(76,response.body.length-9));

    if (response.statusCode == 200) {
      var jsonDecode = json.decode(response.body.substring(76, response.body.length - 9));
      // print(jsonDecode['status']);
      //UserDetails.fromJson(jsonDecode);
      Provider.of<UserDetails>(context, listen: false).fromJson(jsonDecode);
      return jsonDecode['status'];
    } else {
      return "Failed";
    }
  } catch (e) {
    return null;
  }
}



Future<List<CarDetails>> getAllCarDetails(BuildContext context) async {
  try {
    List<Vehicleids> vehIds = [];
    List<CarDetails> carDetails = [];
    List<dynamic> abc = [];
    String token = Provider.of<UserDetails>(context, listen: false).token.token;
    for (var data
        in Provider.of<UserDetails>(context, listen: false).vehicleids) {
      String url =
          "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETVEHICLELIVE?vehicleid=${data.vehicleId}&token=$token";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.substring(77, response.body.length - 10).length > 0) {
          var jsonDecoded = json.decode(response.body.substring(77, response.body.length - 10));
          carDetails.add(CarDetails.fromJson(jsonDecoded));
        }
      }
    }

    if (carDetails.isNotEmpty) {
      return carDetails;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<List<HistoryReport>> getHistoryReports(
  context,
  String vrn,
  String groupName,
) async {
  String token = Provider.of<UserDetails>(context, listen: false).token.token;

  String url =
      "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/Get24hTripReportData?VRN=$vrn&GroupName=$groupName&token=$token";

  List<HistoryReport> historyDataCollection = [];
  var response = await http.get(
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    var jsonDecoded =
        json.decode(response.body.substring(76, response.body.length - 9));
    for (var jsonDecoded in jsonDecoded) {
      historyDataCollection.add(HistoryReport.fromJson(jsonDecoded));
    }
  }
  historyDataCollection.forEach((element) {
    print('elememt  ${element.landmark}');
  });

  if (historyDataCollection.isNotEmpty) {
    return historyDataCollection;
  } else
    return null;
}

Future updateAllCarDetails(BuildContext context) async {
  try {
    List<Vehicleids> vehIds = [];
    List<CarDetails> carDetails = [];
    String token = Provider.of<UserDetails>(context, listen: false).token.token;
    vehIds.addAll(Provider.of<UserDetails>(context, listen: false).vehicleids);
    for (var data in vehIds) {
      String url =
          "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETVEHICLELIVE?vehicleid=${data.vehicleId}&token=$token";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.substring(77, response.body.length - 10).length > 0) {
          var jsonDecoded = json
              .decode(response.body.substring(77, response.body.length - 10));
          //print('This Response is second---------------------------------$jsonDecoded');

          //carDetails.add(CarDetails.fromJson(jsonDecoded));
          Provider.of<LiveLocationOfAllCars>(context, listen: false)
              .updateCarDetails(CarDetails.fromJson(jsonDecoded));
        }
      }
    }
  } catch (e) {
    print('Error in getting all car details:- $e');
  }
}

Future getLiveData(BuildContext context) async {
  try {
    List<CarDetails> cars = [];
    List<CarDetails> getData = [];

    String token = Provider.of<UserDetails>(context, listen: false).token.token;
    cars.addAll(
        Provider.of<LiveLocationOfSelectedCars>(context, listen: false).cars);
    int i = 0;
    for (var data in cars) {
      String url =
          "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETVEHICLELIVE?vehicleid=${data.vehicleId}&token=$token";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.substring(77, response.body.length - 10).length > 0) {
          var jsonDecode = json
              .decode(response.body.substring(77, response.body.length - 10));
          for (var jsonDecoded in jsonDecode) {
            getData.add(CarDetails.fromJson(jsonDecode));
          }
          Provider.of<LiveLocationOfSelectedCars>(context, listen: false)
              .updateCarDetails(CarDetails.fromJson(jsonDecode), i);
          i = i + 1;
        }
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<CarDetails> liveTracking(BuildContext context, String vehicleId) async {
  String token = Provider.of<UserDetails>(context, listen: false).token.token;
  String url =
      "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETVEHICLELIVE?vehicleid=$vehicleId&token=$token";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    if (response.body.substring(77, response.body.length - 10).length > 0) {
      var jsonDecode =
          json.decode(response.body.substring(77, response.body.length - 10));
      var data = CarDetails.fromJson(jsonDecode);
      print(data);
      return data;
    }
  }
}

Future<List<CarDetails>> getSelectCars(BuildContext context) async {
  try {
    List<Vehicleids> vehIds = [];
    List<CarDetails> carDetails = [];
    List<dynamic> abc = [];
    String token = Provider.of<UserDetails>(context, listen: false).token.token;
    for (var data in Provider.of<GetSelectedCars>(context, listen: false).ids) {
      String url =
          "http://202.142.175.117/trackpointv2serviceforflutter/androidwsm.asmx/GETVEHICLELIVE?vehicleid=$data&token=$token";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.substring(77, response.body.length - 10).length > 0) {
          var jsonDecoded = json.decode(response.body.substring(77, response.body.length - 10));
          carDetails.add(CarDetails.fromJson(jsonDecoded));
        }
      }
    }

    if (carDetails.isNotEmpty) {
      return carDetails;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<dynamic> getWeatherDetails() async {
  try {
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition.latitude.toString()}&lon=${currentPosition.longitude.toString()}&appid=032a383266f52f8e744ba2eceecf2e81&units=metric";

    print(currentPosition.latitude.toString());
    print(currentPosition.longitude.toString());
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String a = response.body;
      var decodedJsonData = jsonDecode(a);
      return decodedJsonData;
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}



Future<List<Societies>> getData()async{
   String url="https://webmydharti.plugorange.com/api/societies.php";
   List<Societies> data=[];
   //List so = [];
   var response=await http.get(Uri.parse(url));
   if(response.statusCode==200)
   {
     var jsonDecode=json.decode(response.body);
     print('json respon--${Societies.fromJson(jsonDecode).category[1].name}');

       data.add(Societies.fromJson(jsonDecode));


     print('length ${data.length}');

     return data;
   }
   else{
     return null;
   }
}
