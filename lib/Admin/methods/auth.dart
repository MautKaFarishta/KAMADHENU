import 'package:Kamadhenu/Admin/methods/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Kamadhenu/Admin/methods/key.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user obj on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => user);
        .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
