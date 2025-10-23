import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(home: Displaydata(),));
}
class Album{
  int id;
  String title;
  Album({required this.id, required this.title});
  factory Album.fromjson(Map<String,dynamic> json){
    return switch (json){
      {
        "id":int id,"title":String title
      }=> Album(id: id,title: title),
      _=>throw FormatException("the format does not correct")
    };
  }
}
Future <Album> fetchdata (String title)async{
  final response= await http.post(Uri.parse('https://jsonplaceholder.typicode.com/albums') ,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String,String>{
      "title":title
    }) );
    return Album.fromjson(jsonDecode(response.body)as Map<String,dynamic>);

}
class Displaydata extends StatefulWidget {
  const Displaydata({super.key});

  @override
  State<Displaydata> createState() => _DisplaydataState();
}

class _DisplaydataState extends State<Displaydata> {
   TextEditingController mycontroller= TextEditingController();

   
  @override
  Widget build(BuildContext context) {
    return Center(child: TextField(controller: mycontroller,onSubmitted: (value) => {Navigator.push(context, MaterialPageRoute(builder:  (context) => GetInput(),))},
    ),);
  }
}
class GetInput extends StatelessWidget {
  const GetInput({super.key});

  @override
  Widget build(BuildContext context) {
      Future<Album>? myalbum;
        return Scaffold(body:Center(child:Column(children: [FutureBuilder(future: myalbum, builder: (context, snapshot) {
          if(snapshot.hasData){
            return Text("$snapshot");
          }
          else if(snapshot.hasData){
            return Text("${snapshot.error}");
          }
          else{
            return CircularProgressIndicator();
          }
        },)],),) ,);

  }
}