import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/Admin/methods/addInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String catid;

class addRFID extends StatefulWidget {
  @override
  _addRFIDState createState() => _addRFIDState();
}

class _addRFIDState extends State<addRFID> {
  void AddRfid(String rfid) {
    var db = Firestore.instance;
    var batch = db.batch();

    // batch.updateData(db.collection('Users').where('District',isEqualTo: regn).collection('cattles').where(), data)

    batch.updateData(
      db.collection('cattles').document(catid),
      {
        'RFID': rfid,
        'isVerified': true,
      },
    );

    batch.updateData(
      db
          .collection('Admin')
          .document(regn)
          .collection('cattles')
          .document(catid),
      {
        'RFID': rfid,
        'isVerified': true,
      },
    );

    batch.commit().catchError((onError) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Center(child: Text('!!Update Failed !!'))));
    }).whenComplete(() => _showDialog());
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Details Submitted"),
          //content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/home');
              },
            ),
          ],
        );
      },
    );
  }

  String RFID;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _RFID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter RFID'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.blue.shade300,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Deco().titleCon(catid.toString()),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter RFID';
                            }
                            return null;
                          },
                          controller: _RFID,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Builder(
              builder: (context) => FlatButton(
                child: Container(
                  child: Text(
                    ' Submit ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () {
                  RFID = _RFID.text;
                  print(RFID);

                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    AddRfid(RFID);
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
