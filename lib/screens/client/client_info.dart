import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/button/drawer_snippet.dart';
import 'package:truck/screens/owner/owner_main.dart';
import 'package:truck/constants.dart';
import 'package:truck/button/rounded_icon_button.dart';
import 'package:mysql1/mysql1.dart';

class ClientInfo extends StatefulWidget {
//  static String id = 'OwnerInfo';
  final int idGetter;
  ClientInfo({Key key,@required this.idGetter}): super(key: key);
  @override
  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {

  int lid;
  int cid;
  String name;
  int personalContactNumber;
  String email;
  int aadharNumber;
  int companyId;
  String newName;
  int newPersonalContactNumber;
  String newEmail;
  int newAadharNumber;
  int newCompanyId;

  String companyName;
  int companyRegistrationNumber;
  String addLine1;
  String addLine2;
  String city;
  String state;
  int pincode;
  int officeContactNumber;
  String officeEmail;

  bool counterPersonalDetails= false;
  bool counterCompanyDetails= false;

  bool isLoading = true;

  Timer _timer;

  Future setManagerDetails() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
//        host: 'mysql5021.site4now.net',
//        port: 3306,
//        user: 'a5e6d1_demo102',
//        db: 'db_a5e6d1_demo102',
//        password: 'Admin@123#'));
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var result3 = await conn.query("update manager_personal set name='$name', personal_contact_number='$personalContactNumber', email='$email', aadhar_number='$aadharNumber' where lid='$lid'");
    var result4 = await conn.query("update manager_company set company_name='$companyName', company_registration_number='$companyRegistrationNumber', address_number='$addLine1', address_area='$addLine2', city='$city', state='$state', pincode='$pincode', office_contact_number='$officeContactNumber', office_email='$officeEmail' where company_lid='$companyId'");
    await conn.close();
  }

  Future getManagerDetails() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
//        host: 'mysql5021.site4now.net',
//        port: 3306,
//        user: 'a5e6d1_demo102',
//        db: 'db_a5e6d1_demo102',
//        password: 'Admin@123#'));
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var result1= await conn.query(
        'SELECT name, personal_contact_number, email, aadhar_number, company_lid FROM manager_personal where lid=$lid');

    for (var row in result1) {
      name = row[0];
      personalContactNumber = row[1];
      email = row[2];
      aadharNumber = row[3];
      companyId = row[4];
    }
    var result2= await conn.query(
        'SELECT company_name, company_registration_number, address_number, address_area, city, state, pincode, office_contact_number, office_email FROM manager_company where company_lid=$companyId');

    for (var row in result2) {
      companyName = row[0];
      companyRegistrationNumber = row[1];
      addLine1 = row[2];
      addLine2 = row[3];
      city = row[4];
      state = row[5];
      pincode = row[6];
      officeContactNumber = row[7];
      officeEmail = row[8];
      setState(() {
        isLoading= false;
      });
    }
    print(result1);
    print(result2);
    await conn.close();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      lid = widget.idGetter;
    });
    print(lid);
    getManagerDetails();
  }

  @override
  void dispose() {
    getManagerDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            drawer: DrawerSnippet(),
            appBar: AppBar(
              title: Text('Information', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
              actions: <Widget>[FlatButton(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);})],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topLeft: Radius.zero,topRight: Radius.zero),
              ),
              backgroundColor: Color(0xff0C1338),
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          color: Color(0xffF2F4F7),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Welcome',
                                  style: kDrawerText,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 170.0),
                                  child: Divider(
                                    thickness: 2.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text('Login Id: $lid', style: kDrawerText),
                                Text('Company Id: $companyId', style: kDrawerText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Card(
                          color: Color(0xffF2F4F7),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    Text(
                                      'Personal Details',
                                      style: kDrawerText,
                                    ),
                                    SizedBox(width: 180.0,),
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.black,
                                        size: 24.0,
                                        semanticLabel: 'Edit',),
                                      onPressed: () {
                                        counterPersonalDetails = true;
                                      },
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 2.0,
                                  color: Colors.black87,
                                ),
                                TextFormField(
                                  readOnly: counterPersonalDetails == true
                                      ? false
                                      : true,
                                  initialValue: name,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Name', border: InputBorder.none,),
                                  onChanged: (value) {
                                    name = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterPersonalDetails == true
                                      ? false
                                      : true,
                                  initialValue: personalContactNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Contact Number',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    personalContactNumber = int.parse(value);
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterPersonalDetails == true
                                      ? false
                                      : true,
                                  initialValue: email,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email', border: InputBorder.none,),
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterPersonalDetails == true
                                      ? false
                                      : true,
                                  initialValue: aadharNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Aadhar Number',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    aadharNumber = int.parse(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Card(
                          color: Color(0xffF2F4F7),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    Text(
                                      'Company Details',
                                      style: kDrawerText,
                                    ),
                                    SizedBox(width: 170.0,),
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.black,
                                        size: 24.0,
                                        semanticLabel: 'Edit',),
                                      onPressed: () {
                                        counterCompanyDetails = true;
                                      },

                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 2.0,
                                  color: Colors.black87,
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: companyName,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Company Name',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    companyName = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: companyRegistrationNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Company Registration Number',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    companyRegistrationNumber = int.parse(value);
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: addLine1,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Address Line 1',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    addLine1 = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: addLine2,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Address Line 2',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    addLine2 = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: city,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'City', border: InputBorder.none,),
                                  onChanged: (value) {
                                    city = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: state,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'State', border: InputBorder.none,),
                                  onChanged: (value) {
                                    state = value;
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: pincode.toString(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Pincode', border: InputBorder.none,),
                                  onChanged: (value) {
                                    pincode = int.parse(value);
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: officeContactNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Office Contact Number',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    officeContactNumber = int.parse(value);
                                  },
                                ),
                                TextFormField(
                                  readOnly: counterCompanyDetails == true
                                      ? false
                                      : true,
                                  initialValue: officeEmail,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(labelText: 'Office Email',
                                    border: InputBorder.none,),
                                  onChanged: (value) {
                                    officeEmail = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(200.0, 0, 0, 16.0),
                          child: RoundedButton(
                            title: 'Save',
                            colour: Colors.blue,
                            onPressed: () {
                              setManagerDetails();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )

            )
        )
    );
  }
}