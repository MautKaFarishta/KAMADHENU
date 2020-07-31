import 'package:Kamadhenu/UI/decorations.dart';
import 'package:Kamadhenu/localization/localizationConstant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:Kamadhenu/screens/home.dart' as home;

String cattlesID;
String imageUrl;
String userID;
String rfid;

class AnimalProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AnimalProfile();
  }
}

class _AnimalProfile extends State<AnimalProfile> {
  final cattleData = Firestore.instance.collection("cattles");
  final userData = Firestore.instance.collection('Users');

  Future<void> _showContactDetails() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.contact_phone,
                  color: Colors.green[200],
                ),
                Text(getTranslated(context, "Seller's Contact")),
              ],
            ),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Text("Mobile: " + userID),
              ],
            )));
      },
    );
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("animal Profile"),
        ),
        body: StreamBuilder(
          stream: getData(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
                child: Column(children: <Widget>[
              Card(
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                margin: EdgeInsets.all(5),
                borderOnForeground: true,
                color: Colors.blue[100],
              ),
              Container(
                decoration: Deco().decoBox(Colors.blue.shade50),
                child: Column(children: <Widget>[
                  Deco().titleCon('ANIMAL INFORMATION'),
                  SizedBox(height: 10),
                  Text(
                    'Animal Type : ${snapshot.data['Species']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Animal Breed : ${snapshot.data['Breed']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Birth : ${DateFormat.yMMMd().format(snapshot.data['DOB'].toDate())}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Gender : ${snapshot.data['Gender']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Region: ${snapshot.data['Region']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ]),
              ),
              RaisedButton(
                onPressed: () {
                  Firestore.instance
                      .collection('Users')
                      .document(userID)
                      .collection('BuyingRequest')
                      .document()
                      .setData({
                    'BuyerID': home.userID,
                    'Name': home.currentUser.name,
                    'AnimalID': cattlesID,
                    'Region': home.currentUser.district,
                    'RFID': rfid,
                    'Starting Date': DateTime.now(),
                    'Ending Date': DateTime.now().add(new Duration(days: 3))
                  }).whenComplete(() {
                    _showContactDetails();
                  });
                },
                child: Text("View Contact Details"),
              )
            ]));
          },
        ));
  }

  Stream<DocumentSnapshot> getData() {
    return Firestore.instance
        .collection('cattles')
        .document(cattlesID)
        .snapshots();
  }
}
