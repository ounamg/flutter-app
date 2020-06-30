import 'package:flutter/material.dart';
import 'package:truck/screens/owner/owner_main.dart';
import 'package:truck/constants.dart';

class OwnerInfo extends StatefulWidget {
  static String id = 'OwnerInfo';
  @override
  _OwnerInfoState createState() => _OwnerInfoState();
}

class _OwnerInfoState extends State<OwnerInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Information', style: kAppBarText,),
        )
      ),
    );
  }
}
