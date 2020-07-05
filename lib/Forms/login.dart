import 'package:Kamadhenu/methods/other.dart';
import 'package:flutter/material.dart';
import './create.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Kamadhenu/authservice.dart';

class LoginPage extends StatefulWidget {
  State<StatefulWidget> createState() =>  _LoginPageState(); //Define State
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;

//authentication
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
  //////////ui code from here////////////////

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
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration:
                              new InputDecoration(labelText: "Phone Number"),
                          validator: (String mob) {
                            if (mob.isEmpty) {
                              return 'Number can\'t be Empty';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              this.phoneNo = val;
                              phoneNo="+91"+ phoneNo.toString();
                            });
                          },
                        ),
                        codeSent
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      InputDecoration(hintText: 'Enter OTP'),
                                  onChanged: (val) {
                                    setState(() {
                                      this.smsCode = val;
                                    });
                                  },
                                ))
                            : Container(),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            
                            child: RaisedButton(
                                child: Center(
                                    child: codeSent
                                        ? Text('Login')
                                        : Text('Verify')),
                                onPressed: () {
                                  if (OtherMeth().CheckNum(phoneNo)==true) {
                                    codeSent
                                      ? AuthService().signInWithOTP(
                                          smsCode, verificationId)
                                      : verifyPhone(phoneNo);
                                  } else {

                                  }
                                  
                                
                                })),
                        SizedBox(height: 20),
                        
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
