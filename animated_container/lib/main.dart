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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final random = Random();
            width = random.nextInt(300).toDouble();
            height = random.nextInt(300).toDouble();
            color=Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256),1);
            br=BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      child: Icon(Icons.change_circle)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: width,
          height: height,
          decoration: BoxDecoration(color: color, borderRadius: br),
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}
