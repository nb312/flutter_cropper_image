import 'package:flutter/material.dart';
import 'UI/Welcome.dart';
import 'UI/CropperScreen.dart';
import 'Constant/Constant.dart';

void main() => runApp(NBApp());

class NBApp extends StatefulWidget {
  @override
  NBState createState() => NBState();
}

class NBState extends State<NBApp> {
  @override
  Widget build(BuildContext context) => _showMain();
}

Widget _showMain() {
  var app = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Welcome(),
    routes: <String, WidgetBuilder>{
      WELCOME_SCREEN: (BuildContext context) => Welcome(),
      CROPPER_SCREEN: (BuildContext context) => CropperScreen(),
    },
  );
  return app;
}
