import 'package:Kamadhenu/Admin/UI/showCattleDetails.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/getcattle.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnRegistered extends StatefulWidget {
  @override
  _UnRegisteredState createState() => _UnRegisteredState();
}

class _UnRegisteredState extends State<UnRegistered> {
  String a = 'NA';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: StreamBuilder<QuerySnapshot>(
          //Error  SOlved HEre!
          stream: Firestore.instance
              .collection('Admin')
              .document(regn)
              .collection('cattles')
              .where('RFID', isEqualTo: a)
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
                  scrollDirection: Axis.vertical,
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
