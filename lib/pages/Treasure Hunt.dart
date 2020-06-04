import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_app/models/appBars.dart';
import 'package:test_app/models/bottomNavigation.dart';
import 'package:test_app/models/fab.dart';
import 'package:test_app/models/util.dart';
import 'package:test_app/pages/Resetpassword.dart';
import 'package:test_app/pages/detail_snakeladder.dart';
import 'package:test_app/pages/detail_treasurehunt.dart';

class Homepage2 extends StatefulWidget {

  @override
  _MyLoginPageState2 createState() => _MyLoginPageState2();
}

class _MyLoginPageState2 extends State<Homepage2> {
  final bottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, left: 20, bottom: 15),
              child: Text(
                'ภารกิจ',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.TextSubHeader),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked.png'),
                  Text(
                    'STAGE 1',
                    style: TextStyle(color: CustomColors.TextGrey),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Detailgame2())),
//                    width: 180,
                    child: Text(
                      'แสกน QR Code จุดที่หนึ่ง',
                      style: TextStyle(
                          color: CustomColors.TextGrey,
                          //fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
//                  InkWell(
//                    onTap: () => print("Container pressed"),
//                  ),
                  Image.asset('assets/images/flag.png'),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [CustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/checked.png'),
                    Text(
                      'STAGE 2',
                      style: TextStyle(color: CustomColors.TextGrey),
                    ),
                    Container(
                      width: 180,
                      child: Text(
                        'แสกน QR Code จุดที่สอง',
                        style: TextStyle(
                            color: CustomColors.TextGrey,
                            //fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Image.asset('assets/images/flag.png'),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.015, 0.015],
                    colors: [CustomColors.GreenIcon, Colors.white],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.GreyBorder,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
              ),
              secondaryActions: <Widget>[
                SlideAction(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CustomColors.TrashRedBackground),
                      child: Image.asset('assets/images/trash.png'),
                    ),
                  ),
                  onTap: () => print('Delete'),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked.png'),
                  Text(
                    'STAGE 3',
                    style: TextStyle(color: CustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      'แสกน QR Code จุดที่สาม',
                      style: TextStyle(
                          color: CustomColors.TextGrey,
                          //fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Image.asset('assets/images/flag.png'),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [CustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  Text(
                    'STAGE 4',
                    style: TextStyle(color: CustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      'แสกน QR Code จุดที่สี่',
                      style: TextStyle(
                          color: CustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/flag.png'),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [CustomColors.YellowIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  Text(
                    'FINISH',
                    style: TextStyle(color: CustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      'รับของรางวัล',
                      style: TextStyle(
                          color: CustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/finishing.png'),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [CustomColors.PurpleIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
      BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }
}
