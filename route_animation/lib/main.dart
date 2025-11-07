import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: RouteAnimation()));
}

class RouteAnimation extends StatelessWidget {
  const RouteAnimation({super.key});

  Route<void> createroute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Secondclass(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin=Offset(0.0, 0.1);
        Offset end=Offset.zero;
        final tween= Tween(begin: begin,end: end).chain(CurveTween(curve: Curves.ease));
        final offsetanimation=animation.drive(tween);


        return SlideTransition(position: offsetanimation,child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(createroute());
          },
          child: Text("Go"),
        ),
      ),
    );
  }
}

class Secondclass extends StatelessWidget {
  const Secondclass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Second page"),
      ),
      backgroundColor: Colors.amberAccent,
    );
  }
}
