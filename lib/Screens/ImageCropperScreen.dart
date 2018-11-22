import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';


class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Cropper App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
      accentColor: Colors.red,
      primaryColor: Colors.red,
      primaryColorDark: Colors.red),

      home: CropScreen(
        title: 'Image Cropper App',
      ),
    );
  }
}

class CropScreen extends StatefulWidget {
  final String title;

  CropScreen({this.title});

  @override
  _CropScreenState createState() => _CropScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CropScreenState extends State<CropScreen> {
  AppState state;
  File imageFile;
  String btnText="Pick Image";

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),

      ),


    body: Center(
      child:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[

          new Center(
            child: new AspectRatio(
              aspectRatio: 80 / 100,
              child: imageFile != null ? Image.file(imageFile) : Container(),
            ),
          ),

          new Padding(
            padding: EdgeInsets.only(
                left: 48.0, top: 45.0, bottom: 10.0,right: 48.0),
            child: new RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius:
                  new BorderRadius.circular(30.0)),
              onPressed: () {
                if (state == AppState.free){
                  _pickImage();

                }

                else if (state == AppState.picked){
                  _cropImage();

                }
                else if (state == AppState.cropped){
                  _clearImage();
                }
              },
              child: new Row(
                children: <Widget>[
                  _buildButtonIcon(),

                  new Image.asset(
                    "assets/images/substract.png",
                    height: 24.0,
                    width: 24.0,
                    fit: BoxFit.scaleDown,
                  ),
                  new Text(

                    btnText,
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 5.0,
              padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 10.0,
                  bottom: 10.0),
            ),
          ),

        ],
      ),
    )

    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
//      return Icon(Icons.check);
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {

        state = AppState.picked;
        btnText="Crop Image";
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      toolbarTitle: 'Image Cropper',
      toolbarColor: Colors.red,
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
        btnText="Clear Image";

      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      btnText="Pick Image";
      state = AppState.free;
    });
  }
}
