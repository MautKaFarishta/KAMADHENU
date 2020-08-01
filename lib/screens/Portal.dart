// import 'dart:html';
import 'package:Kamadhenu/Forms/add_animal.dart';
import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/localization/localizationConstant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/UI/AnimalProfile.dart' as AP;

String
    species_name; //Used from Buysell.dart to tell which animal is to be fetched

class Portal extends StatefulWidget {
  State<StatefulWidget> createState() {
    return PortalDisp();
  }
}

final Firestore fb = Firestore.instance;

class PortalDisp extends State<Portal> {
  // Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  //   //Display of Documents
  //   return ListTile(
  //     title: Text(document['Breed']),
  //     isThreeLine: true,
  //     subtitle: Text("Age: " + document['Age'].toString()),
  //   );
  // }

  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "Animals For Sell")),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: getImages(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                    itemCount: snapshot.data.documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GridTile(
                        child: Card(
                            color: Colors.blue[50],
                            borderOnForeground: true,
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.network(
                                      snapshot
                                          .data.documents[index].data["url"],
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  Text(
                                    getTranslated(context, "Price") +
                                        snapshot.data.documents[index]
                                            .data["price"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    snapshot.data.documents[index].data["ID"],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                    textScaleFactor: 1.5,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              onTap: () {
                                AP.userID = snapshot
                                    .data.documents[index].data['SellerID'];
                                AP.imageUrl =
                                    snapshot.data.documents[index].data['url'];
                                AP.cattlesID =
                                    snapshot.data.documents[index].documentID;
                                AP.rfid =
                                    snapshot.data.documents[index].data['RFID'];
                                Navigator.pushNamed(context, '/animalProfile');
                              },
                            )),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text(getTranslated(context, "No data"));
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Future<QuerySnapshot> getImages() {
    return fb.collection("cattlesForSale").getDocuments();
  }
}
