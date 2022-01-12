 import 'package:flutter/cupertino.dart';

class GetSelectedCars extends ChangeNotifier{

  List ids=[];
  bool showFloatingButton=false;

  getValue(bool value){
    showFloatingButton=value;
    notifyListeners();

  }

  removeCar(var data){
    ids.removeWhere((element) =>element==data);
    notifyListeners();
  }

 }

