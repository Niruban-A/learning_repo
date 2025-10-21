import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Jsonretrival(),));
}
class Jsonretrival extends StatefulWidget {
  const Jsonretrival({super.key});

  @override
  State<Jsonretrival> createState() => _JsonretrivalState();
}

class _JsonretrivalState extends State<Jsonretrival> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}