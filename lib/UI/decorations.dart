import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deco{

  titleCon(String txt){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.blue[200],
      borderRadius:
        BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Text(txt,
          style: TextStyle( fontSize: 21, fontWeight: FontWeight.w900),),
      ),
    );
  }

  decoBox(Color col){

    return BoxDecoration(
      color:col,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(width: 1.0, color: Colors.blue.shade300,),
    );

  }

}