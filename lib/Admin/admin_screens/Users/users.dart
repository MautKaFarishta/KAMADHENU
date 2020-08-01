import 'package:Kamadhenu/Admin/UI/showUserDetails.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/Users/details.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/Admin/admin_screens/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: StreamBuilder<QuerySnapshot>(
            //Error  SOlved HEre!
            stream: Firestore.instance
                .collection('Users')
                .where('District', isEqualTo: regn)
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
                                  UserDetails(userID: document.documentID)));
                        },
                        child: ShowUserDetails().UserCard(document),
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
