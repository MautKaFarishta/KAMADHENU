//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserType { individual,organisation }
enum Region { pune , jalgaon , gondia}
enum state {maharashta ,andhra}
enum Gender { male, female }
enum Alert { wht, the }

class Formscreen extends StatefulWidget {
  
  State<StatefulWidget> createState() {
    return FormscreenState();
  }
}

class FormscreenState extends State<Formscreen> {

  final _firestore = Firestore.instance;
  final firebaseauth = FirebaseAuth.instance;
    
  String _fname;
  String _address;
  String _usern;
  String _lname;
  String _password;
  double _value;
  String _mob;
  String _adhar;
  String _land;
  String _cattls;
  state _stt;
  Region _regn;
  UserType _user = UserType.individual;
  Gender _ugender = Gender.male;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _usertype() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("User Type  ", style: TextStyle(fontSize: 14)),
          DropdownButton(
            value: _user,
            items: const <DropdownMenuItem<UserType>>[
              DropdownMenuItem<UserType>(
                child: Text("Individual"),
                value: UserType.individual,
              ),
              DropdownMenuItem<UserType>(
                child: Text("Organisation"),
                value: UserType.organisation,
              )
            ],
            onChanged: (UserType val) {
              _user = val;
              print(val);
              setState(() {
                _user = val;
              });
            },
            hint: Text("Select"),
          )
        ],
      ),
    );
  }

  Widget _regnselect() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Region  ", style: TextStyle(fontSize: 14)),
          DropdownButton(
            value: _regn,
            items: const <DropdownMenuItem<Region>>[
              DropdownMenuItem<Region>(
                child: Text("Pune"),
                value: Region.pune,
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
            onChanged: (Region val2) {
              _regn = val2;
              print(val2);
              setState(() {
                _regn = val2;
              });
            },
            hint: Text("Select"),
          )
        ],
      ),
    );
  }

  Widget _sttselect() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("State  ", style: TextStyle(fontSize: 14)),
          DropdownButton(
            value: _stt,
            items: const <DropdownMenuItem<state>>[
              DropdownMenuItem<state>(
                child: Text("Maharashtra"),
                value: state.maharashta,
              ),
              DropdownMenuItem<state>(
                child: Text("Andhra Pradesh"),
                value: state.andhra,
              ),
            ],
            onChanged: ( val2) {
              _stt = val2;
              print(val2);
              setState(() {
                _stt = val2;
              });
            },
            hint: Text("Select"),
          )
        ],
      ),
    );
  }

  Widget _buildadhar() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aadhar number"),
      maxLength: 16,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.length != 16) {
          return "please enter valid aadhar number";
        }
      },
      onSaved: (String value) {
        _adhar = value;
      },
    );
  }

  Widget _getland() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Land Holdigs(In Acres)"),
      maxLength: 2,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.length >= 3) {
          return "Kindly enter correct information";
        }
      },
      onSaved: (String value) {
        _land = value;
        num.parse(_land).toInt();//to convert to int
      },
    );
  }

  Widget _getcattlesnum() {
    return TextFormField(
      decoration: InputDecoration(labelText: "How many cattles do you own"),
      maxLength: 3,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.length == 0) {
          return "Enter number of cattles";
        }
      },
      onSaved: (String value) {
        _cattls = value;
        num.parse(_cattls).toInt();//to convert to int
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
          const Text("Male"),
          Radio<Gender>(
              groupValue: _ugender,
              value: Gender.female,
              onChanged: ( value) {
                _ugender = value;
                print(_ugender);
                setState(() {
                  _ugender = value;
                });
              }),
          const Text("Female"),
        ],
      ),
    );
  }

  Widget _getaddr() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Adress',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }
        },
        onSaved: (String value) {
          _address = value;
        });
  }

  Widget _buildfname() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'First Name',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }
        },
        onSaved: (String value) {
          _fname = value;
        });
  }

  Widget _buildmob() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Mobile Number"),
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: (String value) {
        if (value.length != 10) {
          return "Please Enter Valid mobile number";
        }
      },
      onSaved: (String value) {
        _mob = value;
      },
    );
  }

  Widget _buildlname() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Last Name',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }
        },
        onSaved: (String value) {
          _lname = value;
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
            }return null;
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
              print ("cnf pass"+value2);
              return 'Password does not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Account"),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: SingleChildScrollView(
              child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '----USER INFORMATION----',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 10),
                _buildfname(),
                _buildlname(),
                _gender(),
                _buildadhar(),
                _buildmob(),
                _getaddr(),
                SizedBox(height: 25),
                Text(
                  '----OTHER INFORMATION----',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                ),
                _sttselect(),
                _regnselect(),
                //_usertype(),
                _getcattlesnum(),
                _getland(),
                SizedBox(height: 25),
                Text(
                  '----SET PASSWORD----',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                ),
                _buildpass(),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      print("submit pressed") ;
                    }
                    else{
                      print("invalid things in form") ;
                    }

                    _formkey.currentState.save();
                    print("\n\n\n");
                    print(_fname);
                    print(_regn);
                    print(_stt);
                    print(_lname);
                    print(_user);
                    print(_ugender);
                    print(_adhar);
                    print(_mob);
                    print(_password);

                    // database entry
                    print('updation');
                    _firestore.collection('$_stt/$_regn/Users').add({'adhar':_adhar,


                    'first name':_fname,

                    //'gender':_ugender,

                    'initial cattles':_cattls,

                    'land':_land,

                    'last name':_lname,

                    'mobile':_mob,

                    //'region':_regn,

                    //'user type':_user
                    });

                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Registration Succesful"),
                            content: Text("Please Log in again to continue"),
                            actions: <Widget>[
                              Center(
                                child: RaisedButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
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
