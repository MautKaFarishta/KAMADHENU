import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/getcattle.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:Kamadhenu/methods/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String catID;
String gender;

class MoreInfo extends StatefulWidget {
  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  String detailType;
  String specificDetail;
  var detailDate = new DateTime.now();
  String note;

  Widget getDetailType() {
    return Container(
      child: Row(
        children: <Widget>[
          const Text(
            "Details     ",
            style: TextStyle(fontSize: 16),
          ),
          gender == 'Female'
              ? DropdownButton(
                  value: detailType,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      child: Text("Pregnancy Detail"),
                      value: "pregnency_details",
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Vaccine Details"),
                      value: 'vaccine_details',
                    ),
                  ],
                  onChanged: (value) {
                    detailType = value;
                    //print(_species);
                    setState(() {
                      detailType = value;
                    });
                  })
              : DropdownButton(
                  value: detailType,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      child: Text("Vaccine Details"),
                      value: 'vaccine_details',
                    ),
                  ],
                  onChanged: (value) {
                    detailType = value;
                    //print(_species);
                    setState(() {
                      detailType = value;
                    });
                  }),
        ],
      ),
    );
  }

  updateEvent(String document, String detailType, String specificDetail,
      var detailDate, String note, String catID) {
    String totalCount;

    Firestore.instance
        .collection('Admin')
        .document(document)
        .collection(detailType)
        .document()
        .setData({
      'DetailType': detailType,
      'Detail': specificDetail,
      'Date': detailDate,
      'Note': note,
      'CattleID': catID,
    });
    if (detailType == 'vaccine_details') {
      totalCount = 'TotalVaccines';
    } else {
      if (specificDetail == 'newBorn') {
        totalCount = 'PregnencyCount';
      } else if (specificDetail == 'AI' || specificDetail == 'PD') {
        totalCount = 'PregnencyDiagnosis';
      }
    }

    Firestore.instance.collection('Admin').document(regn).updateData({
      totalCount: FieldValue.increment(1),
      specificDetail: FieldValue.increment(1),
    });
  }

  Widget specifiedDetail(String detailType) {
    switch (detailType) {
      case "pregnency_details":
        return Container(
          child: Row(
            children: <Widget>[
              Text(
                "Specify Detail   ",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton(
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    child: Text("Performed AI"),
                    value: "AI",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Newborn"),
                    value: "newBorn",
                  ),
                ],
                onChanged: (String value) {
                  specificDetail = value;
                  setState(() {
                    specificDetail = value;
                  });
                },
                hint: Text(specificDetail ?? 'Select'),
              )
            ],
          ),
        );
        break;
      case 'vaccine_details':
        return Container(
          child: Row(
            children: <Widget>[
              Text(
                "Specify Detail   ",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton(
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    child: Text("FMD"),
                    value: "FMD",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("HS"),
                    value: "HS",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("BQ"),
                    value: "BQ",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Theileriosis"),
                    value: "Theileriosis",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Anthrax"),
                    value: "Anthrax",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("IBR"),
                    value: "IBR",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Rabies"),
                    value: "Rabies",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("HS+BQ"),
                    value: "HS+BQ",
                  ),
                ],
                onChanged: (String value) {
                  specificDetail = value;
                  setState(() {
                    specificDetail = value;
                  });
                },
                hint: Text(specificDetail ?? 'Select'),
              )
            ],
          ),
        );
        break;
      default:
        print("Default");
        return SizedBox(
          height: 0,
        );
    }
  }

  Widget getDate() {
    String dDate = new DateFormat().add_yMMMd().format(detailDate);
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
          context: context,
          initialDate: detailDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate != null) {
        setState(() {
          detailDate = _seldate;
        });
      }
    }

    return Row(
      children: <Widget>[
        Text(
          "Date : ",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "$dDate",
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ],
    );
  }

  Widget moreDetails() {
    return TextField(
        decoration: InputDecoration(
          labelText: 'More Details',
        ),
        onChanged: (String value) {
          note = value;
        });
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
                updateEvent(
                  regn,
                  detailType,
                  specificDetail,
                  detailDate,
                  note,
                  catID,
                );
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cat(catID: catID)),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Details'),
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
                  Deco().titleCon(catID.toString()),
                  SizedBox(height: 10),
                  getDetailType(),
                  SizedBox(height: 10),
                  specifiedDetail(detailType),
                  SizedBox(height: 10),
                  getDate(),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: moreDetails()),
                  SizedBox(height: 20),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: FlatButton(
              child: Container(
                child: Text(
                  ' Submit ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              onPressed: () {
                _showDialog();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
