import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const String PAGE_TITLE = "Crop Image Page",
    SELECT_PICTURE = "Select Picture",
    CROP_PICTURE = "Crop Picture",
    RESET_PICTURE = "Reset Picture";

class CropperScreen extends StatefulWidget {
  @override
  WelcomeState createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<CropperScreen> {
  String filePath = "";
  ButtonState buttonState = ButtonState.Empty;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(PAGE_TITLE),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _showPicture(filePath)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  print("press");
                  onPress(this, buttonState);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.blue,
                child: _buttonContent(buttonState),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void onPress(WelcomeState welcome, state) {
  if (state == ButtonState.Empty) {
    _selectPic().then((path) {
      welcome.setState(() {
        if (path.isNotEmpty) {
          welcome.filePath = path;
          welcome.buttonState = ButtonState.Select;
        }
      });
    });
  } else if (state == ButtonState.Select) {
    _cropPic(welcome.filePath).then((path) {
      welcome.setState(() {
        if (path.isNotEmpty) {
          welcome.filePath = path;
          welcome.buttonState = ButtonState.Crop;
        }
      });
    });
  } else if (state == ButtonState.Crop) {
    welcome.setState(() {
      welcome.filePath = "";
      welcome.buttonState = ButtonState.Empty;
    });
  }
}

Future<String> _selectPic() async {
  var file = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file.path;
  } else {
    return "";
  }
}

Future<String> _cropPic(String path) async {
  if (path.isEmpty) return "";
  var file = await ImageCropper.cropImage(
      sourcePath: path,
      ratioX: 1.0,
      ratioY: 1.0,
      toolbarTitle: CROP_PICTURE,
      toolbarColor: Colors.blue);
  if (file != null) {
    return file.path;
  } else {
    return "";
  }
}

Widget _showPicture(String path) {
  if (path.isEmpty) {
    return Container();
  } else {
    return AspectRatio(
      aspectRatio: 80 / 100,
      child: Image.file(File(path)),
    );
  }
}

Widget _buttonContent(ButtonState state) {
  Widget icon = Icon(null);
  String text = "";
  if (state == ButtonState.Empty) {
    text = SELECT_PICTURE;
    icon = Icon(
      Icons.add,
      color: Colors.white,
    );
  } else if (state == ButtonState.Select) {
    text = CROP_PICTURE;
    icon = Icon(
      Icons.crop,
      color: Colors.white,
    );
  } else if (state == ButtonState.Crop) {
    text = RESET_PICTURE;
    icon = Icon(Icons.close, color: Colors.white);
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      icon,
      getAssetImage("substract"),
      Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
    ],
  );
}

Image getAssetImage(String name) {
  return Image.asset("assets/images/$name.png");
}

enum ButtonState { Empty, Select, Crop }
