import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/notifications.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/product_card.dart';
import 'package:test_app/pages/gps_nearby.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/home_firebase.dart';
import 'package:test_app/pages/product_list.dart';
import 'package:test_app/pages/upload_images.dart';
import 'package:test_app/utils/badge.dart';
import 'package:test_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class Nearby extends StatefulWidget {
  final FirebaseUser user;

//  final DBref = FirebaseDatabase.instance.reference();

  Nearby(this.user, {Key key}) : super(key: key);

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<Nearby>
    with SingleTickerProviderStateMixin {
  final DBref = FirebaseDatabase.instance.reference();
  TabController tabController;
  TextEditingController controller = new TextEditingController();

//  List<String> tabs = ["ใกล้คุณ", "เป็นที่นิยม"];
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle =
      new Text('Gozione', style: TextStyle(color: Colors.white));
  String filter = "";

  FirebaseUser get user => null;

  final List<Posts> postsList = [];
  List<Posts> _filteredList = [];

//  @override
//  void dispose() {
//    controller.dispose();
//    super.dispose();
//  }
  @override
  void initState() {
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Member");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
//      print(KEYS);
      postsList.clear();
      for (var individualKey in KEYS) {
        Posts posts = new Posts(
          DATA[individualKey]['name'],
          DATA[individualKey]['description'],
          DATA[individualKey]['images1'],
          DATA[individualKey]['images2'],
          DATA[individualKey]['images3'],
          DATA[individualKey]['images4'],
          DATA[individualKey]['images5'],
          DATA[individualKey]['dayoff'],
          DATA[individualKey]['location_lat'],
          DATA[individualKey]['location_long'],
          DATA[individualKey]['working_start'],
          DATA[individualKey]['working_end'],
          DATA[individualKey]['phone'],
        );
        postsList.add(posts);
        print(postsList.length);
        print(postsList.toString());
      }
//      return postsList;
//      postsList = _filteredList;
//      print(_filteredList.length);
    });
  }

//  Future loaddata() async {
//    DatabaseReference postsRef =
//        FirebaseDatabase.instance.reference().child("Member");
//    postsRef.once().then((DataSnapshot snap) {
//      var KEYS = snap.value.keys;
////      print(KEYS);
//      var DATA = snap.value;
//      postsList.clear();
//      for (var individualKey in KEYS) {
//        Posts posts = new Posts(
//          DATA[individualKey]['name'],
//          DATA[individualKey]['description'],
//          DATA[individualKey]['images1'],
//          DATA[individualKey]['images2'],
//          DATA[individualKey]['images3'],
//          DATA[individualKey]['images4'],
//          DATA[individualKey]['images5'],
//          DATA[individualKey]['dayoff'],
//          DATA[individualKey]['location_lat'],
//          DATA[individualKey]['location_long'],
//          DATA[individualKey]['working_start'],
//          DATA[individualKey]['working_end'],
//          DATA[individualKey]['phone'],
//        );
//        postsList.add(posts);
////        print(_filteredList.length);
//      }
//      return postsList;
////      postsList = _filteredList;
////      print(_filteredList.length);
//    });
////
////    setState(() {
////      postsList = _filteredList;
//////      print(_filteredList.length);
////    });
//  }

  @override
  Widget build(BuildContext context) {
    final list = Expanded(
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(postlist: postsList[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.65,
        ),
        itemCount: postsList.length,
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(240, 101, 31, 1),
          title: appBarTitle,
          actions: <Widget>[
//            new IconButton(
//              icon: actionIcon,
//              onPressed: () {
//                setState(() {
//                  if (this.actionIcon.icon == Icons.search) {
//                    this.actionIcon = new Icon(Icons.close);
//                    this.appBarTitle = new TextField(
//                      style: new TextStyle(
//                        color: Colors.white,
//                      ),
//                      decoration: new InputDecoration(
//                          prefixIcon:
//                              new Icon(Icons.search, color: Colors.white),
//                          hintText: "Search...",
//                          hintStyle: new TextStyle(color: Colors.white)),
//                      controller: controller,
//                    );
//                  } else {
//                    this.actionIcon = new Icon(Icons.search);
//                    this.appBarTitle = new Text('Gozione',
//                        style: TextStyle(color: Colors.white));
//                    _filteredList = postsList;
////                    controller.clear();
//                  }
//                });
//                if (controller.text.isNotEmpty) {
//                  List<Posts> tmpList = new List<Posts>();
//                  for (int i = 0; i < postsList.length; i++) {
//                    if (postsList[i]
//                        .name
//                        .toLowerCase()
//                        .contains(controller.text.toLowerCase())) {
//                      tmpList.add(postsList[i]);
//                    }
//                  }
//                  _filteredList = tmpList;
//                } else {
//                  _filteredList = postsList;
//                }
//                print(_filteredList.length);
//              },
//            ),
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications,
                size: 22.0,
              ),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return Notifications();
                    },
                  ),
                );
              },
            ),
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 0.0),
//        color: Color.fromRGBO(195, 232, 231,1),

        child: Column(
          children: <Widget>[
//            tabBar,
//            FutureBuilder(
//                future: loaddata(),
//                builder: (BuildContext context, AsyncSnapshot snapshot) {
//                  if (_filteredList.length > 0) {
//                    return Column(children: <Widget>[list]);
//                  } else {
//                    return CircularProgressIndicator();
//                  }
//                }),
            list,
//            RaisedButton(
//              child: Text("Write Data"),
//              onPressed: () {
//                DBref.child('Member').child('A005').set({
//                  "dayoff":"ไม่มี","description":"หาดบางแสน 35","id":"005","images1":"https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/logo.png?alt=media&token=1a1437c0-50a3-4d16-b7ff-687bc333ed1e","images2":"https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/10.jpg?alt=media&token=815c644b-e11e-4b36-b33e-d1423fd6a9a3","images3":"https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/12.jpg?alt=media&token=a135b1af-2472-4649-81b0-fa2e3a451bd5","images4":"https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/13.jpg?alt=media&token=83aa1ae7-e731-4c6b-8d50-e491b111365b","images5":"https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/c82b9d7cfaef4f1c885e08bb8520a001.jpg?alt=media&token=0c6db833-9fed-44da-9752-746445ed2116","location_lat":"99.912984","location_long":"13.360193","name":"หมึกย่าง กุ้งย่าง ปูนึ่ง นางพิมพา","phone":"+66870518766","working_end":"18.00","working_start":"8.00"                });
//              },
//            ),
//            RaisedButton(
//              child: Text("GPS"),
//              onPressed: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => Home()));
//              },
//            ),
//            RaisedButton(
//              child: Text("Update Data"),
//              onPressed: () {
//                DBref.child("abc")
//                    .child('data')
//                    .update({'data': 'This is a update data'});
//              },
//            ),
//            RaisedButton(
//              child: Text("Map"),
//              onPressed: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => Gmap()));
//              },
//            ),
          ],
        ),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
//              arrowColor: Colors.black,
              accountName: new Text('สวัสดี'),
              accountEmail: new Text("ยินดีต้อนรับ"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/งานออกแบบที่ไม่มีชื่อ-5.png?alt=media&token=7662218e-1376-4356-8c88-3efea9354378'),
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(240, 101, 31, 1)),
            ),
//            new ListTile(
//              title: new Text('Play Games'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => MyHomePage(user)));
//              },
//            ),
//            new ListTile(
//              title: new Text('Upload Images'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => UploadPage()));
//              },
//            ),
//            new ListTile(
//              title: new Text('ลงชื่อออก'),
//              onTap: () {
//                signOut(context);
//              },
//            )
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyLoginPage()),
        ModalRoute.withName('/'));
  }
}
