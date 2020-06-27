import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ManagerSignUp extends StatefulWidget {
  static String id = 'ManagerSignUp';
  @override
  _ManagerSignUpState createState() => _ManagerSignUpState();
}

class _ManagerSignUpState extends State<ManagerSignUp> {
  static int _currentStep = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Manager Sign Up Page'),
        backgroundColor: Colors.black38,),
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
              FlatButton(
                child: Text('Next'),
                onPressed: _currentStep < 3 ? onStepContinue : AlertDialog(title: Text('Tada!',)),
              )
            ],
          );
        },
        steps: <Step>
        [
          Step(
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

            title: const Text('Company Details'),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ? StepState.complete : StepState.editing,
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Home Address'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Postcode'),
                ),
              ],
            ),
          ),
          Step(

            title: Text('Generate Id'),
            isActive: _currentStep >= 0,
            state: _currentStep >= 2 ? StepState.complete : StepState.editing,
            content: Column(
              children: <Widget>[
                Text(
                    'Hello'
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
