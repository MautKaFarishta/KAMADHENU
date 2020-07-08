// import 'dart:html';
import 'package:Kamadhenu/Forms.dart/add_animal.dart';
import 'package:Kamadhenu/Forms.dart/create.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String
    species_name; //Used from Buysell.dart to tell which animal is to be fetched

class Portal extends StatefulWidget {
  State<StatefulWidget> createState() {
    return PortalDisp();
  }
}

class PortalDisp extends State<Portal> {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    //Display of Documents
    return ListTile(
      title: Text(document['Breed']),
      isThreeLine: true,
      subtitle: Text("Age: " + document['Age'].toString()),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Portal"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance //Stream will fetch the documents
              .collection('cattles_Demo')
              .where('Species', isEqualTo: species_name)
              .snapshots(),
          builder: (context, snapshot) {
            //whenever there is an update in database, Snapshot will change here
            if (!snapshot.hasData) return const Text("Loading...");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => _buildListItem(
                  context,
                  snapshot.data
                      .documents[index]), //pass index of every fetched document
            );
          },
        ));
  }
}
