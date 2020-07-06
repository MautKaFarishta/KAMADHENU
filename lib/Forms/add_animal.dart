import 'package:Kamadhenu/methods/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Kamadhenu/methods/authservice.dart';

enum Species { cow, buffalo, goat, sheep, pig }
enum BreedCow {
  khilar,
  dangi,
  kankrej,
  jarsi,
  hoisten,
  ongole,
  khandhari,
  red_khandhari,
  non_descript
}
enum BreedBuffalo {
  surh,
  murgah,
  pandharpuri,
  nagpuri,
  jaffarbadi,
  non_descript
}
enum Gender { male, female }

class AddAnimal extends StatefulWidget {
  State<StatefulWidget> createState() {
    return AddAnimalForm();
  }
}

class AddAnimalForm extends State<AddAnimal> {
  String _species;
  String _breed;
  Gender _ugender;
  String _cgender;
  String _calvings;
  bool isPregnent = false;
  var _lastcalf = new DateTime.now();
  var _birthdate = new DateTime.now();
  String UID;
  String _regdate;
  bool _c = false;

  final GlobalKey<FormState> _addAnimalkey = GlobalKey<FormState>();

  Widget _buildSpecies() {
    return Container(
      child: Row(
        children: <Widget>[
          const Text(
            "Species    ",
            style: TextStyle(fontSize: 16),
          ),
          DropdownButton(
              value: _species,
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(
                  child: Text("Cow"),
                  value: "Cow",
                ),
                DropdownMenuItem<String>(
                  child: Text("Buffalo"),
                  value: 'Buffalo',
                ),
                DropdownMenuItem<String>(
                  child: Text("Goat"),
                  value: 'Goat',
                ),
                DropdownMenuItem<String>(
                  child: Text("Sheep"),
                  value: "Sheep",
                ),
                DropdownMenuItem<String>(
                  child: Text("Pig"),
                  value: "Pig",
                )
              ],
              onChanged: (value) {
                _species = value;
                //print(_species);
                setState(() {
                  _species = value;
                });
              })
        ],
      ),
    );
  }

  Widget _next(String _species) {
    switch (_species) {
      case "Buffalo":
        print("Buffalo");
        return Container(
          child: Row(
            children: <Widget>[
              Text(
                "Breed   ",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton(
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    child: Text("Surh"),
                    value: "Surh",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Murgah"),
                    value: "Murgah",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Pandharpuri"),
                    value: "Pndharpuri",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Nagpuri"),
                    value: "Nagpuri",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Jaffarbadi"),
                    value: "Jaffarbadi",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Non Descriptant (Gavthi)"),
                    value: "non_descript",
                  ),
                ],
                onChanged: (String value) {
                  _breed = value;
                  setState(() {
                    _breed = value;
                  });
                },
                hint: Text(_breed ?? 'Select'),
              )
            ],
          ),
        );
        break;
      case "Cow":
        print("Cow");
        return Container(
          child: Row(
            children: <Widget>[
              Text(
                "Breed   ",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton(
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    child: Text("Khilar"),
                    value: "khilar",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Dangi"),
                    value: "dangi",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Kankrej"),
                    value: "kankrej",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Jarsi"),
                    value: "Jarsi",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("hoisten"),
                    value: "hoisten",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Ongole"),
                    value: "ongole",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Khandhari"),
                    value: "khandhari",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Red Khandhari"),
                    value: "red_khandhari",
                  ),
                  DropdownMenuItem<String>(
                    child: Text("Non Descriptant (Gavthi)"),
                    value: "non_descript",
                  ),
                ],
                onChanged: (String value) {
                  _breed = value;
                  setState(() {
                    _breed = value;
                  });
                },
                hint: Text(_breed ?? 'Select'),
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

  Widget _buildGender() {
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
                  _cgender = "M";
                });
              }),
          const Text("Male"),
          Radio<Gender>(
              groupValue: _ugender,
              value: Gender.female,
              onChanged: (Gender val) {
                _ugender = Gender.female;
                print(_ugender);
                setState(() {
                  _ugender = val;
                  _cgender = "F";
                });
              }),
          const Text("Female"),
        ],
      ),
    );
  }

  Widget _buildDOB() {
    String _fbirthdate = new DateFormat().add_yMMMd().format(_birthdate);
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
          context: context,
          initialDate: _birthdate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate != null) {
        setState(() {
          _birthdate = _seldate;
        });
      }
    }

    return Row(
      children: <Widget>[
        Text(
          "Birth Date : ",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "$_fbirthdate",
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

  Widget _lastcalfBOB() {
    String _flast = new DateFormat().add_yMMMd().format(_lastcalf);
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
          context: context,
          initialDate: _lastcalf,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return SingleChildScrollView(
              child: child,
            );
          });
      if (_seldate != null) {
        setState(() {
          _lastcalf = _seldate;
        });
      }
    }

    return Row(
      children: <Widget>[
        Text(
          "Last Calving Date : ",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "$_flast",
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

  Widget _calving() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Number of Calvings"),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.length > 3) {
          return "Please Enter Valid Information";
        }
      },
      onSaved: (String value) {
        _calvings = value;
      },
    );
  }

  Widget _checkPre() {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Text("Currently Pregnent  "),
        Switch(
            value: isPregnent,
            onChanged: (s) {
              setState(() {
                isPregnent = s;
              });
            })
      ]),
    );
  }

  Widget _parentdetailsCB() {
    return Row(
      children: <Widget>[
        Checkbox(
            value: _c,
            onChanged: (bool val) {
              print(val);
              _c = val;
              setState(() {
                _c = val;
              });
            }),
        const Text("Parent Details Available ")
      ],
    );
  }

  Widget _parentdetails() {
    switch (_c) {
      case true:
        return Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Sire ID"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Dam ID"),
              keyboardType: TextInputType.number,
            )
          ],
        );
        break;
      default:
        return SizedBox(
          height: 0,
        );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Add Cattle"),
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _addAnimalkey,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'CATTLE INFORMATION',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      _buildGender(),
                      _buildSpecies(),
                      SizedBox(height: 10),
                      _next(_species),
                      SizedBox(height: 10),
                      _buildDOB(),
                      SizedBox(height: 15),
                    ]),
                  ),
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
                            child: Center(
                              child: Text(
                                'PREGNENCY DETAILS',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          _calving(),
                          SizedBox(height: 15),
                          _checkPre(),
                          SizedBox(height: 15),
                          _lastcalfBOB(),
                          SizedBox(height: 10),
                        ],
                      )),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'PARENT\'S DETAILS',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      _parentdetailsCB(),
                      SizedBox(height: 10),
                      _parentdetails(),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                        child: Text("SUBMIT"),
                        onPressed: () {
                          if (!_addAnimalkey.currentState.validate()) {
                            return;
                          }

                          _addAnimalkey.currentState.save();
                          print(_species);
                          print(_breed);
                          print(_breed);
                          print(_ugender);
                          print(_birthdate);
                          print(_lastcalf);
                          print(_regdate);

                          DataBaseService().UpdateCattle(
                              _species,
                              _breed,
                              _cgender,
                              _birthdate,
                              _lastcalf,
                              _calvings,
                              isPregnent);
                        }),
                  ),
                  // _next(),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          )),
    );
  }
}
