import 'package:flutter/material.dart';

class RoundedDropDown extends StatefulWidget {
  @override
  _RoundedDropDownState createState() => _RoundedDropDownState();
}

class _RoundedDropDownState extends State<RoundedDropDown> {

  String dropdownValue = 'Client';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.0,32.0,32.0,4.0),
      child: Material(
        elevation: 5.0,
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          disabledHint: Text('User Category'),
          dropdownColor: Colors.redAccent,
          focusColor: Colors.lightBlue,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black87),
//        underline: Container(
//          height: 2,
//          color: Colors.deepPurpleAccent,
//        ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Owner', 'Manager', 'Client']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
