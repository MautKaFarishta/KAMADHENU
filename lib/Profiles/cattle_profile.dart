import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatPro extends StatelessWidget {

  final String catID;
  CatPro({this.catID});

  readData(){

    final cat =Firestore.instance.collection('cattles').document('catID');

    cat.get().then((datasnapshot){
      print(datasnapshot.data["Species"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text('Cattle Profile')
      ),
      body: Center(
        child:Column(
          children: <Widget>[
            Text(catID),
            //readData(),
          ],
        ),
      ),
    );
  }
}