import 'package:flutter/material.dart';
import 'package:truck/button/signup_nb_button.dart';
import 'package:mysql1/mysql1.dart';
import 'package:truck/screens/login_page.dart';
import 'package:truck/button/drawer_snippet.dart';

class OwnerSignUp extends StatefulWidget {
  static String id = 'OwnerSignUp';
  @override
  _OwnerSignUpState createState() => _OwnerSignUpState();
}

class _OwnerSignUpState extends State<OwnerSignUp> {
  static int _currentStep = 0;
  int cid;
  String password;
  String name;
  String personalContactNumber;
  String email;
  String aadharNumber;
  String companyName;
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
        host: 'mysql5021.site4now.net',
        port: 3306,
        user: 'a5e6d1_demo102',
        db: 'db_a5e6d1_demo102',
        password: 'Admin@123#'));
    var countId = await conn.query('SELECT lid FROM login_owner order by lid DESC LIMIT 1;');
    print(countId);
    for (var row in countId) {
      newId = row[0];
      newId++;
      cid = newId;
    }
    await conn.close();
  }

  Future getCompanyLid() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql5021.site4now.net',
        port: 3306,
        user: 'a5e6d1_demo102',
        db: 'db_a5e6d1_demo102',
        password: 'Admin@123#'));
    var countCompanyId = await conn.query('SELECT company_lid FROM owner_company order by company_lid DESC LIMIT 1;');
    print(countCompanyId);
    for (var row in countCompanyId) {
      newCompanyId = row[0];
      companyId = newCompanyId;
      print(companyId);
    }
    await conn.close();
  }

  Future databaseEntry() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql5021.site4now.net',
        port: 3306,
        user: 'a5e6d1_demo102',
        db: 'db_a5e6d1_demo102',
        password: 'Admin@123#'));
    var result1 = await conn.query(
        'insert into owner_personal (lid, name, personal_contact_number, email, aadhar_number, company_lid) values (?,?,?,?,?,?)',
        [cid, name, personalContactNumber, email, aadharNumber, companyId++]);

    var result2 = await conn.query(
        'insert into owner_company (company_lid, company_name, company_registration_number, address_number, address_area, city, state, pincode, office_contact_number, office_email, lid) values (?,?,?,?,?,?,?,?,?,?,?)',
        [
          companyId++,
          companyName,
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
    var result3 = await conn.query(
        'insert into login_owner (lid, password) values (?,?)',
        [cid, password]);

    print(result1);
    print(result2);
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
                Text('Details added can be changed after logging in later.'),
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
        drawer: DrawerSnippet(),
        appBar: AppBar(
          title: Text('Owner Sign Up Page' ,style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
        actions: <Widget>[FlatButton(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);})],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topLeft: Radius.zero,topRight: Radius.zero),
        ),
        backgroundColor: Color(0xff0C1338),),
        body: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue: _currentStep < 2 ? () =>
              setState(() => _currentStep += 1) : () => _showMyDialog(),
          onStepCancel: _currentStep > 0 ? () =>
              setState(() => _currentStep -= 1) : () =>
              setState(() => Navigator.pop(context)),
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Container(
              alignment: Alignment.bottomRight,
              child: Wrap(
              children: <Widget>[
                SizedBox(height: 70.0),
                NextButton(
                  continueButton: onStepContinue,
                ),
                SignUpBackButton(backButton: onStepCancel,),
              ],
              )
            );
          },
          steps: <Step>
          [
            Step(
//STEP 1
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


