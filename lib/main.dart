import 'package:flutter/material.dart';
import 'package:truck/screens/landing_page.dart';
import 'package:truck/screens/login_page.dart';
import 'package:truck/screens/signup/sign_up.dart';
import 'package:truck/screens/signup/signup_manager.dart';
import 'package:truck/screens/signup/signup_owner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
    )),),
      home: LandingPage(),
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context)=> LandingPage(),
        LoginPage.id: (context)=> LoginPage(),
        SignUp.id: (context) => SignUp(),
        OwnerSignUp.id:(context) => OwnerSignUp(),
        ManagerSignUp.id:(context) => ManagerSignUp(),
//        ClientSignUp.id:(context) => ClientSignUp(),
//        OwnerMain.id:(context) => OwnerMain(),
//        OwnerInfo.id:(context) => OwnerInfo(),
//        AppTrial.id:(context) => AppTrial(),
      },
    );
  }
}

