import 'package:flutter/material.dart';
import 'package:truck/screens/landing_page.dart';
import 'package:truck/screens/login_page.dart';
import 'package:truck/screens/sign_up.dart';
import 'package:truck/screens/signup_owner.dart';
import 'package:truck/screens/signup_client.dart';
import 'package:truck/screens/signup_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'CrimsonText',),
      home: LandingPage(),
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context)=> LandingPage(),
        LoginPage.id: (context)=> LoginPage(),
        SignUp.id: (context) => SignUp(),
        OwnerSignUp.id:(context) => OwnerSignUp(),
        ManagerSignUp.id:(context) => ManagerSignUp(),
        ClientSignUp.id:(context) => ClientSignUp(),
      },
    );
  }
}

