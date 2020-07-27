import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class RoundedDropDown extends StatefulWidget {

  final Function table;
  String tableName;
  String collectionName;
  RoundedDropDown(this.table);
  @override
  _RoundedDropDownState createState() => _RoundedDropDownState();
}

class _RoundedDropDownState extends State<RoundedDropDown> {

  String selectedMode = 'Manager';
  List userMode = ['Client', 'Owner', 'Manager'];

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
          iconEnabledColor: Color(0xff0C1338),
          iconDisabledColor: Colors.redAccent,
          items: dropDownItems,
//      isDense: true,
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
              if(selectedMode=='Owner'){
                widget.tableName= 'login_owner';
                widget.collectionName='owner';
              }else if(selectedMode=='Manager'){
                widget.tableName= 'login_manager';
                widget.collectionName='manager';
              }else{
                widget.tableName= 'login_client';
                widget.collectionName='client';
              }
             return widget.table(widget.tableName,widget.collectionName);

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
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0, left: 20.0),
        child: Platform.isIOS ? iOSPicker() : androidDropdown()));
  }
}



