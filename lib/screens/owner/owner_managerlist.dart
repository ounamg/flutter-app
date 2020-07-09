import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:truck/button/drawer_snippet.dart';
import 'package:truck/constants.dart';
import 'package:truck/button/drawer_snippet.dart';
class OwnerManagerList extends StatefulWidget {
  @override
  _OwnerManagerListState createState() => _OwnerManagerListState();
}

class _OwnerManagerListState extends State<OwnerManagerList> {

  int cid = 1001;
  bool _isLoading = true;
  List titleColumn;
  List data=[];

  List<int> lid = [];
  List<String> name = [];
  List<int> contactNumber = [];
  List<String> email = [];
  List<int> aadharNumber = [];
  List<int> companyLid=[];
  List companyName = [];
  List result2=[];

  List<String> _makeTitleColumn() => [
    'Id',
    'Mobile No.',
    'Email',
    'Aadhar',
    'Company',
  ];

  int columns = 5;
  int rows = 2;

  var finalRes;
  List newRes = [];

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
        "select lid,name,personal_contact_number,email,aadhar_number,company_lid from manager_personal where owner_id=$cid");
    print(result1);

    for (var row in result1) {
      lid.add(row[0]);
      name.add(row[1]);
      contactNumber.add(row[2]);
      email.add(row[3]);
      aadharNumber.add(row[4]);
      companyLid.add(row[5]);
      print(companyLid);
    }

    for(int i=0; i<companyLid.length; i++) {
      int cl = companyLid[i];
      var result = await conn.query("select company_name from manager_company where company_lid=$cl");
      for (var r in result) {
        companyName.add(r[0]);
      }
    }


    titleColumn= _makeTitleColumn();
    result2= getData(columns, rows);
    await conn.close();
  }

  getData(columns,rows){
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        if(j==0){
          data.add(lid);
        }else if(j==1){
          data.add(contactNumber);
        }else if(j==2){
          data.add(email);
        }else if(j==3){
          data.add(aadharNumber);
        }
        else if(j==4){
          data.add(companyName);
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
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        home: Scaffold(
          drawer: DrawerSnippet(),
          appBar: AppBar(
            title: Text('Manager List', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
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
//              cellDimensions: CellDimensions(contentCellHeight: 50.0,contentCellWidth: 100.0,stickyLegendHeight: 50.0, stickyLegendWidth: 200.0),
              columnsTitleBuilder: (i) => TableCell.stickyColumn(titleColumn[i], textStyle: textTheme.button.copyWith(fontSize: 16.5)),
              rowsTitleBuilder: (i) => TableCell.stickyRow(name[i],textStyle: textTheme.button.copyWith(fontSize: 16.5)),
              contentCellBuilder: (i, j) => TableCell.content('${result2[i][j]}',textStyle: textTheme.button.copyWith(fontSize: 16.5)),
              legendCell: TableCell.legend('Name',textStyle: textTheme.button.copyWith(fontSize: 16.5)),
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
      })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.legend(
      this.text, {
        this.textStyle,
        this.cellDimensions = CellDimensions.base,
        this.colorBg = Colors.amber,
        this.onTap,
      })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  TableCell.stickyRow(
      this.text, {
        this.textStyle,
        this.cellDimensions = CellDimensions.base,
        this.colorBg = Colors.white,
        this.onTap,
      })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.stickyColumn(
      this.text, {
        this.textStyle,
        this.cellDimensions = CellDimensions.base,
        this.colorBg = Colors.white,
        this.onTap,
      })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  final CellDimensions cellDimensions;

  final String text;
  final Function onTap;

  final double cellWidth;
  final double cellHeight;

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
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 2.0),
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
//class TableCell extends StatelessWidget {
//  TableCell.content(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 200,
//        cellHeight = 100,
////        cellMargin=50,
////        cellSpacing=10.0,
//        _colorHorizontalBorder = Colors.grey,
//        _colorVerticalBorder = Colors.grey,
//        _textAlign = TextAlign.center,
//        _padding = EdgeInsets.zero;
//
//  TableCell.legend(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 200,
//        cellHeight = 100,
////        cellMargin=50,
////        cellSpacing=10.0,
//        _colorHorizontalBorder = Colors.grey,
//        _colorVerticalBorder = Colors.grey,
//        _textAlign = TextAlign.start,
//        _padding = EdgeInsets.zero;
//
//  TableCell.stickyRow(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 200,
//        cellHeight = 100,
////        cellMargin= 50,
////        cellSpacing=10.0,
//        _colorHorizontalBorder = Colors.grey,
//        _colorVerticalBorder = Colors.grey,
//        _textAlign = TextAlign.center,
//        _padding = EdgeInsets.zero;
//
//  TableCell.stickyColumn(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 200,
//        cellHeight = 100,
////        cellMargin=50.0,
////        cellSpacing=10.0,
//        _colorHorizontalBorder = Colors.grey,
//        _colorVerticalBorder = Colors.grey,
//        _textAlign = TextAlign.start,
//        _padding = EdgeInsets.zero;
//
//  final CellDimensions cellDimensions;
//
//  final String text;
//  final Function onTap;
//
//  final double cellWidth;
//  final double cellHeight;
////  final double cellMargin;
////  final double cellSpacing;
//
//  final Color colorBg;
//  final Color _colorHorizontalBorder;
//  final Color _colorVerticalBorder;
//
//  final TextAlign _textAlign;
//  final EdgeInsets _padding;
//
//  final TextStyle textStyle;
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: onTap,
//      child: Container(
//        width: cellWidth,
//        height: cellHeight,
////        margin: cellMargin,
////        constraints: cellSpacing,
//        padding: _padding,
//        child: Column(
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                alignment: Alignment.center,
////                padding: EdgeInsets.symmetric(horizontal: 2.0),
//                child: Text(
//                  text,
//                  style: textStyle,
//                  maxLines: 2,
//                  textAlign: _textAlign,
//                ),
//              ),
//            ),
//            Container(
//              width: double.infinity,
//              height: 1.1,
//              color: _colorVerticalBorder,
//            ),
//          ],
//        ),
//        decoration: BoxDecoration(
//            border: Border(
//              left: BorderSide(color: _colorHorizontalBorder),
//              right: BorderSide(color: _colorHorizontalBorder),
//            ),
//            color: colorBg),
//      ),
//    );
//  }
//}

//class TableCell extends StatelessWidget {
//  TableCell.content(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 400.0,
//        cellHeight = 100.0,
//        _colorHorizontalBorder = Colors.amber,
//        _colorVerticalBorder = Colors.black38,
//        _textAlign = TextAlign.center,
//        _padding = EdgeInsets.zero;
//
//  TableCell.legend(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.amber,
//        this.onTap,
//      })  : cellWidth = 400.0,
//        cellHeight = 100.0,
//        _colorHorizontalBorder = Colors.white,
//        _colorVerticalBorder = Colors.amber,
//        _textAlign = TextAlign.start,
//        _padding = EdgeInsets.only(left: 24.0);
//
//  TableCell.stickyRow(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 400.0,
//        cellHeight = 100.0,
//        _colorHorizontalBorder = Colors.white,
//        _colorVerticalBorder = Colors.amber,
//        _textAlign = TextAlign.center,
//        _padding = EdgeInsets.zero;
//
//  TableCell.stickyColumn(
//      this.text, {
//        this.textStyle,
//        this.cellDimensions = CellDimensions.base,
//        this.colorBg = Colors.white,
//        this.onTap,
//      })  : cellWidth = 400.0,
//        cellHeight = 100.0,
//        _colorHorizontalBorder = Colors.amber,
//        _colorVerticalBorder = Colors.black38,
//        _textAlign = TextAlign.start,
//        _padding = EdgeInsets.only(left: 24.0);
//
//  final CellDimensions cellDimensions;
//
//  final String text;
//  final Function onTap;
//
//  final double cellWidth;
//  final double cellHeight;
//
//  final Color colorBg;
//  final Color _colorHorizontalBorder;
//  final Color _colorVerticalBorder;
//
//  final TextAlign _textAlign;
//  final EdgeInsets _padding;
//
//  final TextStyle textStyle;
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: onTap,
//      child: Container(
//        width: 200.0,
//        height: 50.0,
//        padding: _padding,
//        child: Column(
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                alignment: Alignment.center,
//                padding: EdgeInsets.symmetric(horizontal: 2.0),
//                child: Text(
//                  text,
//                  style: textStyle,
//                  maxLines: 2,
//                  textAlign: _textAlign,
//                ),
//              ),
//            ),
//            Container(
//              width: 150.0,
//              height: 1.1,
//              color: _colorVerticalBorder,
//            ),
//          ],
//        ),
//        decoration: BoxDecoration(
//            border: Border(
//              left: BorderSide(color: _colorHorizontalBorder),
//              right: BorderSide(color: _colorHorizontalBorder),
//            ),
//            color: colorBg),
//      ),
//    );
//  }
//}


