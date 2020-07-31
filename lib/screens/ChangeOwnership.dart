import 'package:Kamadhenu/Forms/addInfo.dart';
import 'package:Kamadhenu/Forms/add_animal.dart';
import 'package:Kamadhenu/UI/AnimalProfile.dart';
import 'package:Kamadhenu/localization/localizationConstant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/Profiles/cattle_profile.dart' as CatP;
import 'package:Kamadhenu/screens/home.dart' as home;

class ChangeOwnership extends StatefulWidget {
  State<StatefulWidget> createState() {
    return ChangeOwner();
  }
}

String cattleID;
final Firestore fb = Firestore.instance;
final _formkey = GlobalKey<FormState>();

class ChangeOwner extends State<ChangeOwnership> {
  String newOwner;
  bool _isLoading = false;
  String newOwnerDist;

  _showComplete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(getTranslated(context, "Ownership has been changed")),
              RaisedButton(
                color: const Color(0xFF0D47A1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(getTranslated(context, "OK")),
              )
            ],
          ),
        );
      },
    );
  }

  copyCollection(String fromD, String toD, String fromC, String toC) async {
    Future<DocumentSnapshot> doc = fb.collection(fromC).document(fromD).get();
    doc.then((snapshot) {
      snapshot.data.forEach((key, value) {
        fb.collection(toC).document(toD).setData({
          key: value,
        }, merge: true);
      });
    }).whenComplete(() {
      fb.collection(fromC).document(fromD).delete();
      _showComplete(context);
    });
  }

  Future<void> _showNull(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(getTranslated(context, "Error")),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(getTranslated(context,
                  "This User does not exist, please enter correct registered mobile number of Buyer")),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: const Color(0xFF0D47A1),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(getTranslated(context, "OK"),
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _showConfirmDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(getTranslated(context, "Confirmation")),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(getTranslated(context,
                  "Are you sure that you want to change ownership of this cattle?")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  RaisedButton(
                    color: const Color(0xFF0D47A1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      getTranslated(context, "NO"),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  RaisedButton(
                    onPressed: () {
                      fb
                          .collection('cattles')
                          .document(cattleID)
                          .updateData({'OwnerID': newOwner});
                      copyCollection(
                          cattleID,
                          cattleID,
                          "Users/${home.currentUser.phoneNo}/cattles",
                          'Users/$newOwner/cattles');
                      if (home.currentUser.district != newOwnerDist) {
                        copyCollection(
                            cattleID,
                            cattleID,
                            "Admin/${home.currentUser.district}/cattles",
                            "Admin/$newOwnerDist/cattles");
                      }
                      // copyCollection(cattleID, cattleID, "Admin/${home.currentUser.district}/cattles", "Admin/$")
                    },
                    child: Text(getTranslated(context, "YES")),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "Change Ownership")),
        ),
        body: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                icon: Icon(Icons.phone_android),
                labelText: getTranslated(
                    context, "Registered Mobile number of new Owner"),
              ),
              maxLength: 10,
              key: _formkey,
              validator: (value) {
                if (value.length < 10)
                  return getTranslated(
                      context, 'Please Enter Valid mobile number');
              },
              onChanged: (value) {
                newOwner = ("+91" + value);
              },
            ),
            RaisedButton(
              onPressed: () async {
                Firestore.instance
                    .collection('Users')
                    .where('mobile', isEqualTo: newOwner)
                    .getDocuments()
                    .then((QuerySnapshot docs) {
                  if (docs.documents.isNotEmpty) {
                    docs.documents.forEach((element) {
                      newOwnerDist = element.data['District'];
                    });
                    print('User Found! $newOwner');
                    print("user disrt $newOwnerDist");
                    _showConfirmDialogue(context);
                  } else {
                    print('User Not Found! $newOwner');
                    _showNull(context);
                  }
                });
              },
              child: Text(getTranslated(context, "Submit")),
            )
          ],
        ));
  }
}
