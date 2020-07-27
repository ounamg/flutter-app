import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:truck/screens/client/client_addConsignment.dart';
import 'package:truck/screens/client/client_home.dart';
import 'package:truck/screens/client/client_info.dart';
import 'package:truck/screens/landing_page.dart';
import 'package:truck/screens/login_page.dart';
import 'package:truck/screens/signup/sign_up.dart';
import 'package:truck/screens/signup/signup_manager.dart';
import 'package:truck/screens/signup/signup_owner.dart';
class ClientMain extends StatefulWidget {
  final int idGetter;
  ClientMain({Key key,@required this.idGetter}): super(key: key);
  @override
  _ClientMainState createState() => _ClientMainState();
}

class _ClientMainState extends State<ClientMain> {
  int _page = 0;
  PageController pageController = PageController(
    initialPage: 2,
    keepPage: true,
  );
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  int bottomSelectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
    Image.asset('images/bg3.jpg',height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fill,),
      Scaffold(
        backgroundColor: Colors.transparent,
//      backgroundColor: Colors.white,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 2,
            height: 50.0,
            items: <Widget>[
              Icon(Icons.add, size: 40,color: Colors.white,),
              Icon(Icons.list, size: 40,color: Colors.white),
              Icon(Icons.home, size: 40,color: Colors.white),
              Icon(Icons.chat_bubble, size: 40,color: Colors.white),
              Icon(Icons.perm_identity, size: 40,color: Colors.white),
            ],
            color: Color(0xff0C1338),
//          color: Colors.transparent,
//            buttonBackgroundColor: Color(0xff0C1338),
//          buttonBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                bottomTapped(index);
              });
            },
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              pageChanged(index);
            },
            children: <Widget>[
              ClientAdd(),
              SignUp(),
              ClientHome(),
              OwnerSignUp(),
              ClientInfo(idGetter: 3001)
            ],
          )),
    ]
    );
  }
}
