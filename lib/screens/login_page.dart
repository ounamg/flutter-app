import 'package:flutter/material.dart';
import 'package:truck/icons/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:truck/constants.dart';
import 'dart:io' show Platform;

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String selectedMode = 'Manager';
  List userMode = ['Client','Owner','Manager'];

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < userMode.length; i++) {
      String valueChosen = userMode[i];
      var newItem = DropdownMenuItem(
        child: Text(valueChosen),
        value: valueChosen,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedMode,
      items: dropDownItems,
      isDense: true,
      isExpanded: true,
      icon: Icon(Icons.list),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      onChanged: (value) {
        setState(() {
          selectedMode = value;
        });

      },
    );
  }
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String valueChosen in userMode) {
      pickerItems.add(Text(valueChosen));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedMode = userMode[selectedIndex];

        });
      },
      children: pickerItems,
    );
  }


  bool _isLoading = false;
  String id;
  String password;

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          Center(
            child: Container(
//              height: 150.0,
              alignment: Alignment.center,
              width: 90.0,
//              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.black54,

              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            ),
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