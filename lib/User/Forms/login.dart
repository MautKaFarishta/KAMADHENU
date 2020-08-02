import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'package:Kamadhenu/User/methods/other.dart';
import 'package:Kamadhenu/main.dart';
import 'package:Kamadhenu/permanent.dart';
import 'package:flutter/material.dart';
import './create.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Kamadhenu/User/methods/authservice.dart';
import 'package:Kamadhenu/main.dart' as MO;

class LoginPageUser extends StatefulWidget {
  State<StatefulWidget> createState() => _LoginPageState(); //Define State
}

class _LoginPageState extends State<LoginPageUser> {
  final _formKey = GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;
  bool codeSent = false;
  static bool f;

//authentication
  Future<void> verifyPhone(phoneNo) async {
    if (OtherMeth().CheckNum(phoneNo) == true) {
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
          timeout: const Duration(seconds: 60),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);
    } else {
      print('User Not Found!--$phoneNo FROM LOGINPAGE');
    }
  }
  //////////ui code from here////////////////
  dem(String value) {
    userType = value;
    print(userType);
  }
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
              getTranslated(context, "app_Title"),
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            Text(
              getTranslated(context, "login"),
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
                          decoration: new InputDecoration(
                            labelText: getTranslated(context, "phone"),
                          ),
                          validator: (String mob) {
                            if (mob.isEmpty) {
                              return getTranslated(
                                  context, "number_validation");
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              this.phoneNo = val;
                              phoneNo = "+91" + phoneNo.toString();
                            });
                          },
                        ),
                        codeSent
                            ? Container(
                                child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    hintText:
                                        getTranslated(context, "enter_otp")),
                                onChanged: (val) {
                                  setState(() {
                                    this.smsCode = val;
                                  });
                                },
                              ))
                            : Container(),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: FlatButton(
                                  child: Center(
                                      child: Text(
                                          getTranslated(context, "login"))),
                                  onPressed: () {
                                    MO.userType = "User";
                                    codeSent
                                        ? AuthService().signInWithOTP(
                                            smsCode, verificationId)
                                        : verifyPhone(phoneNo);
                                  }),
                            )),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 10,
                        ),
                        new FlatButton(
                            //Button TO NAvigate to create account Page
                            child: Text(
                              getTranslated(context, "create_acc"),
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
                        SizedBox(
                          height: 20,
                        ),
                        new FlatButton(
                            //Button TO NAvigate to create account Page
                            child: Text(
                              "Login as Admin",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              String a = 'Admin';
                              addUserType(a);
                              getUserType().then((value) => dem(value));
                             // MO.userType = "Admin";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MO.MyAppAdmin()), //Route to Create Acc PAge
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
