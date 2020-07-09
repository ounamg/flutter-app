import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpBackButton extends StatelessWidget {
  final backButton;
  SignUpBackButton({this.backButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: RaisedButton(
          child: Text('Back',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),

          onPressed: backButton
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final continueButton;
  NextButton({this.continueButton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: RaisedButton(
        child: Text('Next',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        onPressed: continueButton,
        color: Colors.blue[300],
        hoverColor: Colors.blue,),
    );
  }
}
