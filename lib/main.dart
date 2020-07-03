import 'package:flutter/material.dart';
import 'package:truck/screens/landing_page.dart';
import 'package:truck/screens/login_page.dart';
import 'package:truck/screens/signup/sign_up.dart';
import 'package:truck/screens/signup/signup_manager.dart';
import 'package:truck/screens/signup/signup_owner.dart';
import 'package:truck/screens/signup/signup_client.dart';
import 'package:truck/screens/owner/owner_main.dart';
import 'package:truck/screens/owner/owner_info.dart';
import 'package:truck/screens/owner/owner_trucklist.dart';
//import 'package:truck/trial.dart';
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
        OwnerMain.id:(context) => OwnerMain(),
        OwnerInfo.id:(context) => OwnerInfo(),
//        AppTrial.id:(context) => AppTrial(),
      },
    );
  }
}

