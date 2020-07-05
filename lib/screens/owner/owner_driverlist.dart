import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class OwnerDriverList extends StatefulWidget {
//  static String id = 'MyList';
  @override
  _OwnerDriverListState createState() => _OwnerDriverListState();
}

class _OwnerDriverListState extends State<OwnerDriverList> {

  int cid = 1001;
  bool _isLoading = true;
  List titleColumn;
  List data=[];

  List<int> driverLid = [];
  List<String> name = [];
  List<int> aadharNumber = [];
  List<int> licenseNumber = [];
  List<int> contactNumber = [];
  List result2=[];


  List<String> _makeTitleColumn() => [
    'driver_lid',
    'aadhar_number',
    'license_number',
    'contact_number',
  ];

  int columns = 4;
  int rows = 2;

  var finalRes;
  Future setDriverDetails() async {
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
    var result1 = await conn.query(
        "select driver_lid,name, aadhar_number,license_number,contact_number from drivers where owner_lid=$cid");
    finalRes=result1;
    for (var row in result1) {
      driverLid.add(row[0]);
      print(row[0]);
      name.add(row[1]);
      aadharNumber.add(row[2]);
      licenseNumber.add(row[3]);
      contactNumber.add(row[4]);
    }
    titleColumn= _makeTitleColumn();
    result2= getData(columns, rows);
    await conn.close();
  }

  getData(columns,rows){
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        if(j==0){
          data.add(driverLid);
        }else if(j==1){
          data.add(aadharNumber);
        }else if(j==2){
            data.add(licenseNumber);
          }else if(j==3){
          data.add(contactNumber);
        }
        }
      }setState(() {
      _isLoading = false;
    });
    return data;
    }

  @override
  void initState() {
    super.initState();
    setDriverDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Driver List'),
            backgroundColor: Colors.amber,
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
                :StickyHeadersTable(
              columnsLength: titleColumn.length,
              rowsLength: 2,
              columnsTitleBuilder: (i) => Text(titleColumn[i]),
              rowsTitleBuilder: (i) => Text(name[i]),
              contentCellBuilder: (i, j) => Text('${result2[i][j]}'),
              legendCell: Text('Name'),
            ),
          ),
        )
    );
  }
}


