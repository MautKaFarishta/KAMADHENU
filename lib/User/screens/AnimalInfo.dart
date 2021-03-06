// import 'dart:html';

import 'dart:io';

import 'package:Kamadhenu/User/UI/decorations.dart';
import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'package:Kamadhenu/User/screens/ImagePicker1.dart';
//import 'package:Kamadhenu/User/screens/ImagePicker1.dart';
import 'package:Kamadhenu/User/screens/VideoPicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/User/screens/home.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Kamadhenu/User/UI/AnimalProfile.dart' as AP;

String animal_id;
String price;
String breed;
File imageFile;
File videoFile;
String rfid;

class AnimalInfo extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Animal_Info();
  }
}

class Animal_Info extends State<AnimalInfo> {
  _openGallery(BuildContext context) async {
    final picture = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/ImagePicker');
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 400, maxWidth: 400);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/ImagePicker');
  }

  Future<void> _showChoiceDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, "Choose your Option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(getTranslated(context, "Gallery")),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(
                      getTranslated(context, "Camera"),
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _priceForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          decoration: Deco().decoBox(Colors.lightBlue.shade200),
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              Text(getTranslated(
                  context, 'Enter Price you expect for this Animal')),
              SizedBox(height: 5),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          margin: EdgeInsets.all(8),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: getTranslated(context, "Enter Price"),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.length > 8) {
                return getTranslated(context, "please Enter approprite value");
              }
            },
            onChanged: (value) => {
              price = value,
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: FlatButton(
            padding: EdgeInsets.all(6.0),
            child: Text(getTranslated(context, "Submit")),
            color: Colors.blue[200],
            onPressed: () => {_showChoiceDialogue(context)},
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: FlatButton(
            padding: EdgeInsets.all(6.0),
            child: Text(getTranslated(context, "Submit")),
            color: Colors.blue[200],
            onPressed: () => {_showChoiceDialogue2(context)},
          ),
        )
      ],
    );
  }

  //video pick
  _openGallery2(BuildContext context) async {
    final video = await ImagePicker()
        .getVideo(source: ImageSource.gallery);
    this.setState(() {
      videoFile = File(video.path);
    });
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VideoPicker()));
  }

  _openCameravideo(BuildContext context) async {
    var video = await ImagePicker()
        .getVideo(source: ImageSource.camera);
    this.setState(() {
      videoFile = File(video.path);
    });
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VideoPicker()));
  }
  Future<void> _showChoiceDialogue2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, "Choose your Option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(getTranslated(context, "Gallery")),
                    onTap: () {
                      _openGallery2(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(
                      getTranslated(context, "Camera"),
                    ),
                    onTap: () {
                      _openCameravideo(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "ANIMAL INFORMATION")),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: _priceForm(),
      ),
    );
  }
}
