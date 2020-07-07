import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatPro extends StatelessWidget {
  final String catID;
  CatPro({this.catID});

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cattle Profile')),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('cattles')
              .document(catID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var userDocument = snapshot.data;
            return Column(children: <Widget>[
              Text(userDocument["Species"]),
              Text(userDocument["Breed"]),
            ],);
          }),
    );
  }
}
