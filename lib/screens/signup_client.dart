import 'package:flutter/material.dart';
import 'package:truck/button/signup_nb_button.dart';


class ClientSignUp extends StatefulWidget {
  static String id = 'ClientSignUp';
  @override
  _ClientSignUpState createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {
  static int _currentStep = 0;
  bool visibleMeter(){
    if(_currentStep == 2){
      return true;
    }
    else{
      return false;
    }
  }
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
              title: Text('Client Sign Up Page'),
          backgroundColor: Colors.blue,),
          body: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
            onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}){
              return Row(
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
                    TextFormField(
                      decoration: InputDecoration(labelText: 'City'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'State'),
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
                      decoration: InputDecoration(labelText: 'Company Registration Number'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Office Mobile Number'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Official Email-Address'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Loading Address'),
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
