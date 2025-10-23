import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: Jsonretrival()));
}

class Album {
  final int userId;
  final int id;
  final String title;
  Album({required this.userId, required this.id, required this.title});
  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"userId": int userId, "id": int id, "title": String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException("Failed to load exception"),
    };
  }
}

Future<Album> fetchdata() async {
  final response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/albums/1"
    ),
    headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
  );
  print("${response.statusCode}");
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Faild to load Album!");
  }
}

class Jsonretrival extends StatefulWidget {
  const Jsonretrival({super.key});

  @override
  State<Jsonretrival> createState() => _JsonretrivalState();
}

class _JsonretrivalState extends State<Jsonretrival> {
  late Future<Album> myalbum;
  @override
  void initState() {
    super.initState();
    myalbum = fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: myalbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Text(
                snapshot.data!.title,
                strutStyle: StrutStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              );
            }
            else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else { return CircularProgressIndicator();
              // return Text(
              //   "data not found",
              //   strutStyle: StrutStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     fontStyle: FontStyle.normal,
              //   ),
             // );
            }
          },
        ),
      ),
    );
  }
}
