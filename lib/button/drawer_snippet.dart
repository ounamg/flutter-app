import 'package:flutter/material.dart';
import 'package:truck/constants.dart';

class DrawerSnippet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Color(0xff0C1338),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0,),
              child: DrawerHeader(
                child: CircleAvatar(
                  child: Text('OG',style: kDrawerText,),

                ),
              ),
            ),
            ListTile(
              dense: false,

              title: Text('Logout',style: kDrawerText,),
              onTap: () {

              },
            ),
            ListTile(
              title: Text('Help',style: kDrawerText,),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Language',style: kDrawerText,),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Settings',style: kDrawerText,),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}