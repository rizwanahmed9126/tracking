// import 'dart:convert';
//
// import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
//
// Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));
//
// String payloadToJson(Payload data) => json.encode(data.toJson());
//
// class Payload {
//   Payload({
//     this.version,
//     this.encoding,
//     this.subsonicResponse,
//   });
//
//   String version;
//   String encoding;
//   SubsonicResponse subsonicResponse;
//
//   factory Payload.fromJson(Map<String, dynamic> json) => Payload(
//         version: json["version"],
//         encoding: json["encoding"],
//         subsonicResponse: SubsonicResponse.fromJson(json["subsonic-response"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "version": version,
//         "encoding": encoding,
//         "subsonic-response": subsonicResponse.toJson(),
//       };
// }
//
// class SubsonicResponse {
//   SubsonicResponse({
//     this.status,
//     this.version,
//     this.xmlns,
//     this.albumList,
//   });
//
//   String status;
//   String version;
//   String xmlns;
//   CarLocationDetails albumList;
//
//   factory SubsonicResponse.fromJson(Map<String, dynamic> json) =>
//       SubsonicResponse(
//         status: json["status"],
//         version: json["version"],
//         xmlns: json["xmlns"],
//         albumList: CarLocationDetails.fromJson(json["albumList"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "version": version,
//         "xmlns": xmlns,
//         "albumList": albumList.toJson(),
//       };
// }
