import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      home: Displaydata(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Album {
  int id;
  String title;
  Album({required this.id, required this.title});
  factory Album.fromjson(Map<String, dynamic> json) {
    return switch (json) {
      {"id": int id, "title": String title} => Album(id: id, title: title),
      _ => throw FormatException("the format does not correct"),
    };
  }
}

Future<Album> fetchdata(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"title": title}),
  );
  if (response.statusCode == 201) {
    return Album.fromjson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("failed to create album");
  }
}

class Displaydata extends StatefulWidget {
  const Displaydata({super.key});

  @override
  State<Displaydata> createState() => _DisplaydataState();
}

class _DisplaydataState extends State<Displaydata> {
  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 600,
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            controller: mycontroller,
            onSubmitted: (value) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaterialApp(   // 👈 FIX: Wrap with MaterialApp
                    home: GetInput(title: mycontroller.text),
                  ),
                ),
              ),
            },
          ),
        ),
      ),
    );
  }
}

class GetInput extends StatelessWidget {
  const GetInput({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    Future<Album>? myalbum;
    myalbum = fetchdata(title);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: myalbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("title:${snapshot.data!.title}");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
