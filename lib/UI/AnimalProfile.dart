import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String cattlesID;
String imageUrl;
String userID;

class AnimalProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AnimalProfile();
  }
}

class _AnimalProfile extends State<AnimalProfile> {
  final cattleData = Firestore.instance.collection("cattles");
  final userData = Firestore.instance.collection('Users');

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
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Species: ",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Species'],
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Breed: ",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Breed'],
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Gender: ",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Gender'],
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Region: ",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Region'],
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Seller's Contact: ",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userID,
                      textScaleFactor: 1.3,
                    ),
                  ],
                ),
              ),
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
