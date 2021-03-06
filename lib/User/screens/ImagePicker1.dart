import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AnimalInfo.dart' as AI;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/User/Profiles/cattle_profile.dart' as CP;
import 'package:Kamadhenu/User/screens/home.dart' as home;

DocumentReference currID;

class ImagePicker1 extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ImagePicker1();
  }
}

class _ImagePicker1 extends State<ImagePicker1> {
  bool isUploading = false;

  _upload() {
    if (!isUploading) {
      return Text(getTranslated(context, "Submit"));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 1.5,
          )
        ],
      );
    }
  }

  Future<void> _showUploadStatus(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upload Success"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "Profile of your cattle in Buy/Sell Portal has been created"),
              RaisedButton(
                onPressed: () {
                  currID.setData({'OnSale': true}, merge: true);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/portal');
                },
                child: Text(getTranslated(context, "OK")),
              )
            ],
          ),
        );
      },
    );
  }

  var storage = FirebaseStorage.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Image"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Center(
            child: Image.file(AI.imageFile),
          ),
          Padding(padding: EdgeInsets.all(8)),
          RaisedButton(
            onPressed: () async {
              setState(() {
                isUploading = true;
              });
              StorageTaskSnapshot snapshot = await storage
                  .ref()
                  .child("images/${AI.animal_id}")
                  .putFile(AI.imageFile)
                  .onComplete;

              if (snapshot.error == null) {
                final String downloadUrl = await snapshot.ref.getDownloadURL();
                await Firestore.instance
                    .collection("cattlesForSale")
                    .document("${currID.documentID}")
                    .setData({
                  "url": downloadUrl,
                  "price": AI.price,
                  "ID": AI.animal_id,
                  "Breed": AI.breed,
                  "SellerID": home.userID,
                  "RFID": AI.rfid,
                });
              }
              _showUploadStatus(context);
            },
            child: _upload(),
          )
        ],
      ),
    );
  }
}







class VideoPicker extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _VideoPicker();
  }
}

class _VideoPicker extends State<VideoPicker> {
  bool isUploading = false;

  _upload() {
    if (!isUploading) {
      return Text(getTranslated(context, "Submit"));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 1.5,
          )
        ],
      );
    }
  }

  Future<void> _showUploadStatus(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upload Success"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "Profile of your cattle in Buy/Sell Portal has been created"),
              RaisedButton(
                onPressed: () {
                  currID.setData({'OnSale': true}, merge: true);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/portal');
                },
                child: Text(getTranslated(context, "OK")),
              )
            ],
          ),
        );
      },
    );
  }

  var storage = FirebaseStorage.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Video"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Center(
            child:Container(
              color: Colors.grey[500],
              height: MediaQuery.of(context).size.height*0.30,
              width: MediaQuery.of(context).size.width*1.0,
              child: AI.videoFile == null ? Center(
                child: Icon(Icons.videocam,color: Colors.red,size:50.0,),
              ): mounted ? FittedBox(
                fit: BoxFit.contain,
                child:Chewie(
                  controller: ChewieController(
                    videoPlayerController: VideoPlayerController.file(AI.videoFile),
                    aspectRatio: 3/2,
                    autoPlay: true,
                    looping:true,
                  ),
                ),
              ): Container(),

            ),
            //Image.file(AI.videoFile),
          ),
          Padding(padding: EdgeInsets.all(8)),
          RaisedButton(
            onPressed: () async {
              setState(() {
                isUploading = true;
              });
              StorageTaskSnapshot snapshot = await storage
                  .ref()
                  .child("images/${AI.animal_id}")
                  .putFile(AI.videoFile)
                  .onComplete;

              if (snapshot.error == null) {
                final String downloadUrl = await snapshot.ref.getDownloadURL();
                await Firestore.instance
                    .collection("cattlesForSale")
                    .document("${currID.documentID}")
                    .setData({
                  "url": downloadUrl,
                  "price": AI.price,
                  "ID": AI.animal_id,
                  "Breed": AI.breed,
                  "SellerID": home.userID,
                  "RFID": AI.rfid,
                });
              }
              _showUploadStatus(context);
            },
            child: _upload(),
          )
        ],
      ),
    );
  }
}
