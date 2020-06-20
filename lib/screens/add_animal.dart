import 'package:flutter/material.dart';

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
  @override
  State<StatefulWidget> createState() {
    return AddAnimalForm();
  }
}

class AddAnimalForm extends State<AddAnimal> {
  @override
  Species _species;
  String _breedCow = "Select Breed";
  String _breedBuffalo = "Select Breed";
  Gender _ugender;
  String _date;
  String _regdate;
  bool _c = false;

  final GlobalKey<FormState> _addAnimalkey = GlobalKey<FormState>();

  Widget _buildSpecies() {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          const Text(
            "Species    ",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 10),
          DropdownButton(
              items: const <DropdownMenuItem<Species>>[
                DropdownMenuItem<Species>(
                  child: Text("Cow"),
                  value: Species.cow,
                ),
                DropdownMenuItem<Species>(
                  child: Text("Buffalo"),
                  value: Species.buffalo,
                ),
                DropdownMenuItem<Species>(
                  child: Text("Goat"),
                  value: Species.goat,
                ),
                DropdownMenuItem<Species>(
                  child: Text("Sheep"),
                  value: Species.sheep,
                ),
                DropdownMenuItem<Species>(
                  child: Text("Pig"),
                  value: Species.pig,
                )
              ],
              onChanged: (Species value) {
                _species = value;
                print(_species);
                setState(() {
                  _species = value;
                });
              })
        ],
      ),
    );
  }

  Widget _next(Species _sp) {
    switch (_sp) {
      case Species.buffalo:
        print("Buffalo");
        return Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
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
                  _breedBuffalo = value;
                  setState(() {
                    _breedBuffalo = value;
                  });
                },
                hint: Text(_breedBuffalo),
              )
            ],
          ),
        );
        break;
      case Species.cow:
        print("Cow");
        return Container(
          child: Row(
            children: <Widget>[
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
                  _breedCow = value;
                  setState(() {
                    _breedCow = value;
                  });
                },
                hint: Text(_breedCow),
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
                });
              }),
          const Text("Female"),
        ],
      ),
    );
  }

  Widget _buildDOB() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Date of Birth ", hintText: "DD/MM/YYYY"),
      keyboardType: TextInputType.datetime,
      validator: (String value) {
        if (value.isEmpty) {
          return "This is required field";
        }
      },
      onSaved: (String value) {
        _date = value;
      },
    );
  }

  Widget _buildRegDate() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Date of Registration ", hintText: "DD/MM/YYYY"),
      keyboardType: TextInputType.datetime,
      validator: (String value) {
        if (value.isEmpty) {
          return "Please enter this field";
        }
      },
      onSaved: (String value) {
        _regdate = value;
      },
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
        title: Text("Add Cattle"),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Form(
          key: _addAnimalkey,
          child: Column(
            children: <Widget>[
              _buildSpecies(),
              _next(_species),
              _buildGender(),
              _buildDOB(),
              _buildRegDate(),
              _parentdetailsCB(),
              _parentdetails(),
              SizedBox(
                height: 100,
              ),
              RaisedButton(
                  child: Text("SUBMIT"),
                  onPressed: () {
                    if (!_addAnimalkey.currentState.validate()) {
                      return;
                    }

                    _addAnimalkey.currentState.save();
                    print(_species);
                    print(_breedCow);
                    print(_breedBuffalo);
                    print(_ugender);
                    print(_date);
                    print(_regdate);
                  })
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
