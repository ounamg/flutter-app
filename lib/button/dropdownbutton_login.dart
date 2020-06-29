import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class RoundedDropDown extends StatefulWidget {

  final Function table;
  String tableName;
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
      iconEnabledColor: Colors.redAccent,
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
          }else if(selectedMode=='Manager'){
            widget.tableName= 'login_manager';
          }else{
            widget.tableName= 'login_client';
          }
          widget.table(widget.tableName);

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
    return Platform.isIOS ? iOSPicker() : androidDropdown();
  }
}


