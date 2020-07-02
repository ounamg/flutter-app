import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants.dart';
import 'package:truck/screens/owner/owner_info.dart';
import 'package:truck/screens/owner/owner_trucklist.dart';
import 'package:mysql1/mysql1.dart';

class OwnerMain extends StatefulWidget {
  static String id = 'OwnerMain';
  final int idGetter;
  OwnerMain({Key key,@required this.idGetter}): super(key: key);
  @override
  _OwnerMainState createState() => _OwnerMainState();
}

class _OwnerMainState extends State<OwnerMain> {

  String name;
  int pid = 1001;
  int lid;
  bool isLoading = true;

  Future getOwnerDetails() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var result1= await conn.query(
        'SELECT name FROM owner_personal where lid=$lid');

    for (var row in result1) {
      name = row[0];
      setState(() {
        isLoading= false;
      });
    }

    await conn.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOwnerDetails();
    setState(() {
      lid = widget.idGetter;
    });
    print(lid);
  }
  @override
  void dispose() {
    getOwnerDetails();
    super.dispose();
  }

//  Widget projectWindow(){
//    return ;
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellowAccent[200],
        drawer: Drawer(

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0,),
                child: DrawerHeader(
                  child: CircleAvatar(
                    child: Text('OG',style: kDrawerText,),

                  ),
                ),
              ),
              ListTile(
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
        appBar: AppBar(
          title: Text('Weclome $name', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
          backgroundColor: Colors.black38,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.yellowAccent[200],
            ),
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.content_paste,size: 56.0,color: Colors.black87,),
                        title: Text('Information'),
                        subtitle: Text('Edit/View/Add information'),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return OwnerInfo(idGetter: pid,);
                          },
                          )
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.local_shipping,size: 56.0,color: Colors.black87,),
                        title: Text('Trucks'),
                        subtitle: Text('List of Trucks, Add/View Trucks'),

                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return OwnerTruckList();
                          },
                          )
                          );
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.person,size: 56.0,color: Colors.black87,),
                        title: Text('Driver'),
                        subtitle: Text('Hired Drivers, Drivers on Duty'),
                        onTap: (){
//                      Navigator.pushNamed(context, ManagerSignUp.id);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.person_add,size: 56.0,color: Colors.black87,),
                        title: Text('Assistance'),
                        subtitle: Text('Hired Assistants'),
                        onTap: (){
//                      Navigator.pushNamed(context, ManagerSignUp.id);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.person_pin_circle,size: 56.0,color: Colors.black87,),
                        title: Text('Managers'),
                        subtitle: Text('Appointed Managers'),
                        onTap: (){
//                      Navigator.pushNamed(context, ManagerSignUp.id);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.inbox,size: 56.0,color: Colors.black87,),
                        title: Text('Consignments'),
                        subtitle: Text('Current Consignments and Log Book'),
                        onTap: (){
//                      Navigator.pushNamed(context, ManagerSignUp.id);
                        },
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.receipt,size: 56.0,color: Colors.black87,),
                        title: Text('Finance'),
                        subtitle: Text('Monetary Status, records'),
                        onTap: (){
//                      Navigator.pushNamed(context, ManagerSignUp.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )

        )
      ),
    );
  }
}
