import 'package:flutter/material.dart';
import '';


class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellowAccent,
        child: Icon(
            (Icons.add)
        ),
        onPressed: (){},
      ),
      backgroundColor: Colors.yellowAccent[200],
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black38,
      ),
    );
  }
}

