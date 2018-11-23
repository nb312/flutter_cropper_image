import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 200.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeWidget(animation: animation);
  }
}

class WelcomeWidget extends AnimatedWidget {
  WelcomeWidget({Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textDirection: TextDirection.ltr,
          children: <Widget>[Text("hello world")],
        ),
        Column(
          verticalDirection: VerticalDirection.up,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(
              "Row 2",
            )
          ],
        )
      ],
    );
  }
}
