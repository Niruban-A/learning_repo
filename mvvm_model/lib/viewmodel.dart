import 'package:flutter/material.dart';
import 'datamodel.dart';
Datamodel obj=Datamodel();
class Viewmodel extends ChangeNotifier{
   
  int get currentcount => obj.count;
  void valueincrementer(){
    
  obj.increment();
  notifyListeners();
  }
}