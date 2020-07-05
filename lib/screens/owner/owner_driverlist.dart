import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

void main() => runApp(new MaterialApp(home: OwnerDriverList()));

class OwnerDriverList extends StatefulWidget {
  static String id = 'MyList';
  @override
  _OwnerDriverListState createState() => _OwnerDriverListState();
}

int cid = 1001;

class _OwnerDriverListState extends State<OwnerDriverList> {
  List<int> driverLid = [];
  List<String> name = [];
  List<int> aadharNumber = [];
  List<String> licenseNumber = [];
  List<String> licenseExpiry = [];
  List<int> contactNumber = [];

  Future setDriverDetails() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql5021.site4now.net',
        port: 3306,
        user: 'a5e6d1_demo102',
        db: 'db_a5e6d1_demo102',
        password: 'Admin@123#'));
    var result1 = await conn.query(
        "select driver_lid,name, aadhar_number,license_number, license_expiry,contact_number, address_number, address_area, city,state, truck_number,manager_lid from driver where owner_lid=$cid");
    for (var row in result1) {
      driverLid = row[0];
      name = row[1];
      aadharNumber = row[2];
      licenseNumber = row[3];
      licenseExpiry = row[4];
      contactNumber = row[5];

    }
    await conn.close();
  }

  int columns = 7;
  int rows = 3;
  List<List<String>> _makeData() {
    List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('$i:$j');
      }
      output.add(row);
    }
    return output;
  }

  List<String> _makeTitleColumn() => [
    'driver_lid',
    'name',
    'aadhar_number',
    'license_number',
    'license_expiry',
    'contact_number',
  ];

  /// Simple generator for row title
  List<String> _makeTitleRow() => List.generate(rows, (i) => '$i');

  var titleColumn;
  var titleRow;
  var data;
  @override
  void initState() {
    super.initState();
    setDriverDetails();
    titleColumn= _makeTitleColumn();
    titleRow= _makeTitleRow();
    data= _makeData();
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sticky Headers Two-Dimension  Table'),
          backgroundColor: Colors.amber,
        ),
        body: StickyHeadersTable(
          columnsLength: titleColumn.length,
          rowsLength: titleRow.length,
          columnsTitleBuilder: (i) => Text(titleColumn[i]),
          rowsTitleBuilder: (i) => Text(titleRow[i]),
          contentCellBuilder: (i, j) => Text(data[i][j]),
          legendCell: Text('Sticky Legend'),
        ),
      ),
    );
  }
}


