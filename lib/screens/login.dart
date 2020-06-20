import 'package:flutter/material.dart';
import './create.dart';

class LoginPage extends StatefulWidget {
  
  State<StatefulWidget> createState() => new _LoginPageState(); //Define State
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _mob; //Declaration of variables
  String _password;

  
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
              "      Login",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
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
                      padding: const EdgeInsets.all(13.0), //Padding Attributes
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              new InputDecoration(labelText: "Phone Number"),
                          validator: (String mob) {
                            if (mob.isEmpty) {
                              return 'Number can\'t be Empty';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration:
                              new InputDecoration(labelText: "Password"),
                          validator: (String password) {
                            if (password.isEmpty) {
                              return 'Password can\'t be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          //Container For Login FlatButton To Add Effects under Decoration
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new FlatButton(
                            //Button TO NAvigate to create account Page
                            child: Text(
                              "Create Account.",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Formscreen()), //Route to Create Acc PAge
                              );
                            }),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ]),
    ));
  }
}
