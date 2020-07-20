import 'package:flutter/material.dart';
//import 'package:truck/constants.dart';
//import 'package:mysql1/mysql1.dart';
import 'package:truck/button/signup_nb_button.dart';
import 'package:truck/button/drawer_snippet.dart';
import 'package:truck/constants.dart';

class ClientAdd extends StatefulWidget {
  @override
  _ClientAddState createState() => _ClientAddState();
}

class _ClientAddState extends State<ClientAdd> {

  bool checkBoxValue= false;
  static int _currentStep = 0;
  bool visibleMeter() {
    if (_currentStep == 2) {
      return true;
    } else {
      return false;
    }
  }
  DateTime _date1;
  DateTime _date2;
  bool fragile = false;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Consignment Details can not be changed later'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned.fill(
        child: Image.asset(
          'images/bg3.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
          alignment: Alignment.bottomLeft,
        ),
      ),
      MaterialApp(
        theme: ThemeData.light().copyWith(textTheme: TextTheme()),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.transparent,
          drawer: DrawerSnippet(),
          appBar: AppBar(
            title: Text(
              'Client Sign Up Page',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.zero,
                  topRight: Radius.zero),
            ),
            backgroundColor: Color(0xff0C1338),
          ),
          body: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 1
                ? () => setState(() => _currentStep += 1)
                : () => _showMyDialog(),
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : () => setState(() => Navigator.pop(context)),
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
                      SignUpBackButton(
                        backButton: onStepCancel,
                      ),
                    ],
                  ));
            },
            steps: <Step>[
              Step(
//STEP1CONTINUE!
                title: Text('PickUp Details', style: kFormHeaders,),
                isActive: _currentStep >= 0,
                state: _currentStep >= 0 ? StepState.complete : StepState.editing,
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      style: kFormEntry,
                      decoration: InputDecoration(

                          labelText: 'PickUp Warehouse Address',labelStyle: kFormText),
                      onChanged: (value) {
//                      to = value;
                      },
                    ),
                    FlatButton(
                      child: Text('PickUp Date'),
                      onPressed: () {
                       showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2022)).then((value) => (date){ setState(() {
                         _date1 = date;
                       });});
                      },
                    ),
                    TextFormField(
                      style: kFormEntry,
                      decoration: InputDecoration(
                          labelText: 'DropOff Warehouse Address',labelStyle: kFormText),
                      onChanged: (value) {
//                      personalContactNumber = value;
                      },
                    ),
                    FlatButton(
                      child: Text('Expected DropOff Date',style: kFormText,),
                      onPressed: () {
                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2022)).then((value) => (date){ setState(() {
                          _date2 = date;
                        });});
                      },
                    ),
                  ],
                ),
              ),
              Step(
//STEP2
                title: Text('Load Details',style: kFormHeaders,),
                isActive: _currentStep >= 0,
                state: _currentStep >= 1 ? StepState.complete : StepState.editing,
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      style: kFormEntry,
                      decoration: InputDecoration(labelText: 'Load Weight',labelStyle: kFormText),
                      onChanged: (value) {
//                      companyName = value;
                      },
                    ),
                    TextFormField(
                      style: kFormEntry,
                      decoration: InputDecoration(labelText: 'Load Type',labelStyle: kFormText),
                      onChanged: (value) {
//                      workType = value;
                      },
                    ),
                    TextFormField(
                      style: kFormEntry,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(labelText: 'Load Description',labelStyle: kFormText),
                      onChanged: (newvalue) {
//                      state = newvalue;
                      },
                    ),
                    TextFormField(
                      style: kFormEntry,
                      decoration: InputDecoration(labelText: 'Truck Type',labelStyle: kFormText),
                      onChanged: (value) {
//                      pincode = value;
                      },
                    ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text('Remember me', style: kFormText,),
                        Checkbox(value: checkBoxValue,
                          activeColor: Colors.blueAccent,
                          onChanged:(bool newValue){
                            setState(() {
                            checkBoxValue = newValue;
                            });
                            }
                                                    ),

                    ],
                  ),
                ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
