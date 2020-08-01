import 'package:Kamadhenu/Admin/UI/showCattleDetails.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/getcattle.dart';
import 'package:Kamadhenu/Admin/admin_screens/main_drawer.dart';
//import 'package:Kamadhenu_admin/methods/usercat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login.dart';
import 'dart:async';

import 'package:Kamadhenu/main.dart';

class UserCatDetails extends StatelessWidget {
  final String cat;

  const UserCatDetails({Key key, this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cattles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            //Error  SOlved HEre!
            stream: Firestore.instance
                .collection('Users')
                .document(cat)
                .collection('cattles')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return FlatButton(
                        onPressed: () {
                          print("${document['Species']} Button Pressed");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Cat(catID: document.documentID)));
                        },
                        child: ShowCattleDetails().CattleCard(document),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
