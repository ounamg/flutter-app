import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  static String id = 'LandingPage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellowAccent[200],
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
              SizedBox(height: 150.0,),
              RaisedButton(child: Text('Continue ->'),
                onPressed: (){
                Navigator.pushNamed(context, LoginPage.id);
                },
                color: Colors.yellowAccent,
                textColor: Colors.black54,
                highlightColor: Colors.yellow,
                hoverColor: Colors.yellow[100],
                disabledColor: Colors.yellowAccent[250],
              )

            ],
          ),
        ),
        ),
      ),
    );

  }
}
