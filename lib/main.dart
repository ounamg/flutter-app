import 'package:flutter/material.dart';
import 'package:truck/screens/landing_page.dart';
import 'package:truck/screens/login_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: LandingPage(),
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context)=> LandingPage(),
        LoginPage.id: (context)=> LoginPage(),
      },
    );
  }
}

