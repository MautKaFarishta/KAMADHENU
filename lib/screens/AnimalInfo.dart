// import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/screens/home.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

String animal_id;
bool sell = true;
String price;
String breed;
File imageFile;

class AnimalInfo extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Animal_Info();
  }
}

class Animal_Info extends State<AnimalInfo> {
  _openGallery(BuildContext context) async {
    final picture = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/ImagePicker');
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
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
            title: Text("Choose your Option"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galley"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(
                      "Camera",
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

  Widget _flatButton() {
    return FlatButton(
        highlightColor: Colors.green[300],
        color: Colors.green[200],
        child: Text(
          "Sell",
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        onPressed: () => {
              setState(() {
                sell = false;
              })
            });
  }

  Widget _priceForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: "Enter Price",
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.length > 8) {
              return "please Enter approprite value";
            }
          },
          onChanged: (value) => {
            price = value,
          },
        ),
        FlatButton(
          padding: EdgeInsets.all(6.0),
          child: Text("Submit"),
          color: Colors.blue[200],
          onPressed: () => {_showChoiceDialogue(context)},
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    if (sell == true) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Animal Information"),
        ),
        body: Center(
          child: _flatButton(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Animal Information"),
        ),
        body: Container(
          child: _priceForm(),
        ),
      );
    }
  }
}
