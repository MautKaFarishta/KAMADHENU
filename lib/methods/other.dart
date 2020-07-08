import 'package:Kamadhenu/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtherMeth{

  bool flag;

  bool CheckNum(String mob){
    Firestore.instance
        .collection('Users')
        .where('mobile', isEqualTo:mob)
        .getDocuments().then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        var doc=docs.documents[0].data;
        KamdhenuUser(phoneNo:doc['mobile']);
        print('User Found! ${doc['land']}');
        flag =true;
      }
      else{
        print('User Not Found!');
        print(mob);
        flag= false;
      }
    });
    return flag;
  }
  
}