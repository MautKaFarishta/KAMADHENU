import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Count {
  int a;

  //int b = 0;

  countingNot() {
    int a = 1;
    StreamBuilder(
        stream: Firestore.instance
            .collection('Admin')
            .document('Pune')
            .collection('cattles')
            .snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            a++;

            Text('Getting Info...');
          }
          print(snapshot.data['RFID']);
          if (snapshot.data['RFID'] == null || snapshot.data['RFID'] == 'NA') {
            a++;
            print(a);
          }
          return null;
        });
  }
}

getNo(int a, DocumentSnapshot document) {
  if (document['RFID'] == null || document['RFID'] == 'NA') {
    a = a + 1;
  }
}
