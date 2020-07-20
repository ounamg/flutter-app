import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/button/drawer_snippet.dart';
import 'package:truck/constants.dart';
class ClientHome extends StatefulWidget {
  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset('images/bg3.jpg',height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomLeft,),
        ),
      Scaffold(
        resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
        drawer: DrawerSnippet(),
        appBar: AppBar(
          title: Text('Welcome Ounam', style: TextStyle(fontWeight: FontWeight.w600,fontStyle: FontStyle.italic, fontSize: 20.0),),
          actions: <Widget>[FlatButton(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);})],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topLeft: Radius.zero,topRight: Radius.zero),
          ),
          backgroundColor: Color(0xff0C1338),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 20.0,top: 30.0),
                child: Text('Preset Consignments', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 30.0,color: Colors.white),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 8.0),child: _buildRow(index),)),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 20.0,top: 30.0),
                child: Text('Current Loads', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 30.0,color: Colors.white),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 200.0,
                child: ListView.builder(
//                  padding: EdgeInsets.only(left: 8.0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 8.0),child: _buildThat(index),)),
              ),
            ],
          ),
        ),
      ),
    ]
    );
  }
  _buildRow(index) {
    return Card(
      child: Container(height: 20.0,width: 300.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0,),
          Container(width:280.0,child: Text('To: Jaipasdasdasdur, Rajasthasdasdasdasdan',maxLines: 2,style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
//          Container(width:280.0,child: Text('To: Rajasthan',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
          SizedBox(height: 10.0,),
          Container(width:280.0,child: Text('From: Guwahati, Assam',maxLines: 2,style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
//          Container(width:280.0,child: Text('From: Assam',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
          SizedBox(height: 10.0,),
          Container(width:280.0,child: Text('Loading Date: 28-02-11',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
          SizedBox(height: 20.0,),
          Container(alignment: Alignment.bottomCenter,child: Icon(Icons.local_shipping))
        ],
      ),),
          color: Colors.white.withOpacity(0.7),
    );
  }
  _buildThat(index) {
    return Card(
      child: Container(height: 20.0,width: 300.0, padding: EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            SizedBox(height: 10.0,),
//            Container(width:280.0,child: Text('To: Jaipas dasdasdur, Rajasthasdasdasdasdan',maxLines: 1,style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),)),
//          Container(width:280.0,child: Text('To: Rajasthan',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
            ListTile(leading: Text('To'),title: Text('Jaipur'),subtitle: Text('Rajasthan'),),

//            SizedBox(height: 10.0,),
            ListTile(leading: Text('From'),title: Text('Guwahati'),subtitle: Text('Assam'),),
//            Container(width:280.0,child: Text('From: Guwahati, Assam',maxLines: 2,style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
//          Container(width:280.0,child: Text('From: Assam',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
            SizedBox(height: 10.0,),
            Container(width:280.0,child: Text('Loading Date: 28-02-11',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
            Container(width:280.0,child: Text('Truck No.- RJ45CC6969',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
            Container(width:280.0,child: Text('Unload Date: 30-02-11',style: TextStyle(fontSize: 20.0),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0),border: Border.all(width: 1.0,color: Colors.blueGrey)),),
//            SizedBox(height: 20.0,),
//            Container(alignment: Alignment.bottomCenter,child: Icon(Icons.local_shipping))
          ],
        ),),
      color: Colors.white.withOpacity(0.7),
    );
  }
}

