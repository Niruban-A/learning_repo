import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dog {
  int id;
  String name;
  int age;
  Dog({required this.id, required this.name, required this.age});
  Map<String, Object> tomap() {
    return {"id": id, "name": name, "age": age};
  }

  String tostring() {
    return "id:$id,name:$name,age:$age";
  }
}

void main() async {
  runApp(MaterialApp(home: Databaseopr(),));
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), "dogdatabase.db"),
    onCreate: (db, version) {
      db.execute(
        "Create table dogs (id INTEGER PRIMARY KEY,name TEXT ,age INTEGER)",
      );
    },
    version: 1,
  );
  Future<void> insertdogs(Dog dog) async {
    final db = await database;
    await db.insert(
      "dogs",
      dog.tomap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatesdogs(Dog dog) async {
    final db = await database;
    await db.update("dogs", dog.tomap(), where: "id=?", whereArgs: [dog.id]);
  }

  Future<List<Dog>> alldogs() async {
    final db = await database;
    final alldoggies = await db.query(
      "dogs",
    ); //the value of the code is will belike this  {'id': 1, 'name': 'Bruno', 'age': 4},
    return [
      for (final {"id": id as int, "name": name as String, "age": age as int}
          in alldoggies)
        Dog(id: id, name: name, age: age),
    ];
  }

  Future<void> deletedogs(int id) async {
    final db = await database;
    db.delete("dogs", where: "id=?", whereArgs: [id]);
  }
  Dog pomeranian=  Dog(id: 1, name: "rogger", age: 4);
  await insertdogs(pomeranian) ;
  
 
  await updatesdogs(Dog(id: 1, name: "shiro", age: 5));
  print(await alldogs());
  await deletedogs(1);
  print(await alldogs());
}
class Databaseopr extends StatefulWidget {
  const Databaseopr({super.key});

  @override
  State<Databaseopr> createState() => _DatabaseoprState();
}

class _DatabaseoprState extends State<Databaseopr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Database operation")),);
  }
}