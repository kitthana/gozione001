import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/shape/gf_button_shape.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:share/share.dart';
import 'package:test_app/models/notifications.dart';
import 'package:test_app/models/post2.dart';
import 'package:test_app/pages/checkout.dart';
import 'package:test_app/pages/gps.dart';
import 'package:test_app/pages/gps_nearby.dart';
import 'package:test_app/services/alert.service.dart';
import 'package:test_app/utils/badge.dart';
import 'package:test_app/utils/comments.dart';
import 'package:test_app/utils/const.dart';
import 'package:test_app/utils/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  String name;
  String images1;
  String description;
  double lat;
  double long;
  String start;
  String end;
  String images2;
  String images3;
  String images4;
  String images5;
  String phone;

  Detail(
      String name,
      String images1,
      String description,
      double lat,
      double long,
      String start,
      String end,
      String images2,
      String images3,
      String images4,
      String images5,
      String phone) {
    this.name = name;
    this.images1 = images1;
    this.description = description;
    this.lat = lat;
    this.long = long;
    this.start = start;
    this.end = end;
    this.images2 = images2;
    this.images3 = images3;
    this.images4 = images4;
    this.images5 = images5;
    this.phone = phone;
  }
  List<Posts2> postsProduct = [];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Detailstate(name, images1, description, lat, long, start, end,
        images2, images3, images4, images5, phone);

  }

}

class _Detailstate extends State<Detail> {
  bool isFav = false;
  String name;
  String images1;
  String description;
  double lat;
  double long;
  String start;
  String end;
  String images2;
  String images3;
  String images4;
  String images5;
  String phone;

  _Detailstate(
      String name,
      String images1,
      String description,
      double lat,
      double long,
      String start,
      String end,
      String images2,
      String images3,
      String images4,
      String images5,
      String phone) {
    this.name = name;
    this.images1 = images1;
    this.description = description;
    this.lat = lat;
    this.long = long;
    this.start = start;
    this.end = end;
    this.images2 = images2;
    this.images3 = images3;
    this.images4 = images4;
    this.images5 = images5;
    this.phone = phone;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Color.fromRGBO(240, 101, 31, 1),
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Stack(children: <Widget>[
          Image.network(
            images1,
            fit: BoxFit.fill,
          ),
          Positioned(
            right: -10.0,
            bottom: 3.0,
            child: RawMaterialButton(
              onPressed: () {},
              fillColor: Colors.white,
              shape: CircleBorder(),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 17,
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: 10.0),
        Text(
          "$name",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
          child: Row(
            children: <Widget>[
              SmoothStarRating(
                starCount: 5,
                color: Constants.ratingBG,
                allowHalfRating: true,
                rating: 5.0,
                size: 10.0,
              ),
              SizedBox(width: 10.0),

              Text(
                "5.0 (23 Reviews)",
                style: TextStyle(
                  fontSize: 11.0,
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "รายละเอียด",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
        ),
        SizedBox(height: 5.0),
        Text(
          "$description",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
        ),
        SizedBox(height: 5.0),
        Text(
          "ร้านเปิด : ${start.toUpperCase()}",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
        ),
        SizedBox(height: 5.0),
        Text(
          "ร้านปิด : ${end.toUpperCase()}",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
        ),

        SizedBox(height: 20.0),
        imageslide(images2, images3, images4, images5),
        SizedBox(height: 20.0),

        Text(
          "Reviews",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
        ),
        SizedBox(height: 20.0),

        ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments == null?0:comments.length,
          itemBuilder: (BuildContext context, int index) {
            Map comment = comments[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  "${comment['img']}",
                ),
              ),

              title: Text("${comment['name']}"),
              subtitle: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SmoothStarRating(
                        starCount: 5,
                        color: Constants.ratingBG,
                        allowHalfRating: true,
                        rating: 5.0,
                        size: 12.0,
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        "February 14, 2020",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 7.0),
                  Text(
                    "${comment["comment"]}",
                  ),
                ],
              ),
            );
          },
        ),

        SizedBox(height: 10.0),
        GFButton(
          onPressed: () {
//            print(lat);
//            print(long);
//            print(name);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GPSlocation(lat, long, name)));
          },
          shape: GFButtonShape.pills,
          icon: Icon(Icons.pin_drop),
          child: const Text('สถานที่ตั้ง', style: TextStyle(fontSize: 20)),
        ),
//        RaisedButton(
//          onPressed: () {
//            Share.share(
//                'Check out our apps: https://play.google.com/store/apps/details?id=com.saleafterservice.gozione');
//          },
//          child: const Text('แชร์', style: TextStyle(fontSize: 20)),
//        ),
        GFButton(
            onPressed: () {
              launch("tel://$phone");
            },
            shape: GFButtonShape.pills,
            icon: Icon(Icons.call),
            child: const Text('โทร', style: TextStyle(fontSize: 20))),

        GFButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Checkout()));
          },
          shape: GFButtonShape.pills,
          type: GFButtonType.outline,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "รับบริการ",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                "${widget.name.toString()}",
                style: TextStyle(fontSize: 20.0, color: Colors.deepOrange[600]),
              ),
            ],
          ),
        ),
//      RaisedButton(
//              child: Text("GPS"),
//              onPressed: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => Gmap()));
//              },
//            ),
      ]),
    );
  }
}

class imageslide extends StatefulWidget {
  String images2;
  String images3;
  String images4;
  String images5;

  imageslide(String images2, String images3, String images4, String images5) {
    this.images2 = images2;
    this.images3 = images3;
    this.images4 = images4;
    this.images5 = images5;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _imageslideState(images2, images3, images4, images5);
  }
}

class _imageslideState extends State<imageslide> {
  String images2;
  String images3;
  String images4;
  String images5;

  _imageslideState(
      String images2, String images3, String images4, String images5) {
    this.images2 = images2;
    this.images3 = images3;
    this.images4 = images4;
    this.images5 = images5;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider(
      height: 150.0,
      items: [images2, images3, images4, images5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.white),
                child: GestureDetector(
                  child: Image.network(i, fit: BoxFit.fitWidth),
                ));
          },
        );
      }).toList(),
    );
  }
}
