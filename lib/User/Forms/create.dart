//import 'dart:html';
import 'dart:ui';

import 'package:Kamadhenu/User/Forms/login.dart';
import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'package:Kamadhenu/User/methods/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserType { individual, organisation }
enum Region { pune, jalgaon, gondia }
enum state { maharashta, andhra }
enum Gender { male, female }
enum Alert { wht, the }

class Formscreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return FormscreenState();
  }
}

class FormscreenState extends State<Formscreen> {
  final firebaseauth = FirebaseAuth.instance;

  String fname;
  String addrs;
  String usern;
  String lname;
  String _password;
  double _value;
  String mob;
  String adhar;
  String land;
  String cattls;
  String stt;
  String dis;
  String regn;
  String UID;
  Gender _ugender = Gender.male;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _regnselect() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(getTranslated(context, "region"),
              style: TextStyle(fontSize: 14)),
          DropdownButton(
            value: dis,
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                child: Text(getTranslated(context, "Pune")),
                value: 'Pune',
              ),
              DropdownMenuItem<String>(
                child: Text(getTranslated(context, "Jalgaon")),
                value: 'Jalgaon',
              ),
              DropdownMenuItem<String>(
                child: Text(getTranslated(context, "Gondia")),
                value: 'Gondia',
              )
            ],
            onChanged: (val2) {
              dis = val2;
              print(val2);
              setState(() {
                dis = val2;
              });
            },
            hint: Text(getTranslated(context, "select")),
          )
        ],
      ),
    );
  }

  Widget _sttselect() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(getTranslated(context, "State"), style: TextStyle(fontSize: 14)),
          DropdownButton(
            value: stt,
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                child: Text(getTranslated(context, "Maha")),
                value: 'Maharashtra',
              ),
              DropdownMenuItem<String>(
                child: Text(getTranslated(context, "ap")),
                value: 'Andhra Pradesh',
              ),
            ],
            onChanged: (val2) {
              stt = val2;
              print(val2);
              setState(() {
                stt = val2;
              });
            },
            hint: Text(getTranslated(context, "select")),
          )
        ],
      ),
    );
  }

  Widget _buildadhar() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: getTranslated(context, "adhar_no")),
      maxLength: 12,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.length != 12) {
          return getTranslated(context, "adhar_validation");
        }
      },
      onSaved: (String value) {
        adhar = value;
      },
    );
  }

  Widget _getland() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: getTranslated(context, "Land Holdigs(In Acres)")),
      maxLength: 2,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.length >= 3) {
          return getTranslated(context, "Kindly enter correct information");
        }
      },
      onSaved: (String value) {
        land = value;
        num.parse(land).toInt(); //to convert to int
      },
    );
  }

  Widget _getcattlesnum() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: getTranslated(context, "How many cattles do you own")),
      maxLength: 3,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.length == 0) {
          return getTranslated(context, "Enter number of cattles");
        }
      },
      onSaved: (String value) {
        cattls = value;
        num.parse(cattls).toInt(); //to convert to int
      },
    );
  }

  Widget _gender() {
    return Container(
      child: Row(
        children: <Widget>[
          Radio<Gender>(
              groupValue: _ugender,
              value: Gender.male,
              onChanged: (Gender val) {
                _ugender = Gender.male;
                print(_ugender);
                setState(() {
                  _ugender = val;
                });
              }),
          Text(getTranslated(context, "Male")),
          Radio<Gender>(
              groupValue: _ugender,
              value: Gender.female,
              onChanged: (value) {
                _ugender = value;
                print(_ugender);
                setState(() {
                  _ugender = value;
                });
              }),
          Text(getTranslated(context, "Female")),
        ],
      ),
    );
  }

  Widget _getaddr() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: getTranslated(context, 'Adress'),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return getTranslated(context, 'Address is required');
          }
        },
        onSaved: (String value) {
          addrs = value;
        });
  }

  Widget _getreg() {
    //Later to be converted to DROPDOWN
    return TextFormField(
        decoration: InputDecoration(
          labelText: getTranslated(context, 'Region Name'),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return getTranslated(context, 'Region is required');
          }
        },
        onSaved: (String value) {
          regn = value;
        });
  }

  Widget _buildfname() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: getTranslated(context, 'First Name'),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return getTranslated(context, 'Name is required');
          }
        },
        onSaved: (String value) {
          fname = value;
        });
  }

  Widget _buildmob() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Mobile Number"),
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: (String value) {
        if (value.length != 10) {
          return getTranslated(context, "Please Enter Valid mobile number");
        }
      },
      onSaved: (String value) {
        mob = '+91' + value;
      },
    );
  }

  Widget _buildlname() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: getTranslated(context, 'Last Name'),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return getTranslated(context, 'Name is required');
          }
        },
        onSaved: (String value) {
          lname = value;
        });
  }

  Widget _buildpass() {
    return Column(
      children: <Widget>[
        TextFormField(
          obscureText: false,
          decoration: InputDecoration(labelText: 'Set Password'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
          onSaved: (String value) {
            _password = value;
            print(value);
          },
        ),
        TextFormField(
          obscureText: false,
          decoration: InputDecoration(labelText: 'Confirm Password'),
          validator: (value2) {
            if (value2 != _password) {
              print("cnf pass" + value2);
              return 'Password does not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  String getUID() {
    return UID = stt.substring(0, 2) +
        dis.substring(0, 2) +
        regn.substring(0, 2) +
        fname.substring(0, 3) +
        lname.substring(0, 3);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "create_acc")),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
              child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              getTranslated(context, 'USER INFORMATION'),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildfname(),
                        _buildlname(),
                        _gender(),
                        _buildadhar(),
                        _buildmob(),
                        _getaddr(),
                        SizedBox(height: 25),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          getTranslated(context, 'OTHER INFORMATION'),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w900),
                        ),
                      ),
                      _sttselect(),
                      _regnselect(),
                      _getreg(),
                      //_usertype(),
                      _getcattlesnum(),
                      _getland(),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
                //Text(
                //  '----SET PASSWORD----',
                //  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                //),
                //_buildpass(),
                RaisedButton(
                  child: Text(
                    getTranslated(context, "Submit"),
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      print("submit pressed");
                    } else {
                      print("invalid things in form");
                    }

                    _formkey.currentState.save();
                    print("\n\n\n");
                    print(fname);
                    print(dis);
                    print(stt);
                    print(lname);
                    print(_ugender);
                    print(adhar);
                    print(mob);
                    print(_password);

                    // database entry
                    DataBaseService().updateUser(fname + ' ' + lname, adhar,
                        mob, cattls, land, dis, stt, regn);

                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            title: Text(getTranslated(
                                context, "Registration Succesful")),
                            content: Text(getTranslated(
                                context, "Please Log in again to continue")),
                            actions: <Widget>[
                              Center(
                                child: RaisedButton(
                                    child: Text(getTranslated(context, "OK")),
                                    color: const Color(0xFF0D47A1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPageUser()), //Route to Create Acc PAge
                                      );
                                    }),
                              )
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          )),
        ));
  }
}
