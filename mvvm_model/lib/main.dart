import 'package:flutter/material.dart';
import 'viewmodel.dart';

void main() {
  runApp(MaterialApp(home: Viewclass()));
}

Viewmodel vm = Viewmodel();

class Viewclass extends StatelessWidget {
  const Viewclass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            ListenableBuilder(
              listenable: vm,
              builder: (context, child) => Text(
                "${vm.currentcount}",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                vm.valueincrementer();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
