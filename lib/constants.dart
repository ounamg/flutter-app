import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black54),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kDrawerText = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.0
);
//const kDrawerBg = Borde
const kAppBarText = TextStyle(
    color: Colors.white, fontStyle: FontStyle.italic
);

const kAppBarStyle = TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0);

const kFormText = TextStyle(fontWeight: FontWeight.w600,fontSize: 20.0, color: Colors.white70);
const kFormEntry = TextStyle(fontWeight: FontWeight.bold, fontSize:  21.0, color: Colors.white);

const kFormHeaders = TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white);
