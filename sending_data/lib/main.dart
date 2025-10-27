import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Dog{
  int id;
  String name;
  int age;
  Dog ({required this.id,required this.name,required this.age});
  Map<String,Object?> toMap(){ 
    return {
      "id":id,"name":name,"age":age};

  } 
  String tostring(){
    return "id:$id,name:$name,age:$age";
  }
}
void main () async{
   final database=openDatabase(join("db_database",await getDatabasesPath()),
   onCreate: (db, version) {
    return db.execute("create database dogs(id Integer primarykey,name Text,age Integer)");
   },version: 1);
    void insert(){
      
    }
   
  
}