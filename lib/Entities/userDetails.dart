import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserDetails extends ChangeNotifier {
  String gid;
  String gname;
  String status;
  Token token;
  List<Vehicleids> vehicleids;
  bool isScreenRoles;
  List<ScreenRoles> screenRoles;
  bool isAlarmRoles;
  List<AlarmRoles> alarmRoles;
  String clientImage;
  bool loadCarsFirstTime=true;

  String parked = 'Parked';
  String moving = 'Moving';
  String idle = 'Idle';

  //List<LiveLocationPoints> points;

  UserDetails(
      {this.gid,
        this.gname,
        this.status,
        this.token,
        this.vehicleids,
        this.isScreenRoles,
        this.screenRoles,
        this.isAlarmRoles,
        this.alarmRoles,
        this.clientImage,
        //this.points,
      });

  fromJson(Map<String, dynamic> json) {
    gid = json['gid'];
    gname = json['gname'];
    status = json['status'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;

    if (json['vehicleids'] != null) {
      vehicleids = new List<Vehicleids>();
      json['vehicleids'].forEach((v) {
        vehicleids.add(new Vehicleids.fromJson(v));
      });
    }
    isScreenRoles = json['isScreenRoles'];
    if (json['screenRoles'] != null) {
      screenRoles = new List<ScreenRoles>();
      json['screenRoles'].forEach((v) {
        screenRoles.add(new ScreenRoles.fromJson(v));
      });
    }
    isAlarmRoles = json['isAlarmRoles'];
    if (json['alarmRoles'] != null) {
      alarmRoles = new List<AlarmRoles>();
      json['alarmRoles'].forEach((v) {
        alarmRoles.add(new AlarmRoles.fromJson(v));
      });
    }
    clientImage = json['clientImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this.gid;
    data['gname'] = this.gname;
    data['status'] = this.status;
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.vehicleids != null) {
      data['vehicleids'] = this.vehicleids.map((v) => v.toJson()).toList();
    }

    // if (this.points != null) {
    //   data['Latitude'] = this.points.map((v) => v.toJson()).toList();
    // }

    data['isScreenRoles'] = this.isScreenRoles;
    if (this.screenRoles != null) {
      data['screenRoles'] = this.screenRoles.map((v) => v.toJson()).toList();
    }
    data['isAlarmRoles'] = this.isAlarmRoles;
    if (this.alarmRoles != null) {
      data['alarmRoles'] = this.alarmRoles.map((v) => v.toJson()).toList();
    }
    data['clientImage'] = this.clientImage;
    return data;
  }

  notify(){
    notifyListeners();
  }
}

class Token {
  String token;
  String key;

  Token({this.token, this.key});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['key'] = this.key;
    return data;
  }
}

class Vehicleids {
  String vehicleRegistrationNumber;
  int vehicleId;
  String status;
  String speed;
  String dateTime;

  Vehicleids({this.vehicleRegistrationNumber, this.vehicleId});

  Vehicleids.fromJson(Map<String, dynamic> json) {
    vehicleRegistrationNumber = json['VehicleRegistrationNumber'];
    vehicleId = json['VehicleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VehicleRegistrationNumber'] = this.vehicleRegistrationNumber;
    data['VehicleId'] = this.vehicleId;
    return data;
  }
}

class ScreenRoles {
  String role;

  ScreenRoles({this.role});

  ScreenRoles.fromJson(Map<String, dynamic> json) {
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Role'] = this.role;
    return data;
  }
}
class AlarmRoles {
  String role;

  AlarmRoles({this.role});

  AlarmRoles.fromJson(Map<String, dynamic> json) {
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Role'] = this.role;
    return data;
  }
}

