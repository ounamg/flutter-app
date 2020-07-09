import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/login_page.dart';
import 'package:truck/button/rounded_icon_button.dart';

class LandingPage extends StatelessWidget {
  static String id = 'LandingPage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Hero(
                tag: 'logo',

                child: Image(
                  image: AssetImage('images/logo1.png'),
//                height: 260.0,
//                width: 500.0,
//              alignment: ,
                ),
              ),
              SizedBox(height: 30.0,),
              Text('Logistics made easy',
              style: TextStyle(
                color: Color(0xff0C1338),
                fontFamily: 'Pacifico',
//                fontStyle: FontStyle.italic,
                fontSize: 30.0
              ),),
              SizedBox(height: 300.0,),
            RoundedButton(title: 'Continue ->',colour: Color(0xff0C1338), onPressed: (){
                Navigator.pushNamed(context, LoginPage.id);
                },)
            ],
          ),
        ),
        ),
      ),
    );

  }
}


//0xffFABD00