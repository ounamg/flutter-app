import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class TruckClassDropDown extends StatefulWidget {
//  final Function table;
//  String tableName;
//  TruckClassDropDown(this.table);
  @override
  _TruckClassDropDownState createState() => _TruckClassDropDownState();
}

class _TruckClassDropDownState extends State<TruckClassDropDown> {
  String selectedMode = 'Smuggle';
  List<Map> _vehClass = [
    {"id": 0, "image": "images/1.png", "name": "Smuggle"},
    {"id": 1, "image": "images/2.png", "name": "Axle Shaft"},
    {"id": 2, "image": "images/3.png", "name": "FuckITUP"},
    {"id": 3, "image": "images/4.png", "name": "RakeItUp"},
    {"id": 4, "image": "images/5.png", "name": "PooPPl"},
    {"id": 5, "image": "images/6.png", "name": "Tipple"},
  ];

//  CupertinoPicker iOSPicker() {
//    List<Text> pickerItems = [];
//    for (String valueChosen in userMode) {
//      pickerItems.add(Text(valueChosen));
//    }
//
//    return CupertinoPicker(
//      backgroundColor: Colors.lightBlue,
//      itemExtent: 32.0,
//      onSelectedItemChanged: (selectedIndex) {
//        setState(() {
//          selectedMode = userMode[selectedIndex];
//        });
//      },
//      children: pickerItems,
//    );
//  }

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
            padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Select'),
                        value: selectedMode,
                        onChanged: (String value) {
                          setState(() {
                            selectedMode = value;
                          });
                          print(selectedMode);
                        },
                        items: _vehClass.map((Map map) {
                          return DropdownMenuItem<String>(
                            value: map["name"].toString(),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  map["image"],
                                  height: 90,
                                  width: 150,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(map["name"]),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
