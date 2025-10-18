import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home:Favouritewidget()));
}

class Favouritewidget extends StatefulWidget {
  const Favouritewidget({super.key});

  @override
  State<Favouritewidget> createState() => _FavouritewidgetState();
}

class _FavouritewidgetState extends State<Favouritewidget> {
  bool starstate = true;
  int count = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 700, width:1200,
              child: Image.asset(
                "assets/eiffeltower.jpg",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      starstate == true ? count++ : count--;
                      starstate = (!starstate);
                    });
                  },
                  icon: starstate == true
                      ? Icon(Icons.star)
                      : Icon(Icons.star_outlined),
                ),
                Text("$count")
              ],
            ),
          ],
        ),
      ),
    );
  }
}