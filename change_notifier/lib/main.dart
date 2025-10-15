import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(home: Changenotifier()));
}

class Notifierclass extends ChangeNotifier {
  int _count = 1;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

final Notifierclass mynotifier = new Notifierclass();

class Changenotifier extends StatefulWidget {
  const Changenotifier({super.key});

  @override
  State<Changenotifier> createState() => _ChangenotifierState();
}

class _ChangenotifierState extends State<Changenotifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amberAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListenableBuilder(
              listenable: mynotifier,
              builder: (context, child) {
                return Text(
                  "Count:${mynotifier.count}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                );
              },
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                mynotifier.increment();
              },
              child: Text("add"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                mynotifier.decrement();
              },
              child: Text("minus"),
            ),
          ],
        ),
      ),
    );
  }
}
