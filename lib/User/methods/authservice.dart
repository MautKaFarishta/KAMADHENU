import 'package:Kamadhenu/User/methods/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/User/screens/home.dart';
import 'package:Kamadhenu/User/Forms/login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPageUser();
          }
        });
  }

  //Get UID
  Future<String> getCurrentUID() async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.phoneNumber;
    return uid;
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);

    signIn(authCreds);
  }
}
