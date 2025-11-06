import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Radialhero()));
}

class Radialhero extends StatefulWidget {
  const Radialhero({super.key});

  @override
  State<Radialhero> createState() => _RadialheroState();
}

class _RadialheroState extends State<Radialhero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>Secondwidget()
            ),
          );
        },
        child: Hero(
          tag: "hello",
          child: ClipOval(
            
              child:Image.asset("img.png", width: 56,     // ✅ IMPORTANT!
              height: 56,    // ✅ IMPORTANT!
              fit: BoxFit.cover,),
                
              
            
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Scaffold(backgroundColor: Colors.amber),
    );
  }
}

class Secondwidget extends StatelessWidget {
  const Secondwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Hero(
          tag: "hello",
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("img.png"),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
