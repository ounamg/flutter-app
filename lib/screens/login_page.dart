import 'package:flutter/material.dart';
import 'package:truck/button/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:truck/constants.dart';
import 'package:truck/button/dropdownbutton_login.dart';
import '../screens/signup/sign_up.dart';
import 'package:mysql1/mysql1.dart';
import 'package:truck/screens/owner/owner_main.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading= false;
  String cid;
  int pid = 1001;

  String password;
  String tableName;
  String newTableName;


  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Login Credentials'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Id and password do not match.'),
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
    int newId;
    var newPass;

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var results = await conn
        .query('select lid, password from $newTableName where lid = $cid');
    for (var row in results) {
      newId = row[0];
      newPass = row[1];
      if (newId == int.parse(cid) && newPass == password) {
        print('valid');
      }
      else {
        _showMyDialog();
      }
    }
    await conn.close();
  }
  void table(String tableName) {
    newTableName= tableName;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.yellowAccent[200],
        appBar: AppBar(
          title: Text('Login',style: kAppBarText,),
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
              onPressed: () async {
                databaseEntry();
                setState(() {
                  _isLoading = true;
                  String table1 = newTableName;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OwnerMain(idGetter: pid,);
                },
                )
                );
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
    );
  }
}
