import 'package:flutter/material.dart';
import 'package:flutter_image_cropper_demo/Constant/Constant.dart';
import 'package:flutter_image_cropper_demo/Screens/SplashScreen.dart';
import 'package:flutter_image_cropper_demo/Screens/ImageCropperScreen.dart';


import 'package:flutter/material.dart';


main() {

  runApp(new MaterialApp(
//    title: 'Image Cropper App',
    debugShowCheckedModeBanner: true,
//    theme: new ThemeData(
//      accentColor: Colors.blue,
//      primaryColor: Colors.blue,
//      primaryColorDark: Colors.blue
//
//    ),
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      ANIMATED_SPLASH: (BuildContext context) => new SplashScreen(),
      IMAGE_CROPPER_SCREEN: (BuildContext context) => new ImageScreen(),

    },
  ));
}

