import 'package:Kamadhenu/Admin/UI/showCattleDetails.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/getcattle.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/semantics.dart';

class Registered extends StatefulWidget {
  @override
  _RegisteredState createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  String a = 'NA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: 237,
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: StreamBuilder<QuerySnapshot>(
          //Error  SOlved HEre!
          stream: Firestore.instance
              .collection('Admin')
              .document(regn)
              .collection('cattles')
              .where('isVerified', isEqualTo: true)
              //.where('RFID',isGreaterThan: a)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
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
    );
  }
}
