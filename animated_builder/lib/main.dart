import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Animationbuild extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final Animation<double> opacityanimation;
  Animationbuild({
    super.key,
    required this.animation,
    required this.child,
    required this.opacityanimation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: opacityanimation.value,
            child: SizedBox(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> opacityanimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 0, end: 600).animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    opacityanimation = Tween<double>(
      begin: 0.1,
      end: 1,
    ).animate(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Animationbuild(
        opacityanimation: opacityanimation,
        animation: animation,
        child: logowidget(),
      ),
    );
  }
}

class logowidget extends StatelessWidget {
  const logowidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset("assets/char.png"),
    );
  }
}
