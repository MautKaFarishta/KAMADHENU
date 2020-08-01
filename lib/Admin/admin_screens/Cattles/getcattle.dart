import 'package:Kamadhenu/Admin/UI/showCattleDetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Cat extends StatelessWidget {
  final String catID;
  Cat({this.catID});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cattle Profile'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('cattles')
                .document(catID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var catDoc = snapshot.data;
              DateTime dOB = (catDoc['DOB']).toDate();
              var ldOB = DateFormat.yMMMd().format(dOB);
              DateTime dOC = (catDoc['DOB']).toDate();
              var ldOC = DateFormat.yMMMd().format(dOC);
              return ShowCattleDetails()
                  .DetailedCattleInfo(catDoc, ldOB, ldOC, catID);
            }),
      ),
    );
  }
}
