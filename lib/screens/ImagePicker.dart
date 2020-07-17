import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AnimalInfo.dart' as AI;
import 'package:cloud_firestore/cloud_firestore.dart';

class ImagePicker extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ImagePicker();
  }
}

class _ImagePicker extends State<ImagePicker> {
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
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/portal');
                },
                child: Text("OK"),
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
      // body: Column(
      //   children: <Widget>[
      //     GridView.builder(
      //         shrinkWrap: true,
      //         padding: const EdgeInsets.all(0),
      //         itemCount: listOfImage.length,
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 3,
      //           mainAxisSpacing: 2,
      //           crossAxisSpacing: 2,
      //         ),
      //         itemBuilder: (BuildContext, int index) {
      //           return GridTile(
      //             child: Material(
      //               child: GestureDetector(
      //                 child: Stack(
      //                   children: <Widget>[
      //                     this.images == listOfImage[index].assetName ||
      //                             listOfStr
      //                                 .contains(listOfImage[index].assetName)
      //                         ? Positioned.fill(
      //                             child: Opacity(
      //                             opacity: 0.7,
      //                             child: Image.asset(
      //                               listOfImage[index].assetName,
      //                               fit: BoxFit.fill,
      //                             ),
      //                           ))
      //                         : Positioned.fill(
      //                             child: Opacity(
      //                             opacity: 1.0,
      //                             child: Image.asset(
      //                               listOfImage[index].assetName,
      //                               fit: BoxFit.fill,
      //                             ),
      //                           )),
      //                     this.images == listOfImage[index].assetName ||
      //                             listOfStr
      //                                 .contains(listOfImage[index].assetName)
      //                         ? Positioned(
      //                             left: 0,
      //                             bottom: 0,
      //                             child: Icon(
      //                               Icons.check_circle,
      //                               color: Colors.green,
      //                             ))
      //                         : Visibility(
      //                             visible: false,
      //                             child: Icon(
      //                               Icons.check_circle_outline,
      //                               color: Colors.black,
      //                             ),
      //                           )
      //                   ],
      //                 ),
      //                 onTap: () => {
      //                   setState(() {
      //                     if (listOfStr
      //                         .contains(listOfImage[index].assetName)) {
      //                       this.clicked = false;
      //                       listOfStr.remove(listOfImage[index].assetName);
      //                       this.images = null;
      //                     } else {
      //                       this.images = listOfImage[index].assetName;
      //                       listOfStr.add(this.images);
      //                       this.clicked = true;
      //                     }
      //                   })
      //                 },
      //               ),
      //             ),
      //           );
      //         }),
      //     Builder(builder: (context) {
      //       return RaisedButton(
      //         child: Text("Upload Images"),
      //         onPressed: () => {
      //           setState(() {
      //             this.isLoading = true;
      //           }),
      //           listOfStr.forEach((img) async {
      //             String imageName = img
      //                 .substring(img.lastIndexOf('/'), img.lastIndexOf("."))
      //                 .replaceAll('/', '');

      //             final Directory systemTempDir = Directory.systemTemp;
      //             final byteData = await rootBundle.load(img);

      //             final file = File('${systemTempDir.path}/$imageName.jpeg');
      //             await file.writeAsBytes(byteData.buffer.asUint8List(
      //                 byteData.offsetInBytes, byteData.lengthInBytes));
      //             StorageTaskSnapshot snapshot = await storage
      //                 .ref()
      //                 .child("images/$imageName")
      //                 .putFile(AI.imageFile)
      //                 .onComplete;
      //             if (snapshot.error == null) {
      //               final String downloadUrl =
      //                   await snapshot.ref.getDownloadURL();
      //               await Firestore.instance
      //                   .collection("cattlesForSale")
      //                   .document()
      //                   .setData({
      //                 "url": downloadUrl,
      //                 "name": imageName,
      //                 "price": AI.price,
      //                 "ID": AI.animal_id,
      //                 "Breed": AI.breed,
      //               });

      //               setState(() {
      //                 isLoading = false;
      //               });
      //               final snackBar = SnackBar(content: Text("yay!! success"));
      //               Scaffold.of(context).showSnackBar(snackBar);
      //             } else {
      //               print("error from image repo");
      //               throw ('file is not an image');
      //             }
      //           })
      //         },
      //       );
      //     })
      //   ],
      // ),
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
              StorageTaskSnapshot snapshot = await storage
                  .ref()
                  .child("images/${AI.animal_id}")
                  .putFile(AI.imageFile)
                  .onComplete;

              if (snapshot.error == null) {
                final String downloadUrl = await snapshot.ref.getDownloadURL();
                await Firestore.instance
                    .collection("cattlesForSale")
                    .document()
                    .setData({
                  "url": downloadUrl,
                  "price": AI.price,
                  "ID": AI.animal_id,
                  "Breed": AI.breed,
                });
                setState(() {});
              }
              _showUploadStatus(context);
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
