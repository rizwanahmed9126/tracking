import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class IconUtils {
  static Future<BitmapDescriptor> createSpeedAlertImageFromAsset() async {
    Uint8List markerIcon =
      await getBytesFromAsset('assets/speedAlertMarker.png', 50);


    return BitmapDescriptor.fromBytes(markerIcon);
  }
  static Future<BitmapDescriptor> changeIconImageFromAsset() async {
    Uint8List markerIcon =
    await getBytesFromAsset('assets/002.png', 50);


    return BitmapDescriptor.fromBytes(markerIcon);
  }
  static Future<BitmapDescriptor> createMarkerImageFromAsset(context) async {
    //  Uint8List markerIcon;
    //
    // if(Provider.of<UserDetails>(context,listen: false).gname=="Malik Associates (C&amp;B)" ||
    //     Provider.of<UserDetails>(context,listen: false).gname=="MALIK ASSOCIATE" ||
    //     Provider.of<UserDetails>(context,listen: false).gname=="Noor Ahmed Water Tanker"
    // ){
    //   markerIcon = await getBytesFromAsset('assets/images/truckMarker.png', 50);
    //
    // }
    // else{
    //   markerIcon = await getBytesFromAsset('assets/images/ic_car.png', 50);
    // }
    // return BitmapDescriptor.fromBytes(markerIcon);

    BitmapDescriptor pinLocationIcon;
    if(Provider.of<UserDetails>(context,listen: false).gname=="Malik Associates (C&amp;B)" ||
        Provider.of<UserDetails>(context,listen: false).gname=="MALIK ASSOCIATE" ||
        Provider.of<UserDetails>(context,listen: false).gname=="Noor Ahmed Water Tanker"
    ){
      pinLocationIcon= await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 50)), 'assets/images/truckmarker1.png');
    }
    else{
      pinLocationIcon= await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 50)), 'assets/images/ic_car.png');
    }
    return pinLocationIcon;

  }
  static Future<BitmapDescriptor> createMovingMarkerImageFromAsset() async {
    final Uint8List markerIcon =
    await getBytesFromAsset('assets/greenCar.png', 52);
    return BitmapDescriptor.fromBytes(markerIcon);
  }
  static Future<BitmapDescriptor> createIdleMarkerImageFromAsset() async {
    final Uint8List markerIcon =
    await getBytesFromAsset('assets/002.png', 50);
    return BitmapDescriptor.fromBytes(markerIcon);
  }
  static Future<BitmapDescriptor> createParkedMarkerImageFromAsset() async {
    final Uint8List markerIcon =
    await getBytesFromAsset('assets/003.png', 60);
    return BitmapDescriptor.fromBytes(markerIcon);
  }
  static Future<BitmapDescriptor> idleMarkerImageFromAsset() async {
    final Uint8List markerIcon =
    await getBytesFromAsset('assets/idleMarker.png', 60);
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }


/*ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,"assets/images/ic_car.png");
    return bitmapImage;*/

}
