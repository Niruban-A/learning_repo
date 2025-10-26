import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: DemoPref()));
}

class DemoPref extends StatefulWidget {
  const DemoPref({super.key});

  @override
  State<DemoPref> createState() => _DemoPrefState();
}

class _DemoPrefState extends State<DemoPref> {
  int counter=0;
  int? result=0;

  SharedPreferences? mypref;
  @override
  void initState(){
    super.initState();
    initializer();
  }
  Future<void> initializer() async{
    mypref=await SharedPreferences.getInstance();
    mypref!.setInt("counter", counter);
  }
  Future<void> increment()async{
    setState(() {
      counter++;
      
    });
    mypref!.setInt("counter", counter);
    result=mypref!.getInt("counter");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: increment,child: Icon(Icons.add),),
      body: Center(child: Text("$result"),),
    );
  }
}