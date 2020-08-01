import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class nameSearch extends SearchDelegate<DocumentSnapshot> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon:Icon(Icons.clear), onPressed: () {
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder(
      //Error  SOlved HEre!
      stream: Firestore.instance
          .collection('Users').where('name',isLessThanOrEqualTo: query)
          .snapshots(),
      builder:
          (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: new Text('No data'));}

        final results =  snapshot.data.documents.where((element) => element.data['name']
            .toString().toLowerCase().contains(query));
        //print(snapshot.data['name'].toString().toLowerCase());
        return Center(
          child: ListView(
              children: results.map<ListTile>((a) => ListTile(
                title: Text(a.data['name']),
                subtitle: Text(a.data['District'] ?? 'null'),
                onTap: () {
                  close(context, a);
                },
              )).toList()
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return StreamBuilder(
      //Error  SOlved HEre!
      stream: Firestore.instance
          .collection('Users').where('name',isLessThanOrEqualTo: query)
          .snapshots(),
      builder:
          (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return new Text('No data');}

        final results =  snapshot.data.documents.where((element) => element.data['name'].toString().toLowerCase().contains(query));
        //print(snapshot.data['name'].toString().toLowerCase());
        return Center(
          child: ListView(
              children: results.map<ListTile>((a) => ListTile(
                title: Text(a.data['name']),
                subtitle: Text(a.data['District'] ?? 'null'),
                onTap: () {
                  print(a.documentID);
                  close(context, a);
                },
              )).toList()
          ),
        );


      },
    );
  }

}