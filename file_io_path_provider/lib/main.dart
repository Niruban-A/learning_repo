import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}
Future<String> get filepath async{
  final filepath = await getApplicationDocumentsDirectory();
  return filepath.path;

}
Future<File> get fileobj async{
  final myfile=await filepath;
  return File("$myfile/content.txt");
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController mycontroller = TextEditingController();
  List<bool> selected = [true, false];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 400,
              child: TextField(
                controller: mycontroller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            ToggleButtons(
              isSelected: selected,
              onPressed: (int index)async{
                if (selected[index]==true){
                  try{
                  final myfile=await fileobj;
                   await myfile.writeAsString("${mycontroller.text}");
                   showDialog(context: context,builder: (_)=>AlertDialog(title: Text("user cache was saved into the file"),));
                  }
                  catch(e){
                    showDialog(context: context,builder: (_)=>AlertDialog(title: Text("$e"),));

                  }
                }
                else{
                  try{
                    final myfile= await fileobj;
                    final data=await myfile.readAsString();
                    showDialog(context: context,builder: (_)=>AlertDialog(title: Text(data),
                    actions: [Text("is the data in the cache file")],));
                    
                  }
                  catch(e){
                    Exception(e);
                  }
                }

              },
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(0.8),
                  child: Text("write"),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(0.8),
                  child: Text("read"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
