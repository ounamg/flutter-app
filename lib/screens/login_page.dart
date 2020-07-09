import 'dart:math';

import 'package:flutter/material.dart';
import 'package:truck/button/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:truck/constants.dart';
import 'package:truck/button/dropdownbutton_login.dart';
import 'package:truck/screens/manager/manager_main.dart';
import '../screens/signup/sign_up.dart';
import 'package:mysql1/mysql1.dart';
import 'package:truck/screens/owner/owner_main.dart';
import 'package:truck/button/drawer_snippet.dart';

class LoginPage extends StatefulWidget {

  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = true;
  String cid;
  int pid = 1001;

  String password;
  String tableName;
  String newTableName;
  int newId;
  var newPass;
  bool correct;

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _showMyDialog(String text) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Login Credentials'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future databaseEntry() async {

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql5021.site4now.net',
        port: 3306,
        user: 'a5e6d1_demo102',
        db: 'db_a5e6d1_demo102',
        password: 'Admin@123#'));
//        host: 'mysql5021.site4now.net',
//        port: 3306,
//        user: 'a5e6d1_demo102',
//        db: 'db_a5e6d1_demo102',
//        password: 'Admin@123#'));
    try {
    var results = await conn
        .query('select lid, password from $newTableName where lid = $cid');
    for (var row in results) {
      newId = row[0];
      newPass = row[1];
    }

      switch (newTableName){
        case 'login_owner' : {
          if (newId == int.parse(cid) && newPass == password) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OwnerMain(idGetter: pid,);},));
          }
          else {
            _showMyDialog('Incorrect Id or Password.');
          }
          break;
        }
        case 'login_manager' :{
          if (newId == int.parse(cid) && newPass == password) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ManagerMain(idGetter: newId,);},));
          }
        }
        break;
      }
    }catch (e){
      print(e);
      _showMyDialog('Invalid Mode selected');
    }


    await conn.close();
  }
  void table(String tableName) {
      newTableName= tableName;
      print(newTableName);
//    return newTableName;
  }
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        drawer: DrawerSnippet(),
        appBar: AppBar(
          title: Text('Login', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
          actions: <Widget>[FlatButton(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);})],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topLeft: Radius.zero,topRight: Radius.zero),
          ),
          backgroundColor: Color(0xff0C1338),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',

                child: Container(
                  height: 180.0,
                  child: Image.asset('images/logo1.png',),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: SizedBox(
                  width: 150.0,
                  child: RoundedDropDown(table),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 4.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: idController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    cid = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter id'),

                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 4.0, 32.0, 32.0),
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter password'),
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.black87,
                onPressed: () {
                  databaseEntry();
//                  setState(() {
//                    _isLoading = false;
//                  });
                }
                ),
              SizedBox(
                height: 13.0,
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.black87,
                      onPressed: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
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
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
