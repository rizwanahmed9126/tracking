import 'package:flutter/cupertino.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocationOfSelectedCars extends ChangeNotifier{
  List<CarDetails> cars=[];
  var parkedCount=0;
  var movingCount=0;
  var idleCount=0;
  Map<MarkerId, Marker> markers1 = <MarkerId, Marker>{};

  addCar(CarDetails data){
    cars.add(data);
    notifyListeners();
  }
  removeCar(CarDetails data){
    cars.removeWhere((element) =>element.vehicleId==data.vehicleId);
    cars = cars.toSet().toList();
    notifyListeners();
  }
  updateCarDetails(CarDetails data,int atIndex){
    cars[atIndex]=data;
    notifyListeners();
  }

  clearList(){
    print('clear called');
    cars.clear();
    markers1.clear();
    notifyListeners();
  }

  addMarker(Marker mark , MarkerId id){
    markers1[id]=mark;
  }
}

class LiveLocationOfAllCars extends ChangeNotifier{

  List<CarDetails> cars=[];
  //Map<String,List<CarDetails>> carsMap;
  addCar(CarDetails data){
    cars.add(data);
    notifyListeners();
  }
  addReferenceList(List<CarDetails> refList){
    cars.addAll(refList);
  }
  removeCar(CarDetails data){
    cars.removeWhere((element) =>element==data);
    notifyListeners();
  }
  updateCarDetails(CarDetails data){
    cars[cars.indexWhere((element) => element.vehicleId==data.vehicleId)]=data;
    notifyListeners();
  }

  clearList(){
    cars.clear();
  }
}