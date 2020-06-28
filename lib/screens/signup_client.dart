import 'package:flutter/material.dart';
import 'package:truck/button/signup_nb_button.dart';
import 'package:mysql1/mysql1.dart';

class ClientSignUp extends StatefulWidget {
  static String id = 'ClientSignUp';
  @override
  _ClientSignUpState createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {

  static int _currentStep = 0;
  String id;
  String password;
  String name;
  String mobileNumber;
  String altMobileNumber;
  String email;
  String aadharNumber;
  String city;
  String state;

  bool visibleMeter(){
    if(_currentStep == 2){
      return true;
    }
    else{
      return false;
    }
  }

//  Future dataEntry() async {
//    final conn = await MySqlConnection.connect(ConnectionSettings(
//        host: '10.0.2.2', port: 3306, user: 'root', db: 'logistic', password: 'Pragya1798*'));

    // Create a table
//    await conn.query(
//        'CREATE TABLE users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), age int)');
//
    // Insert into a table
//    var result = await conn.query(
//        'insert into loginclient(client_id, client_pass) values (?, ?)',
//        ['Bob', 'bob@bob.com']);
//    print('Inserted row id=${result.insertId}');

    // Query the database using a parameterized query
//    var results = await conn
//        .query('select name, email from users where id = ?', [result.insertId]);
//    for (var row in results) {
//      print('Name: ${row[0]}, email: ${row[1]}');
//    }

    // Finally, close the connection
//    await conn.close();
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Visibility(
          visible: visibleMeter(),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text('Manager Sign Up Page'),
          backgroundColor: Colors.blue,),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue: _currentStep < 2 ? () => setState(() => _currentStep += 1) : () => setState(() => Navigator.pop(context)),
          onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : () => setState(() => Navigator.pop(context)),
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}){
            return Wrap(
              children: <Widget>[
                SizedBox(height: 70.0),
                NextButton(continueButton: onStepContinue,),
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
              state: _currentStep >= 0 ? StepState.complete : StepState.editing,
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Alternate Mobile Number'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Id'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Aadhar Id'),
                  ),
                ],
              ),
            ),
            Step(
//STEP2
              title: const Text('Company Details'),
              isActive: _currentStep >= 0,
              state: _currentStep >= 1 ? StepState.complete : StepState.editing,
              content: Column(
                children: <Widget>[
                  Text('Company Details',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Company Name'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Work Type'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Company Registration Number'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line 1'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line 2'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'State'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Pincode'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Office Mobile Number'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Official Email-Address'),
                  ),
                ],
              ),
            ),
            Step(
//STEP3
              title: Text('Generate Id'),
              isActive: _currentStep >= 0,
              state: _currentStep >= 2 ? StepState.complete : StepState.editing,
              content: Column(
                children: <Widget>[
                  Text('Generate Login Details',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  FlatButton(
                    child: Text('Generate Email Id', style: TextStyle(decoration: TextDecoration.underline), textAlign: TextAlign.start,),onPressed: (){},
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value){
                      password =value;
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



