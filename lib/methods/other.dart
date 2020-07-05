import 'package:Kamadhenu/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtherMeth{

  static bool flag=false;

  KamdhenuUser user = KamdhenuUser();

  bool CheckNum(String mob){
    
    Firestore.instance
        .collection('Users')
        .where('mobile', isEqualTo:mob)
        .getDocuments().then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        print('User Found! $mob');
        var doc=docs.documents[0].data;
        user.phoneNo  = doc['mobile'];
        user.PrintVal();
        //print('User Found! ${doc['land']}');
        flag =true;
      }
      else{
        print('User Not Found! $mob');
        flag= false;
      }
    });
    print(flag);
    return flag;
  }
  
}