import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:truck/constants.dart';

class OwnerAssistantsList extends StatefulWidget {
  @override
  _OwnerAssistantsListState createState() => _OwnerAssistantsListState();
}

class _OwnerAssistantsListState extends State<OwnerAssistantsList> {

  int cid = 1001;
  bool _isLoading = true;
  List titleColumn;
  List data=[];

  List<int> assistantLid = [];
  List<String> name = [];
  List<int> aadharNumber = [];
  List<int> licenseNumber = [];
  List<int> contactNumber = [];
  List<int> driverLid = [];
  List result2=[];


  List<String> _makeTitleColumn() => [
    'Id',
    'Aadhar',
    'License No.',
    'Mobile No.',
    'Driver Id',
  ];

  int columns = 5;
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
        "select assistant_lid,name,aadhar_number,license_number,contact_number,driver_lid from assistants where owner_lid=$cid");
    finalRes=result1;
    for (var row in result1) {
      assistantLid.add(row[0]);
      name.add(row[1]);
      aadharNumber.add(row[2]);
      licenseNumber.add(row[3]);
      contactNumber.add(row[4]);
      driverLid.add(row[5]);
    }
    titleColumn= _makeTitleColumn();
    result2= getData(columns, rows);
    await conn.close();
  }

  getData(columns,rows){
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        if(j==0){
          data.add(assistantLid);
        }else if(j==1){
          data.add(aadharNumber);
        }else if(j==2){
          data.add(licenseNumber);
        }else if(j==3){
          data.add(contactNumber);
        }else if(j==4){
          data.add(driverLid);
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
            title: Text('Assistant List', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
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
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                :StickyHeadersTable(
              columnsLength: titleColumn.length,
              rowsLength: 2,
              cellDimensions: CellDimensions(contentCellHeight: 50.0,contentCellWidth: 100.0,stickyLegendHeight: 50.0, stickyLegendWidth: 200.0),
              columnsTitleBuilder: (i) => TableCell.stickyColumn(titleColumn[i], textStyle: kDrawerText,),
              rowsTitleBuilder: (i) => TableCell.stickyRow(name[i],textStyle: kDrawerText,),
              contentCellBuilder: (i, j) => TableCell.content('${result2[i][j]}',textStyle: kDrawerText,),
              legendCell: TableCell.legend('Name',textStyle: kDrawerText,),
            ),
          ),
        )
    );
  }
}




///////////////////////////////////////////////////////////////////////////////////

class TableCell extends StatelessWidget {
  TableCell.content(
      this.text, {
        this.textStyle,
        this.cellDimensions = CellDimensions.base,
        this.colorBg = Colors.white,
        this.onTap,
      })  : cellWidth = 200,
        cellHeight = 100,
//        cellMargin=50,
//        cellSpacing=10.0,
        _colorHorizontalBorder = Colors.grey,
        _colorVerticalBorder = Colors.grey,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.legend(
      this.text, {
        this.textStyle,
        this.cellDimensions = CellDimensions.base,
        this.colorBg = Colors.white,
        this.onTap,
      })  : cellWidth = 200,
        cellHeight = 100,
//        cellMargin=50,
//        cellSpacing=10.0,
        _colorHorizontalBorder = Colors.grey,
        _colorVerticalBorder = Colors.grey,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.zero;

  TableCell.stickyRow(
      this.text, {
        this.textStyle,
        this.cellDimensions,
        this.colorBg = Colors.white,
        this.onTap,
      })  : cellWidth = 200,
        cellHeight = 100,
//        cellMargin= 50,
//        cellSpacing=10.0,
        _colorHorizontalBorder = Colors.grey,
        _colorVerticalBorder = Colors.grey,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.stickyColumn(
      this.text, {
        this.textStyle,
        this.cellDimensions = CellDimensions.base,
        this.colorBg = Colors.white,
        this.onTap,
      })  : cellWidth = 200,
        cellHeight = 100,
//        cellMargin=50.0,
//        cellSpacing=10.0,
        _colorHorizontalBorder = Colors.grey,
        _colorVerticalBorder = Colors.grey,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.zero;

  final CellDimensions cellDimensions;

  final String text;
  final Function onTap;

  final double cellWidth;
  final double cellHeight;
//  final double cellMargin;
//  final double cellSpacing;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellHeight,
//        margin: cellMargin,
//        constraints: cellSpacing,
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
//                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  style: textStyle,
                  maxLines: 2,
                  textAlign: _textAlign,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
      ),
    );
  }
}


