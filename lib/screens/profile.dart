import 'package:flutter/material.dart';
import './main_drawer.dart';
import 'package:Kamadhenu/screens/userget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "NameGoesHere";

  String _regn = "RegionGoesHere";

  String _addr = "AdressGoesHere";

  String _mob = "1234567890";

  String _adhr = "1234 5678 4321 8765";

  int _cttls = 20;

  int _rcttls = 5;

  bool flag = false;

  var doc;

  @override
  void initState() {
    super.initState();

    details().getDetails('MHPU29')
        .then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        flag = true;
        doc = docs.documents[0].data;
      }
    });
  }

  Widget rowCell(String count, String type) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(type,
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15)),
          new Text(
            count,
            style: new TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ));

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Profile"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              //This space to be used for Image in future
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 60,
              ),
            ),
            SizedBox(height: 20),
            flag ?
            Column(
              children: <Widget>[
                Text(
                  doc['name'] ?? ' ',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700),
                ),
                Text(
                  doc['Region'],
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 8),
                          Row(
                              children: <Widget>[
                            rowCell(doc['initial cattles'], 'Total Cattles'),
                            rowCell(doc['initial cattles'], 'Remaining Registrations')
                          ]),
                          SizedBox(height: 8),
                          Text(
                            doc['District'],
                            style: TextStyle(fontSize: 17, color: Colors.black38),
                          ),
                          SizedBox(height: 8),
                          Text(
                            doc['adhar'],
                            style: TextStyle(fontSize: 17, color: Colors.black38),
                          ),
                          SizedBox(height: 8),
                          Text(
                            doc['mobile'],
                            style: TextStyle(fontSize: 17, color: Colors.black38),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ) : Text('Loading Please Wait..',
            style: TextStyle(
              fontSize: 14.0
            ),),


            Container(
              //Container For Login FlatButton To Add Effects under Decoration
              //width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
