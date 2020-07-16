import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:search_widget/search_widget.dart';
import 'package:truck/button/drawer_snippet.dart';
import 'package:truck/constants.dart';
import 'package:truck/button/dropdown_statecity.dart';
import 'package:truck/button/dropdown_truckclass.dart';

class ManagerTruckList extends StatefulWidget {
  @override
  _ManagerTruckListState createState() => _ManagerTruckListState();
}

class _ManagerTruckListState extends State<ManagerTruckList> {

  int cid = 2001;
  List<String> truckNum = [];
  List<String> vehicleClass = [];
  List<String> driverName = [];
  List<int> driverLid = [];
  List<String> ownerName = [];
  List<int> ownerLid = [];
  List<String> ccity=[];
  List<String> sstate=[];
  var resultFinal;
  int res1;
  bool _isLoading = true;
//  String state;
//  String city;
  bool newAppliedState = false;
  bool newAppliedCity = false;
  String query;
  String query1;
  bool isLoading = true;
  String selectedMode;

  Future setTruckDetails(query1,query) async {
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
    var result1 =
    await conn.query(query1);
    var result2 = await conn.query(query);
    resultFinal = result2;
    for (var ro in result1) {
      res1 = ro[0];

    }
    print('ab mei yaha hu');
    for (var row in result2) {
      truckNum.add(row[0]);
      vehicleClass.add(row[1]);
      driverName.add(row[2]);
      driverLid.add(row[3]);
      ownerName.add(row[4]);
      ownerLid.add(row[5]);
      ccity.add(row[6]);
      sstate.add(row[7]);
      setState(() {
        _isLoading = false;
        isLoading = false;
      });
    }
    await conn.close();
  }
  // Add Truck
  String truckNumber;
  String vehicleClass1;


  bool _show = true;
  String newState;
  String newCity;
  String _selectedItem;

  void stateName(String state,bool appliedState){
    newState = state;
    newAppliedState= appliedState;
    print(newState);
    print(newAppliedState);
  }
  void cityName(String city,bool appliedCity){
    newCity = city;
    newAppliedCity= appliedCity;
    print(newAppliedCity);
  }

  selectFilter(){
    print('Reached here');
    if (newAppliedState == true && newAppliedCity == false) {
      truckNum.removeRange(0, truckNum.length);
      vehicleClass.removeRange(0, vehicleClass.length);
      driverName.removeRange(0, driverName.length);
      driverLid.removeRange(0, driverLid.length);
      ownerName.removeRange(0, ownerName.length);
      ownerLid.removeRange(0, ownerLid.length);
      ccity.removeRange(0, ccity.length);
      sstate.removeRange(0, sstate.length);
      res1=0;
      setTruckDetails("select count(*) from trucks where state='$newState' AND manager_lid=2001", "select truck_number, vehicle_class, driver_name, driver_lid, owner_name, owner_lid, city, state from trucks where state = '$newState' AND manager_lid=2001");
    }
    else if (newAppliedState == true && newAppliedCity == true) {
      truckNum.removeRange(0, truckNum.length);
      vehicleClass.removeRange(0, vehicleClass.length);
      driverName.removeRange(0, driverName.length);
      driverLid.removeRange(0, driverLid.length);
      ownerName.removeRange(0, ownerName.length);
      ownerLid.removeRange(0, ownerLid.length);
      ccity.removeRange(0, ccity.length);
      sstate.removeRange(0, sstate.length);
      res1=0;
      setTruckDetails("select count(*) from trucks where state='$newState' AND city = '$newCity'AND manager_lid=2001","select truck_number, vehicle_class,driver_name,driver_lid,owner_name,owner_lid,city,state from trucks where state='$newState' AND city = '$newCity' AND manager_lid= '$cid'");
    }
    else{
      print('its here');
      setTruckDetails("select count(*) from trucks where manager_lid=2001","select truck_number, vehicle_class,driver_name,driver_lid,owner_name,owner_lid,city,state from trucks where manager_lid = $cid");
    }
  }

  @override
  void initState() {
    super.initState();
    selectFilter();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  void table1(String tableName){
    selectedMode = tableName;
  }
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        drawer: DrawerSnippet(),
        floatingActionButton: FloatingActionButton(
          elevation: 2.0,
          child: Icon(Icons.add),
          backgroundColor: Color(0xff0C1338),
          onPressed: () {showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20.0)), //this right here
                  child: Container(
//                    height: 900,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Add Truck', style: kDrawerText,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 4.0),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: idController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                truckNumber = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(hintText: 'RJ45CF9999'),

                            ),
                          ),
                          SizedBox(height: 20.0,),
                          TruckClassDropDown(),
                          SizedBox(
//                            width: 320.0,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: const Color(0xFF1BC0C5),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });} ,
        ),
        appBar: AppBar(
          title: Text(
            'Trucks',
            style: kAppBarStyle,
          ),
          actions: <Widget>[
            FlatButton(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.zero,
                topRight: Radius.zero),
          ),
          backgroundColor: Color(0xff0C1338),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
                child: Column(children: <Widget>[
                  if (_show)
                    SearchWidget<String>(
                      dataList: truckNum,
                      hideSearchBoxWhenItemSelected: false,
                      listContainerHeight:
                      MediaQuery.of(context).size.height / 4,
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
                      selectedItemBuilder:
                          (selectedItem, deleteSelectedItem) {
                        return SelectedItemWidget(
                            selectedItem, deleteSelectedItem);
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
                  StateCityDD(stateName,cityName),
                  FlatButton(child: Text('Filter'),onPressed: () {
                    setState(() {
                      selectFilter();
                    });
                  },),
                  SizedBox(
                    height: 10.0,
                  ),
//                      selectFilter()
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: res1,
                      itemBuilder: (context, index) => _buildRow(index)),
                ]))));
  }

  _buildRow(int index) {
    return Material(
      child: Card(
          elevation: 2.0,
          color: Colors.lightGreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.local_shipping),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
//                  alignment: WrapAlignment.start,
                    children: <Widget>[
//                    Text('${index.toString()}  '),
                      Text('Truck No. :- ${truckNum[index]}'),
                      Text('Driver Name :- ${driverName[index]}'),
                      Text('Owner Name:- ${ownerName[index]} (Id: ${ownerLid[index]})'),
//                    Text('Manager Id:- '),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Wrap(
                  children: <Widget>[
                    Text('Vehicle Class :- ${vehicleClass[index]}'),
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                children: <Widget>[Text('City:- ')],
              )
            ],
          )),
    );
  }
}

class SelectedItemWidget extends StatefulWidget {
  SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);
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

  String ownerName;

  int ownerLid;

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
    var result2 = await conn.query(
        "select truck_number, vehicle_class,driver_name,driver_lid,owner_name,owner_lid from trucks where truck_number='${widget.selectedItem}'");
    resultFinal = result2;
//    for(var ro in result1){
//      res1= ro[0];
//    }
    for (var row in result2) {
      truckNum = (row[0]);
      vehicleClass = (row[1]);
      driverName = (row[2]);
      driverLid = (row[3]);
      ownerName = (row[4]);
      ownerLid = (row[5]);
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
            : Column(
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
                        Text('Truck No. :- $truckNum'),
                        Text('Driver Name :- $driverName'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Wrap(
                      children: <Widget>[
                        Text('Vehicle Class :- $vehicleClass'),
                        Text('Owner Name:- $ownerName'),
                        Text('Owner Id:- $ownerLid'),
                      ],
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: <Widget>[Text('City:- ')],
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
        ));
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