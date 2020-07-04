import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/screens/profile.dart';

class details {
  getDetails(String userId) {
    return Firestore.instance
        .collection('Users')
        .where('uid', isEqualTo:userId)
        .getDocuments();
  }
}