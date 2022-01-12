// import 'package:flutter/cupertino.dart';
// import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
// import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
//
// class SearchForCars extends ChangeNotifier{
//   List<Vehicleids> cars=[];
//
//   addCar(Vehicleids obj){
//     clearList();
//     int check = cars.indexWhere((element) => element.vehicleId==obj.vehicleId);
//     if(check>0){
//       cars[check]=obj;
//     }
//     else{
//       cars.add(obj);
//     }
//     notifyListeners();
//   }
//
//   addList(List<Vehicleids> refList){
//     cars.addAll(refList);
//   }
//
//   clearList(){
//     cars.clear();
//     notifyListeners();
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter_map_marker_animation_example/Entities/carDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/userDetails.dart';
class   SearchForCars extends ChangeNotifier{
  List<Vehicleids> cars=[];
  List<Vehicleids> suggestionList=[];
  addCar(Vehicleids obj){
    clearList();
    int check = cars.indexWhere((element) => element.vehicleId==obj.vehicleId);
    if(check>0){
      cars[check]=obj;
    }
    else{
      cars.add(obj);
    }
    notifyListeners();
  }
  addSuggestion(Vehicleids obj){
    suggestionList.clear();
    int check = suggestionList.indexWhere((element) => element.vehicleId==obj.vehicleId);
    if(check>0){
      suggestionList[check]=obj;
    }
    else{
      suggestionList.add(obj);
    }
    notifyListeners();
  }
  addSuggestionList(List<Vehicleids> refList){
    suggestionList=refList;
    notifyListeners();
  }
  addList(List<Vehicleids> refList){
    cars=refList  ;
  }
  clearSuggestions(){
    suggestionList.clear();
    notifyListeners();
  }
  clearList(){
    cars.clear();
    notifyListeners();
  }
}