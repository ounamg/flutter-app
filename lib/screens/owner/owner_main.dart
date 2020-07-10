import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/button/drawer_snippet.dart';
import 'package:truck/screens/owner/owner_assistance.dart';
import 'package:truck/screens/owner/owner_driverlist.dart';
import 'package:truck/screens/owner/owner_info.dart';
import 'package:truck/screens/owner/owner_managerlist.dart';
import 'package:truck/screens/owner/owner_trucklist.dart';
import 'package:mysql1/mysql1.dart';

class OwnerMain extends StatefulWidget {
  final int idGetter;
  OwnerMain({Key key,@required this.idGetter}): super(key: key);
  @override
  _OwnerMainState createState() => _OwnerMainState();
}

class _OwnerMainState extends State<OwnerMain> {
  String name;
  int lid;
  bool isLoading = true;

  Future getOwnerDetails() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
//        host: 'mysql5021.site4now.net',
//        port: 3306,
//        user: 'a5e6d1_demo102',
//        db: 'db_a5e6d1_demo102',
//        password: 'Admin@123#'));
    var result1= await conn.query('SELECT name FROM owner_personal where lid=$lid');

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
    super.initState();
    getOwnerDetails();
    setState(() {
      lid = widget.idGetter;
    });
    print(lid);
  }

//  @override
//  void dispose() {
//    getOwnerDetails();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: DrawerSnippet(),
          appBar: AppBar(
            title: Text('Welcome $name', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
            actions: <Widget>[FlatButton(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);})],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topLeft: Radius.zero,topRight: Radius.zero),
            ),
            backgroundColor: Color(0xff0C1338),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
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
                        color: Color(0xffF2F4F7),
                        child: ListTile(
                          leading: Icon(Icons.content_paste,size: 56.0,color: Colors.black87,),
                          title: Text('Information'),
                          subtitle: Text('Edit/View/Add information'),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return OwnerInfo(idGetter: widget.idGetter,);
                            },
                            )
                            );
                          },
                        ),
                      ),
                      Card(
                        color: Color(0xffF2F4F7),
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
                        color: Color(0xffF2F4F7),
                        child: ListTile(
                          leading: Icon(Icons.person,size: 56.0,color: Colors.black87,),
                          title: Text('Driver'),
                          subtitle: Text('Hired Drivers, Drivers on Duty'),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return OwnerDriverList();
                            },
                            )
                            );
                          },
                        ),
                      ),
                      Card(
                        color: Color(0xffF2F4F7),
                        child: ListTile(
                          leading: Icon(Icons.person_add,size: 56.0,color: Colors.black87,),
                          title: Text('Assistance'),
                          subtitle: Text('Hired Assistants'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OwnerAssistantsList();
                              },
                            ),
                            );
                          }
                         )
                       ),
                      Card(
                        color: Color(0xffF2F4F7),
                        child: ListTile(
                          leading: Icon(Icons.person_pin_circle,size: 56.0,color: Colors.black87,),
                          title: Text('Manager List'),
                          subtitle: Text('Company Manager List'),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OwnerManagerList();
                              },
                            ),
                            );
                          }
                        ),
                      ),
                      Card(
                        color: Color(0xffF2F4F7),
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
                        color: Color(0xffF2F4F7),
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
