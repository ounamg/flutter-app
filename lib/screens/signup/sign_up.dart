import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Android/Project/truck/lib/screens/signup/signup_client.dart';
import 'file:///D:/Android/Project/truck/lib/screens/signup/signup_manager.dart';
import 'file:///D:/Android/Project/truck/lib/screens/signup/signup_owner.dart';
//import 'package:truck/constants.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellowAccent[200],
        body: Center(
          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo1.png'),
                ),
              ),
              SizedBox(
                width: 250.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: Text('Category', textAlign: TextAlign.center,style: TextStyle(fontSize: 45.0,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'CrimsonText'),),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                  color: Colors.black87,
                    thickness: 2.0,
              ),
                ),),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.local_shipping,size: 56.0,color: Colors.black87,),
                    title: Text('Owner'),
                    subtitle: Text('Transporter Giants'),
                    onTap: (){
                      Navigator.pushNamed(context, OwnerSignUp.id);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.account_circle,size: 56.0,color: Colors.black87,),
                    title: Text('Client'),
                    subtitle: Text('Customers with Load/Consignment'),
                    onTap: (){
                      Navigator.pushNamed(context, ClientSignUp.id);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.content_paste,size: 56.0,color: Colors.black87,),
                    title: Text('Manager'),
                    subtitle: Text('Direct Truck handlers'),
                    onTap: (){
                      Navigator.pushNamed(context, ManagerSignUp.id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
