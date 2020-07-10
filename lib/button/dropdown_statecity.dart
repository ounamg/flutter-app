//MULTIPLE DROPDOWN

import 'package:flutter/material.dart';
import 'package:truck/logic/repo.dart';
import 'package:truck/screens/owner/owner_trucklist.dart';
//import 'globals.dart' as globals;

class StateCityDD extends StatefulWidget {
  String state;
  String city;
  bool appliedCity;
  bool appliedState;
  final Function cityName;
  final Function stateName;
  StateCityDD(this.stateName, this.cityName);
  @override
  _StateCityDDState createState() => _StateCityDDState();
}

class _StateCityDDState extends State<StateCityDD> {
  Repository repo = Repository();
  List<String> _states = ["State"];
  List<String> _lgas = ["City"];
  String _selectedState = "State";
  String _selectedLGA = "City";

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
//    _selectedState = 'dick';
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.grey[350]),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                  isExpanded: true,
                        items: _states.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,overflow: TextOverflow.ellipsis,),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _onSelectedState(value);
                          } ,
                        value: _selectedState,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.grey[350]),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                  isExpanded: true,
                        items: _lgas.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,overflow: TextOverflow.ellipsis,),
                          );
                        }).toList(),
                        // onChanged: (value) => print(value),
                        onChanged: (value) => _onSelectedLGA(value),
                        value: _selectedLGA,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose ..";
      _lgas = ["Choose .."];
      _selectedState = value;
      widget.state = _selectedState;
      widget.appliedState=true;
      _lgas = List.from(_lgas)..addAll(repo.getLocalByState(value));
      return widget.stateName(widget.state,widget.appliedState);
    });
  }

  void _onSelectedLGA(String value) {
    setState(() {
      _selectedLGA = value;
      widget.city = _selectedLGA;
      widget.appliedCity=true;
      return widget.cityName(widget.city,widget.appliedCity);
    });
  }
}