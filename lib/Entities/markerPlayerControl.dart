import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/Mechanics.dart';
import 'package:flutter_map_marker_animation_example/Entities/textSpeaker.dart';
import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';

class MarkerPlayerControl extends ChangeNotifier{
  Map<MarkerId,Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId,Marker> markers2 = <MarkerId, Marker>{};

  List<CarLocationDetails> carCoordinates=[];
  TextSpeaker _tts = TextSpeaker();
  double startPointCount=0.0;

  bool isPaused=false;
  int i=0;
  bool firstTime=false;
  int j=0;
  int k=0;
  addMarker(MarkerId id, Marker marker){
    markers[id]=marker;
    notifyListeners();
  }
  changeMarker(MarkerId id,int index,var controller,context)async{
    print("Index:--------------$index");
    i=index;
    var marker = Marker(
        flat: true,
        //rotation: 90,
        icon: await IconUtils.createMarkerImageFromAsset(context),
        markerId: id,
        position: LatLng(carCoordinates[index].latitude,carCoordinates[index].longitude),
        //LatLng(latLng.latitude,latLng.longitude),
        anchor: Offset(0.6, 0.5),
        zIndex: 1,
        // ripple: true,
        onTap: () {
        }
    );
    addMarker(id, marker);
    newLocationUpdate(context,carCoordinates[index], index, LatLng(0.0, 0.0), id, controller);
  }
  addCarCoordinates(List<CarLocationDetails> refList){
    carCoordinates=refList;
  }
  clearMakerList(){
    markers.clear();
    //notifyListeners();
  }
  pauseMarker(){
    isPaused=true;
  }
  resumeMarker(MarkerId id,var controller,BuildContext context){
    isPaused=false;
    runMarker(id,controller,context);
    //addIdleDots(context);
  }
  resetAll(){
    markers2.clear();
    markers.clear();
    isPaused=false;
    i=0;
  }
  runMarker(MarkerId id,var controller,BuildContext context)async{
    if(firstTime){
      await Future.delayed(Duration(seconds: 1));
      firstTime=false;
    }
    markers.clear();
    // addIdleDots(context);
    while (isPaused!=true) {
      if (i >= carCoordinates.length) {
        i=0;
        j=0;
        k=0;
        // await _tts.setLanguageToEnglish();
        // _tts.speakInGirlVoice('history replay has been completed');
        return "completed";
        break;
      }
      if (!isPaused) {
        if(carCoordinates[i].vehicleStatus=='Parked')
        {
          getParkedLocationPins(LatLng(carCoordinates[i].latitude, carCoordinates[i].longitude), j);
          j+=1;
        }
        if(carCoordinates[i].vehicleStatus=='Idle')
        {
          getIdleLocationPins(LatLng(carCoordinates[i].latitude, carCoordinates[i].longitude), k);
          k+=1;
        }
        newLocationUpdate(context,carCoordinates[i], i, LatLng(0.0, 0.0),id,controller);
        await Future.delayed(Duration(milliseconds: 1800));
        i = i + 1;
      }
    }
  }

  newLocationUpdate(context,CarLocationDetails latLng, int index, LatLng coord,MarkerId id,var controller) async{
    var marker = Marker(
        flat: true,
        //rotation: 90,
        icon: await IconUtils.createMarkerImageFromAsset(context),
        markerId: id,
        position: LatLng(latLng.latitude, latLng.longitude),
        //LatLng(latLng.latitude,latLng.longitude),
        anchor: Offset(0.6, 0.5),
        zIndex: 1,
        // ripple: true,
        onTap: () {
        }
    );
    addMarker(id, marker);
    await updateCameraPosition(CameraPosition(target: LatLng(latLng.latitude,latLng.longitude),zoom: 14,bearing: 30.0,),controller);
    // markers[id] = marker;
  }
  updateCameraPosition(CameraPosition cPosition,var controller) async {
    final GoogleMapController _controller = await controller.future;
    //await Future.delayed(Duration(seconds: 4));
    _controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }
  //int j=0;
  getParkedLocationPins(LatLng value,int j)async{
    final marker = Marker(
      icon:  await IconUtils.createParkedMarkerImageFromAsset(),
      markerId: MarkerId('Parked ${value.latitude}'),
      position: LatLng(value.latitude, value.longitude),
      infoWindow: InfoWindow(title: 'Parked ${ParkedMarkers.parkedTimeGraph[j]}'),
    );
    markers[MarkerId('Parked ${value.latitude}')] = marker;
    notifyListeners();
  }
  getIdleLocationPins(LatLng value,int j)async{
    final marker = Marker(
        icon:  await IconUtils.idleMarkerImageFromAsset(),
        markerId: MarkerId('Idle ${value.latitude}'),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: InfoWindow(title: 'Idle ${ParkedMarkers.parkedTimeGraph[j]}'
        )
    );
    markers[MarkerId('Idle ${value.latitude}')] = marker;
    notifyListeners();
  }
  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    BigInt Big0 = BigInt.from(0);
    BigInt Big0x1f = BigInt.from(0x1f);
    BigInt Big0x20 = BigInt.from(0x20);
    while (index < len) {
      int shift = 0;
      BigInt b, result;
      result = Big0;
      do {
        b = BigInt.from(encoded.codeUnitAt(index++) - 63);
        result |= (b & Big0x1f) << shift;
        shift += 5;
      } while (b >= Big0x20);
      BigInt rshifted = result >> 1;
      int dlat;
      if (result.isOdd)
        dlat = (~rshifted).toInt();
      else
        dlat = rshifted.toInt();
      lat += dlat;
      shift = 0;
      result = Big0;
      do {
        b = BigInt.from(encoded.codeUnitAt(index++) - 63);
        result |= (b & Big0x1f) << shift;
        shift += 5;
      } while (b >= Big0x20);
      rshifted = result >> 1;
      int dlng;
      if (result.isOdd)
        dlng = (~rshifted).toInt();
      else
        dlng = rshifted.toInt();
      lng += dlng;
      poly.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }
    return poly;
  }
}