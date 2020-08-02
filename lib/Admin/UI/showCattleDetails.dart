import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/Admin/methods/AddRFID.dart' as B;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Kamadhenu/Admin/methods/addInfo.dart' as A;

class ShowCattleDetails {
  CattleCard(DocumentSnapshot document) {
    return Column(
      children: <Widget>[
        SizedBox(height: 7),
        new Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade200,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1.0, color: Colors.black38),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'ID:${document.documentID}' ?? 'null',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  document['RFID'] ?? 'null',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  document['Species'] ?? 'null',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 15),
              ],
            )),
      ],
    );
  }

  DetailedCattleInfo(var catDoc, var ldOB, var ldOC, var catID) {
    DocumentSnapshot d;

    Widget getList(BuildContext context, DocumentSnapshot document) {
      d = document;
      DateTime dOB = (document['Date']).toDate();
      var ldOB = DateFormat.yMMMd().format(dOB);

      return Container(
        child: ListTile(
          //title: Center(child: Text(document['Detail'],style: TextStyle(fontSize:17),)),
          isThreeLine: true,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Row(
                  children: <Widget>[
                    Text(
                      document['Detail'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ldOB,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text("Other Details : " + document['Note']),
            ],
          ),
        ),
      );
    }

    return Builder(
      builder: (context) => Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              catDoc['RFID'] == 'NA'
                  ? Container(
                      width: double.infinity,
                      decoration: Deco().decoBox(Colors.red.shade200),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text('RFID Registration of cattle is remaining'),
                          Text('Please Enter RFID of Cattle'),
                          SizedBox(height: 5),
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      decoration: Deco().decoBox(Colors.lightBlue.shade900),
                      child: Center(
                        child: Text(
                          'RFID : ${catDoc['RFID']}',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              Container(
                decoration: Deco().decoBox(Colors.lightBlue.shade100),
                child: Column(children: <Widget>[
                  Deco().titleCon('ANIMAL INFORMATION'),
                  SizedBox(height: 10),
                  Text(
                    'Animal Type : ${catDoc['Species']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Animal Breed : ${catDoc['Breed']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Birth : $ldOB',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Animal Gender : ${catDoc['Gender']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 20),
              catDoc['Gender']=='Female'?
              
              Column(
                children: <Widget>[
                  Container(
                    decoration: Deco().decoBox(Colors.lightBlue.shade100),
                    child: Column(children: <Widget>[
                      Deco().titleCon('PREGNANCY DETAILS'),
                      SizedBox(height: 10),
                      Text(
                        'Last Calving Date',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '$ldOC',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Calvings : ${catDoc['Calvings']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10),
                    ]),
                  ),
                  SizedBox(height: 20),
                ],
              ):
              SizedBox(height:1),
              Container(
                decoration: Deco().decoBox(Colors.lightBlue.shade100),
                child: Column(children: <Widget>[
                  Deco().titleCon('VACCINE DETAILS'),
                  StreamBuilder(
                    stream: Firestore.instance
                        .collection('Admin')
                        .document(regn)
                        .collection('vaccine_details')
                        .where('CattleID', isEqualTo: catID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text("Loading...");
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => getList(
                            context,
                            snapshot.data.documents[
                                index]), //pass index of every fetched document
                      );
                    },
                  ),
                ]),
              ),
              SizedBox(height: 20),
              catDoc['Gender']=='Female'?
              Column(
                children: <Widget>[
                  Container(
                    decoration: Deco().decoBox(Colors.lightBlue.shade100),
                    child: Column(children: <Widget>[
                      Deco().titleCon('PREGNANCY HISTORY'),
                      StreamBuilder(
                        stream: Firestore.instance
                            .collection('Admin')
                            .document(regn)
                            .collection('pregnency_details')
                            .where('CattleID', isEqualTo: catID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null)
                            return Text(
                              "No Details are Added.",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) => getList(
                                context,
                                snapshot.data.documents[
                                    index]), //pass index of every fetched document
                          );
                        },
                      ),
                    ]),
                  ),
                  SizedBox(height:1),
                ],
              ):
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FlatButton(
                      child: Container(
                        child: Text(
                          ' Add Info. ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () {
                        A.catID = catID.toString();
                        A.gender = catDoc['Gender'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => A.MoreInfo()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FlatButton(
                      child: Container(
                        child: Text(
                          ' Add RFID ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: catDoc['RFID'] != 'NA'
                          ? null
                          : () {
                              B.catid = catID.toString();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => B.addRFID()),
                              );
                            },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FlatButton(
                      child: Container(
                        child: Text(
                          'Discard',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () {
                        A.catID = catID.toString();

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Are you sure all the details of ',
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                )),
                                              ),
                                              Text(
                                                'Cattle will be discarded',
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                )),
                                              ),
                                              Text(
                                                'Accept only If Details are Wrong or Cattle doesn\'t Exist',
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: Color(0xFF0D47A1),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              onPressed: () {
                                                deleteDetails(catID, context);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: const Color(0xFF0D47A1),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void deleteDetails(String catID, BuildContext context) {
  var db = Firestore.instance;
  var batch = db.batch();

  batch.delete(db
      .collection('Admin')
      .document(regn)
      .collection('cattles')
      .document(catID));
  batch.delete(db.collection('cattles').document(catID));
  batch.commit().whenComplete(() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Cattle Details Deleted',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }));
}
