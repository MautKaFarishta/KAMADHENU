import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//String catID;

class Broadcast extends StatefulWidget {
  @override
  _BroadcastState createState() => _BroadcastState();
}

class _BroadcastState extends State<Broadcast> {
  String detailType;
  String specificDetail;
  var detailDate = new DateTime.now();
  var detailDate1 = new DateTime.now();
  String note;

  updateEvent(String document, String detailType, String specificDetail,
      var detailDate, var detailDate1) {
    Firestore.instance
        .collection('Admin')
        .document(document)
        .collection('Broadcast')
        .document()
        .setData({
      'Title': detailType,
      'Content': specificDetail,
      'Starting Date': detailDate,
      'Ending Date': detailDate1,
    });
  }

  Widget getDate1() {
    String dDate = new DateFormat().add_yMMMd().format(detailDate1);
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
          context: context,
          initialDate: detailDate1,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate != null) {
        setState(() {
          detailDate1 = _seldate;
        });
      }
    }

    return Row(
      children: <Widget>[
        Text(
          "Ending Date : ",
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

  Widget getDate() {
    String eDate = new DateFormat().add_yMMMd().format(detailDate);
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime _seldate2 = await showDatePicker(
          context: context,
          initialDate: detailDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate2 != null) {
        setState(() {
          detailDate = _seldate2;
        });
      }
    }

    return Row(
      children: <Widget>[
        Text(
          "Starting Date : ",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "$eDate",
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
                  detailDate1,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: Deco().decoBox(Colors.red.shade200),
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),
                Text('Enter Following Fields to be Broadcast'),
                //Text('Please Contact AHD office near you'),
                SizedBox(height: 5),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Deco().titleCon('Broadcast'),
          Container(
              padding: EdgeInsets.all(10.0),
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
                  // Text(catID),
                  //getDetailType(),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tittle',
                    ),
                    onChanged: (value) {
                      detailType = value;
                    },
                  ),
                  SizedBox(height: 10),
                  //specifiedDetail(detailType),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content '),
                    onChanged: (value) {
                      specificDetail = value;
                    },
                  ),
                  SizedBox(height: 10),
                  getDate(),
                  SizedBox(height: 10),
                  getDate1(),
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
