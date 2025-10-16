import 'package:flutter/material.dart';

ValueNotifier<int> myvalue = ValueNotifier(0);
void main() {
  runApp(MaterialApp(home: Valuenotifier()));
}

class Valuenotifier extends StatelessWidget {
  const Valuenotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: myvalue,
              builder: (context, value, child) {
                return Container(width: 300,color: Colors.amber,
                  child: Center(
                    child: Text(
                      "${myvalue.value}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            IconButton(
              onPressed: () {
                myvalue.value++;
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
