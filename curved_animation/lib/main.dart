import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home:Curvedanimation()),);
}
class Aniwidget extends AnimatedWidget{
  const Aniwidget({super.key,required Animation<double> animation}):super(listenable: animation);
   static final sizeanimation=Tween<double>( begin: 0,end:600);
   static final opanimation=Tween<double>(begin: 0.1,end:1);

  @override
  Widget build (BuildContext context){
    final animation=listenable as Animation<double>;
   
    return Center(
      child: Opacity(
        opacity: opanimation.evaluate(animation),
        child: SizedBox(
        height: sizeanimation.evaluate(animation),
        width: sizeanimation.evaluate(animation),
        child: Image.asset("assets/img.png")
        
        ),
      ),
    );

  }
}
class Curvedanimation extends StatefulWidget  {
  const Curvedanimation({super.key});

  @override
  State<Curvedanimation> createState() => _CurvedanimationState();
}

class _CurvedanimationState extends State<Curvedanimation> with SingleTickerProviderStateMixin{
  late  AnimationController controller;
  late  Animation<double> animation;

  void initState(){
    super.initState();
   controller=AnimationController(vsync: this,duration: Duration(seconds: 4));
    animation=CurvedAnimation(parent: controller, curve:Curves.bounceInOut)
    ..addStatusListener((status) {
      if (status==AnimationStatus.completed){
        controller.reverse();


      }
      else if(status==AnimationStatus.dismissed){
        controller.forward();
      }
    },);
    controller.forward();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Aniwidget(animation: animation,),);
  }
}