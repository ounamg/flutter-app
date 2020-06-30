import 'package:flutter/material.dart';
import 'package:truck/button/signup_nb_button.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:convert';

import 'package:truck/screens/login_page.dart';

class ClientSignUp extends StatefulWidget {
  static String id = 'ClientSignUp';
  @override
  _ClientSignUpState createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {

  static int _currentStep = 0;
  int cid;
  String password;
  String name;
  String personalContactNumber;
  String email;
  String aadharNumber;
  String companyName;
  String workType;
  String companyRegistrationNumber;
  String addLine1;
  String addLine2;
  String city;
  String state;
  String pincode;
  String officeContactNumber;
  String officeEmail;
  int newId;
  int newCompanyId;
  int companyId; // auto increment company id and add it to database along with other details.no use of flutter

  Future getLid() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var countId = await conn.query('SELECT lid FROM login_client order by lid DESC LIMIT 1;');
    print(countId);
    for (var row in countId) {
      newId = row[0];
      newId++;
      cid = newId;
//      print('2: $cid');
    }
    await conn.close();
  }

  Future getCompanyLid() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var countCompanyId = await conn.query('SELECT company_lid FROM client_company order by lid DESC LIMIT 1;');
    print(countCompanyId);
    for (var row in countCompanyId) {
      newCompanyId = row[0];
      newCompanyId++;
      companyId = newCompanyId;
      print(newCompanyId);
    }
    await conn.close();
  }


    Future databaseEntry() async {
      final conn = await MySqlConnection.connect(ConnectionSettings(
          host: '10.0.2.2',
          port: 3306,
          user: 'root',
          db: 'logistic',
          password: 'Ati@radeon1'));

      var result1 = await conn.query(
          'insert into client_personal (lid, Name, personal_contact_number, email, aadhar_number, company_lid) values (?,?,?,?,?,?)',
          [cid, name, personalContactNumber, email, aadharNumber, companyId]);

      var result2 = await conn.query(
          'insert into client_company (company_lid, company_name, work_type, company_registration_number, address_number, address_area, city, state, pincode, office_contact_number, office_email, lid) values (?,?, ?, ?,?,?, ?, ?,?, ?, ?,?)',
          [
            companyId,
            companyName,
            workType,
            companyRegistrationNumber,
            addLine1,
            addLine2,
            city,
            state,
            pincode,
            officeContactNumber,
            officeEmail,
            cid
          ]);
//
      var result3 = await conn.query(
          'insert into login_client (lid, password) values (?,?)',
          [cid, password]);

//      print(result1);
//      print(result2);
      print(result3);
      await conn.close();
    }


    bool visibleMeter() {
      if (_currentStep == 2) {
        return true;
      }
      else {
        return false;
      }
    }
    String validator(value){
        var numValue = int.tryParse(value);
        if(numValue >= 5 && numValue < 100) {
          return null;
        }
        return 'Inavlid Format';
      }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit Form'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Details added can be changed after loggin in later.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
                databaseEntry();
              },
            ),
          ],
        );
      },
    );
  }

  @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.white,
          floatingActionButton: Visibility(
            visible: visibleMeter(),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerFloat,
          appBar: AppBar(
            title: Text('Client Sign Up Page'),
            backgroundColor: Colors.blue,),
          body: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 2 ? () =>
                setState(() => _currentStep += 1) : () => _showMyDialog(),
            onStepCancel: _currentStep > 0 ? () =>
                setState(() => _currentStep -= 1) : () =>
                setState(() => Navigator.pop(context)),
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Wrap(
                children: <Widget>[
                  SizedBox(height: 70.0),
                  NextButton(
                    continueButton: onStepContinue,
                  ),
                  SignUpBackButton(backButton: onStepCancel,),
                ],
              );
            },
            steps: <Step>
            [
              Step(
//STEP1
                title: Text('Personal Details'),
                isActive: _currentStep >= 0,
                state: _currentStep >= 0 ? StepState.complete : StepState
                    .editing,
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Mobile Number'),
                      onChanged: (value) {
                        personalContactNumber = value;
                      },

                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email Id'),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Aadhar Id'),
                      onChanged: (value) {
                        aadharNumber = value;
                      },
                    ),
                  ],
                ),
              ),
              Step(
//STEP2
                title: const Text('Company Details'),
                isActive: _currentStep >= 0,
                state: _currentStep >= 1 ? StepState.complete : StepState
                    .editing,
                content: Column(
                  children: <Widget>[
                    Text('Company Details', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Company Name'),
                      onChanged: (value) {
                        companyName = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Work Type'),
                      onChanged: (value) {
                        workType = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Company Registration Number'),
                      onChanged: (value) {
                        companyRegistrationNumber = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address Line 1'),
                      onChanged: (value) {
                        addLine1 = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address Line 2'),
                      onChanged: (value) {
                        addLine2 = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'City'),
                      onChanged: (value) {
                        city = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'State'),
                      onChanged: (newvalue) {
                        state = newvalue;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Pincode'),
                      onChanged: (value) {
                        pincode = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Office Mobile Number'),
                      onChanged: (value) {
                        officeContactNumber = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Office Email-Address'),
                      onChanged: (value) {
                        officeEmail = value;
                      },
                    ),
                  ],
                ),
              ),
              Step(
//STEP3
                title: Text('Generate Id'),
                isActive: _currentStep >= 0,
                state: _currentStep >= 2 ? StepState.complete : StepState
                    .editing,
                content: Column(
                  children: <Widget>[
                    Text('Generate Login Details', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),),
                    FlatButton(
                      child: Text('Generate User Id',
                        style: TextStyle(decoration: TextDecoration.underline),
                        textAlign: TextAlign.start,), onPressed: () {
                      getLid();

                      getCompanyLid();

                    },
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(labelText: 'Enter Password'),
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


