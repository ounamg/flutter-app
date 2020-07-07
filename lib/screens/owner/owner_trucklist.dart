import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:search_widget/search_widget.dart';
import 'package:truck/constants.dart';

//void main() => runApp(new MaterialApp(home: OwnerTruckList()));

class OwnerTruckList extends StatefulWidget {
//  static String id = 'MyList';
  @override
  _OwnerTruckListState createState() => _OwnerTruckListState();
}

class _OwnerTruckListState extends State<OwnerTruckList> {
//  final selected = SelectedItemWidget();
  int cid=1001;
  List<String> truckNum =[];
  List<String> vehicleClass =[];
  List<String> driverName =[];
  List<int> driverLid =[];
  List<String> managerName =[];
  List<int> managerLid =[];
  var resultFinal;
  int res1;
  bool _isLoading = true;


  Future setTruckDetails() async {

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
    var result1 = await conn.query("select count(*) from trucks where owner_lid=$cid");
    var result2 = await conn.query("select truck_number, vehicle_class,driver_name,driver_lid,manager_name,manager_lid from trucks where owner_lid=$cid");
    resultFinal= result2;
    for(var ro in result1){
      res1= ro[0];
    }
    for(var row in result2) {
      truckNum.add(row[0]);
      vehicleClass.add(row[1]);
      driverName.add(row[2]);
      driverLid.add(row[3]);
      managerName.add(row[4]);
      managerLid.add(row[5]);
      setState(() {
        _isLoading = false;
      });

    }
//    print(res1);
//    print(truckNum);
//    print(managerLid);
    await conn.close();

//    print(truckNum);
  }

  bool _show = true;

  String _selectedItem;

  @override
  void initState() {
    super.initState();
    setTruckDetails();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: ClipRRect(
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
        ),
        appBar: AppBar(
          title: Text('Trucks', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
          actions: <Widget>[FlatButton(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);})],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topLeft: Radius.zero,topRight: Radius.zero),
          ),
          backgroundColor: Color(0xff0C1338),
        ),
        body:
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )

              :
          SingleChildScrollView(

            child: Column(
              children: <Widget>[
                if(_show)
                  SearchWidget<String>(
                    dataList: truckNum,
                    hideSearchBoxWhenItemSelected: false,
                    listContainerHeight: MediaQuery
                        .of(context)
                        .size
                        .height / 4,
                    queryBuilder: (query, list) {
                      return list
                          .where((item) => item
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    },
                    popupListItemBuilder: (item) {
                      return PopupListItemWidget(item);
                    },
                    selectedItemBuilder: (selectedItem,deleteSelectedItem){
                      return SelectedItemWidget(selectedItem,deleteSelectedItem);
                    },
                    // widget customization
                    noItemsFoundWidget: NoItemsFound(),
                    textFieldBuilder: (controller, focusNode) {
                      return MyTextField(controller, focusNode);
                    },
                    onItemSelected: (item) {
                      setState(() {
                        _selectedItem = item;
                      });
                    },
                  ),

                SizedBox(height: 20.0,),
//        Text(
//          "${_selectedItem != null ? _selectedItem : ""
//              "No item selected"}",
//        ),
//               _selectedItem != null ? _selectedItem : {Text("No selected")},
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: res1,
                    itemBuilder: (context, index) => _buildRow(index))
        ]
    )
    )
    )
    );
//              ],
//            ),
//          ),
//        )
//    );
  }

  _buildRow(int index) {
    return Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Text('${index.toString()}  '),
                  Text('Truck No. :- ${truckNum[index]}'),
//                Spacer(flex: 1,),
//                    Text('Driver Id :- ${driverLid[index]}'),
                  Text('Driver Name :- ${driverName[index]}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Wrap(
//              alignment: WrapAlignment.start,
//              crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Text('Vehicle Class :- ${vehicleClass[index]}'),
                  Text('Manager Name:- ${managerName[index]}'),
                  Text('Manager Id:- ${managerLid[index]}'),
                ],
              ),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: <Widget>[
                Text('City:- ')
              ],
            )
          ],
        )
    );

  }
}






/////////////////////////////////////////////
//class Printer{
//  Printer(this.number);
//  final String number;
//}
class SelectedItemWidget extends StatefulWidget {
  SelectedItemWidget(this.selectedItem,this.deleteSelectedItem);
  final String selectedItem;
  final VoidCallback deleteSelectedItem;


  @override
  _SelectedItemWidgetState createState() => _SelectedItemWidgetState();
}

class _SelectedItemWidgetState extends State<SelectedItemWidget> {



  String truckNum;

  String vehicleClass;

  String driverName;

  int driverLid;

  String managerName;

  int managerLid;

  var resultFinal;
  bool _isLoading = true;

  int res1;

  Future setTruckDetails() async {

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
//    var result1 = await conn.query("select count(*) from trucks where owner_lid=$cid");
    var result2 = await conn.query("select truck_number, vehicle_class,driver_name,driver_lid,manager_name,manager_lid from trucks where truck_number='${widget.selectedItem}'");
    resultFinal= result2;
//    for(var ro in result1){
//      res1= ro[0];
//    }
    for(var row in result2) {
      truckNum=(row[0]);
      vehicleClass=(row[1]);
      driverName=(row[2]);
      driverLid=(row[3]);
      managerName=(row[4]);
      managerLid=(row[5]);
      setState(() {
        _isLoading = false;
      });
      print(truckNum);
    }
//    print(res1);
//    print(truckNum);
//    print(managerLid);
    await conn.close();

//    print(truckNum);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTruckDetails();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setTruckDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.grey,
//        height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    color: Colors.white,
    ),
    child: _isLoading
    ? Center(
    child: CircularProgressIndicator(),
    )
        :

    Column(
      children: <Widget>[
        Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: <Widget>[
//                  Text('${index.toString()}  '),
                      Text('Truck No. :- $truckNum'),
//                Spacer(flex: 1,),
//                    Text('Driver Id :- ${driverLid[index]}'),
                      Text('Driver Name :- $driverName'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Wrap(
//              alignment: WrapAlignment.start,
//              crossAxisAlignment: WrapCrossAlignment.start,
                    children: <Widget>[
                      Text('Vehicle Class :- $vehicleClass'),
                      Text('Manager Name:- $managerName'),
                      Text('Manager Id:- $managerLid'),
                    ],
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text('City:- ')
                  ],
                )
              ],

            ),
        ),
        IconButton(
          icon: Icon(Icons.refresh, size: 22),
            color: Colors.grey[700],
            onPressed: widget.deleteSelectedItem,
        )
      ],
    )
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
//      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}