import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String animal;

class AnimalProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AnimalProfile();
  }
}

class _AnimalProfile extends State<AnimalProfile> {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("animal Profile"),
      ),
      body: Text("ANimal profile will be here" + "\nBreed:" + animal),
    );
  }
}
