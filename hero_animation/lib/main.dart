import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(home: Sourceimage()));
}

class Sourceimage extends StatelessWidget {
  const Sourceimage({super.key});
  final photo = "assets/img.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onDoubleTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DestinationWidget(photo: photo)));
          },
          child: Hero(
            
            tag: photo,
            child: SizedBox(
              height: 400,
              width: 400,
              child: Image.asset("assets/img.png"),
            ),
          ),
        ),
      ),
    );
  }
}

class DestinationWidget extends StatelessWidget {
  const DestinationWidget({super.key, required this.photo});
  final photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: Text("Destination Page")),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: photo,
          child: SizedBox(height: 100, width: 100, child: Image.asset(photo)),
        ),
      ),
    );
  }
}
