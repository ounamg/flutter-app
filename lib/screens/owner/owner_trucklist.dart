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
  int value = 2;

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }
  String truck_number = 'RJ45 CN 6969';
  String driver_name = 'Harshal Chandaria';
  String veh_class = 'Loader';
  String manager_inch = 'Sameep Tejani';
  String current_city = 'Jhunjhunu';

  @override
  Widget build(BuildContext context) {
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
                Text('Truck No. :- $truck_number'),
//                Spacer(flex: 1,),
                Text('Driver :- $driver_name'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
//              alignment: WrapAlignment.start,
//              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                Text('Vehicle Class :- $veh_class'),
                Text('Manager :- $manager_inch'),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: <Widget>[
              Text('City:- $current_city')
            ],
          )
        ],
      )
    );
  }
}