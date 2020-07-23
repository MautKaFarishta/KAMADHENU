import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AnimalInfo.dart' as AI;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/Profiles/cattle_profile.dart' as CP;
import 'package:Kamadhenu/screens/home.dart' as home;

DocumentReference currID;

class ImagePicker extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ImagePicker();
  }
}

class _ImagePicker extends State<ImagePicker> {
  Future<void> _showUploadStatus(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upload Success"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "Profile of your cattle in Buy/Sell Portal has been created"),
              RaisedButton(
                onPressed: () {
                  currID.setData({'OnSale': true}, merge: true);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/portal');
                },
                child: Text("OK"),
              )
            ],
          ),
        );
      },
    );
  }

  var storage = FirebaseStorage.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Image"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Center(
            child: Image.file(AI.imageFile),
          ),
          Padding(padding: EdgeInsets.all(8)),
          RaisedButton(
            onPressed: () async {
              StorageTaskSnapshot snapshot = await storage
                  .ref()
                  .child("images/${AI.animal_id}")
                  .putFile(AI.imageFile)
                  .onComplete;

              if (snapshot.error == null) {
                final String downloadUrl = await snapshot.ref.getDownloadURL();
                await Firestore.instance
                    .collection("cattlesForSale")
                    .document("${currID.documentID}")
                    .setData({
                  "url": downloadUrl,
                  "price": AI.price,
                  "ID": AI.animal_id,
                  "Breed": AI.breed,
                  "SellerID": home.userID,
                });
                setState(() {});
              }
              _showUploadStatus(context);
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
