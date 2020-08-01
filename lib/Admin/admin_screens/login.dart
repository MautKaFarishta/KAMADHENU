import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/methods/auth.dart';
import 'package:Kamadhenu/Admin/methods/getregn.dart';
import 'package:Kamadhenu/Admin/methods/key.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Kamadhenu/main.dart';

enum Region { Pune, Jalgaon, Gondia }
//Declaration of variables
String _skey;
String day;
Region theDay;
bool val;
String a;
//String regn;

class LoginPage extends StatefulWidget {
  State<StatefulWidget> createState() => new _LoginPageState(); //Define State
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool flag;
  void initState() {
    flag = false;
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  String regn1;

  Widget _regnselect() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Region  ", style: TextStyle(fontSize: 14)),
          DropdownButton(
            value: regn1,
            hint: Text('Select Region'),
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                child: Text("Pune"),
                value: 'Pune',
              ),
              DropdownMenuItem<String>(
                child: Text("Jalgaon"),
                value: 'Jalgaon',
              ),
              DropdownMenuItem<String>(
                child: Text("Gondia"),
                value: 'Gondia',
              ),
              DropdownMenuItem<String>(
                child: Text("Nashik"),
                value: 'Nashik',
              )
            ],
            onChanged: (String value) {
              regn1 = value;

              // day = theDay.toString().split('.').last;

              setState(() {
                regn1 = value;
                // regn = regn1;
              });
            },
          )
        ],
      ),
    );
  }
  //Future ano(bool val) async{

  //}
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            //Main UNIVERSAL CONTAINER For this page
            width: double.infinity, //Making it Streched
            decoration: BoxDecoration(
              //Decoration for UNIVERSAL CONTAINER
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Colors.blue[900], Colors.blueAccent[200]]),
            ),
            child: Column(
                //Container Starts With Column
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment:
                    CrossAxisAlignment.start, //Text To Appear at LEFT SIDE
                children: <Widget>[
                  //MAin Body Wrapped Under Widget
                  SizedBox(height: 80), //Add Spacing
                  Text(
                    "   Kamadhenu",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "      Admin Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Container(
                            //Main Text Bodies Under This Container
                            decoration: BoxDecoration(
                              //Decoration For Container
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)),
                            ),
                            child: Padding(
                              //Padding Widget to SHRINK TEXT FIELDS
                              padding: const EdgeInsets.all(
                                  13.0), //Padding Attributes
                              child: Column(children: <Widget>[
                                SizedBox(height: 20),
                                _regnselect(),
                                TextFormField(
                                  obscureText: true,
                                  decoration: new InputDecoration(
                                      labelText: "Security Key"),
                                  validator: (String password) {
                                    if (password.isEmpty) {
                                      return 'Key can not be empty!';
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    _skey = value;
                                    //print(value);
                                    // print(_skey+'fghdfh');
                                  },
                                ),
                                //Text(_skey),
                                SizedBox(height: 20),
                                Container(
                                  //Container For Login FlatButton To Add Effects under Decoration
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Builder(
                                    builder: (context) => FlatButton(
                                      onPressed: flag
                                          ? null
                                          : () async {
                                              setState(() {
                                                flag = true;
                                              });
                                              if (_formKey.currentState
                                                  .validate()) {
                                                val = await checkkey()
                                                    .check(regn1, _skey);

                                                if (val == true) {
                                                  dynamic result =
                                                      await _auth.signInAnon();
                                                  if (result == null) {
                                                    setState(() {
                                                      flag = false;
                                                    });
                                                    print('error signin in');
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Something Went Wrong! Try Again...'),
                                                    ));
                                                  } else {
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Please wait While Login in...'),
                                                    ));
                                                    print('signin');
                                                    print(result.uid);
                                                  }
                                                } else {
                                                  setState(() {
                                                    flag = false;
                                                  });
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Something Went Wrong! Try Again...'),
                                                  ));
                                                  setState(() {
                                                    flag = false;
                                                  });

                                                  // print(_skey);
                                                  print('error');
                                                }
                                              } else {
                                                setState(() {
                                                  flag = false;
                                                });
                                              }
                                            },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Text('$_skey'),
                ])));
  }
}

//put under region text
/*DropdownButton(
            value: _regn,
            hint:Text('Select Region'),
            items: const <DropdownMenuItem<Region>>[
              DropdownMenuItem<Region>(
                child: Text("Pune"),
              ),
              DropdownMenuItem<Region>(
                child: Text("Jalgaon"),
                value: Region.jalgaon,
              ),
              DropdownMenuItem<Region>(
                child: Text("Gondia"),
                value: Region.gondia,
              )
            ],
            onChanged: (Region value) {
              _regn = value;
              Text('$_regn');
              print(_regn);
              setState(() {
                _regn = value;
              });
            },
          )*/
