import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deco{

  titleCon(String txt){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.indigo.shade300,
      borderRadius:
        BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Text(txt,
            textAlign: TextAlign.start,
          style: TextStyle( fontSize: 21, fontWeight: FontWeight.w900),),
      ),
    );
  }

  titleConNew(String txt){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.only(
        bottomRight:  Radius.circular(40),
        bottomLeft:  Radius.circular(40),
        ),
      ),
      child: Center(
        child: Text(txt,
            textAlign: TextAlign.start,
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

  decoBoxNew(){

    return BoxDecoration(
      color:Colors.lightBlue.shade200,
      borderRadius: BorderRadius.only(
        bottomLeft:Radius.circular(40),
        bottomRight:Radius.circular(40)
      ),
      border: Border.all(width: 1.0, color: Colors.blue.shade300,),
    );

  }

}