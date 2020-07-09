//MULTIPLE DROPDOWN

import 'package:flutter/material.dart';
import 'package:truck/logic/repo.dart';


class StateCityDD extends StatefulWidget {
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.grey[350]),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
//                  isExpanded: true,
                      items: _states.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (value) => _onSelectedState(value),
                      value: _selectedState,
                    ),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.grey[350]),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(  
//                  isExpanded: true,
                      items: _lgas.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      // onChanged: (value) => print(value),
                      onChanged: (value) => _onSelectedLGA(value),
                      value: _selectedLGA,
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
      _lgas = List.from(_lgas)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }
}