// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class Mechanics {
//   int mechanicID;
//   String firstName;
//   String lastName;
//   String phone;
//   Null address;
//   double latitude;
//   double longitude;
//   Null insertedBy;
//   Null insertedAt;
//   Null updatedBy;
//   Null updatedAt;
//
//   Mechanics(
//       {this.mechanicID,
//       this.firstName,
//       this.lastName,
//       this.phone,
//       this.address,
//       this.latitude,
//       this.longitude,
//       this.insertedBy,
//       this.insertedAt,
//       this.updatedBy,
//       this.updatedAt});
//
//   Mechanics.fromJson(Map<String, dynamic> json) {
//     mechanicID = json['MechanicID'];
//     firstName = json['FirstName'];
//     lastName = json['LastName'];
//     phone = json['Phone'];
//     address = json['Address'];
//     latitude = json['Latitude'];
//     longitude = json['Longitude'];
//     insertedBy = json['InsertedBy'];
//     insertedAt = json['InsertedAt'];
//     updatedBy = json['UpdatedBy'];
//     updatedAt = json['UpdatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['MechanicID'] = this.mechanicID;
//     data['FirstName'] = this.firstName;
//     data['LastName'] = this.lastName;
//     data['Phone'] = this.phone;
//     data['Address'] = this.address;
//     data['Latitude'] = this.latitude;
//     data['Longitude'] = this.longitude;
//     data['InsertedBy'] = this.insertedBy;
//     data['InsertedAt'] = this.insertedAt;
//     data['UpdatedBy'] = this.updatedBy;
//     data['UpdatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// // class Mechanics {
// //   String name;
// //   String phone;
// //   String address;
// //   LatLng locationCoords;
//
// //   Mechanics({this.name, this.phone, this.address, this.locationCoords});
// // }
//
// final List<Mechanics> mechanicMarkers = [];
// Position currentLocation;
