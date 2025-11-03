import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Animatedcontain(),));
}

class Animatedcontain extends StatefulWidget {
  const Animatedcontain({super.key});

  @override
  State<Animatedcontain> createState() => _AnimatedcontainState();
}

class _AnimatedcontainState extends State<Animatedcontain> {
double width = 300;
  double height = 200;
  Color color = Colors.red;
  BorderRadius br = BorderRadius.circular(5);
  bool visible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {visible=visible?false:true;

          
          });
        },
      child: Icon(Icons.change_circle)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child:  AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: visible?1:0,
          child: Container(
            
            width: width,
            height: height,
            decoration: BoxDecoration(color: color, borderRadius: br),
          ),
        ),
      ),
    );
  }
}
