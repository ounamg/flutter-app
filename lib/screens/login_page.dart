import 'package:flutter/material.dart';
import 'package:truck/icons/rounded_icon_button.dart';
import 'package:truck/constants.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  String id;
  String password;

  TextEditingController idController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[200],
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black38,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'logo',
            child: Container(
              height: 150.0,
              child: Image.asset('images/logo1.png'),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0,32.0,32.0,4.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              controller: idController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                id = value;
              },
              decoration:
              kTextFieldDecoration.copyWith(hintText: 'Enter id'),
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0,4.0,32.0,32.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter password'),
            ),
          ),
          SizedBox(
            height: 13.0,
          ),
          RoundedButton(
            title: 'Log In',
            colour: Colors.black87,
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
            },
          ),
          SizedBox(
            height: 13.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                textColor: Colors.black87,
                onPressed: () {
//                  Navigator.pushNamed(context, )
                },
                child: Text('SIGN UP', style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
                ),
              ),
              SizedBox(width: 10.0),
              FlatButton(
                textColor: Colors.black87,
                onPressed: () {
//                  Navigator.pushNamed(context, routeName)
                },
                child: Text('Forgot Password', style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}