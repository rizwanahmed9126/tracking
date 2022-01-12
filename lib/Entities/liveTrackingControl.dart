import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingControl extends ChangeNotifier{

  Map<MarkerId,Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId,Marker> markers2 = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates2 = [];
  PolylineId id = PolylineId("poly2");
  addMarker(MarkerId id, Marker marker){
    markers[id]=marker;
    notifyListeners();
  }
  clearMakerList(){
    markers.clear();
    //notifyListeners();
  }

  resetAll(){
    markers2.clear();
    polylines.clear();
    polylineCoordinates2.clear();
  }
  newLocationUpdate(CarDetails latLng, int index, LatLng coord,MarkerId id,var controller,context) async{
    var marker = Marker(
      rotation: latLng.angle.toDouble(),
        flat: true,
        //rotation: 90,
        icon: await IconUtils.changeIconImageFromAsset(),//await IconUtils.createMarkerImageFromAsset(context),
        markerId: id,
        position: LatLng(latLng.latitude, latLng.longitude),
        //LatLng(latLng.latitude,latLng.longitude),
        //anchor: Offset(0.6, 0.5),
        zIndex: 1,
        // ripple: true,
        onTap: () {
        }
    );
    addMarker(id, marker);
    await updateCameraPosition(CameraPosition(target: LatLng(latLng.latitude,latLng.longitude),zoom: 18,bearing: latLng.angle.toDouble()),controller);
    // markers[id] = marker;
    addPolyLine(latLng);
    print('lat lng${latLng.latitude}  ${latLng.longitude}');
    notifyListeners();
  }

  addPolyLine(CarDetails latLng){
      polylineCoordinates2.add(LatLng(latLng.latitude, latLng.longitude));
      Polyline polyline = Polyline(
          width: 6,
          polylineId: id,
          color: Colors.green[300],
          points: polylineCoordinates2);
      polylines[id]=polyline;
      //notifyListeners();
  }
  updateCameraPosition(CameraPosition cPosition,var controller) async {
    final GoogleMapController _controller = await controller.future;
    //await Future.delayed(Duration(seconds: 4));
    _controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

}