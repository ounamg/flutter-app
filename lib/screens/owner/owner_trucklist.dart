import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() => runApp(new MaterialApp(home: OwnerTruckList()));

class OwnerTruckList extends StatefulWidget {
  static String id = 'MyList';
  @override
  _OwnerTruckListState createState() => _OwnerTruckListState();
}

class _OwnerTruckListState extends State<OwnerTruckList> {

  int cid=1001;
  List<String> truckNum =[];
  List<String> vehicleClass =[];
  List<String> driverName =[];
  List<int> driverLid =[];
  List<String> managerName =[];
  List<int> managerLid =[];
  var resultFinal;
  var res1;

  Future setTruckDetails() async {

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'logistic',
        password: 'Ati@radeon1'));
    var result1 = await conn.query("select count(*) from trucks group by owner_lid=$cid");
    var result2 = await conn.query("select truck_number, vehicle_class,driver_name,driver_lid,manager_name,manager_lid from trucks where owner_lid=$cid");
    res1= result1;
    resultFinal= result2;
//    for(var row in result2) {
//      truckNum.add(row[0]);
//      vehicleClass.add(row[1]);
//      driverName.add(row[2]);
//      driverLid.add(row[3]);
//      managerName.add(row[4]);
//      managerLid.add(row[5]);
//    }
//    print(truckNum);
//    print(managerLid);
    await conn.close();
  }


  int value = 2;

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    setTruckDetails();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Trucks'),
      ),
      body: ListView.builder(
          itemCount: this.value,
          itemBuilder: (context, index) => this._buildRow(index)),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }



  _buildRow(int index) {
      return Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
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