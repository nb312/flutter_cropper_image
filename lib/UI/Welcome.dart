import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../Constant/Constant.dart';

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
    animation = Tween(begin: 50.0, end: 200.0).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          nextPage();
        }
      });

    controller.forward();
  }

  ///jump to the other page.
  void nextPage() {
    Navigator.of(context).pushReplacementNamed(CROPPER_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeWidget(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class WelcomeWidget extends AnimatedWidget {
  WelcomeWidget({Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      color: Colors.blueGrey,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Expanded(
                child: Container(
                    height: animation.value,
                    width: animation.value,
                    child: Image.asset(getAssetsImage("logo"))),
              )
            ],
          ),
          Column(
            verticalDirection: VerticalDirection.up,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                height: animation.value,
                child: Image.asset(getAssetsImage("powered_by")),
              )
            ],
          )
        ],
      ),
    );
  }
}

String getAssetsImage(String name) {
  return "assets/images/$name.png";
}
