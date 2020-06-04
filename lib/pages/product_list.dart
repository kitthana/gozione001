import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/models/product_card.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> filters = [
    'ใกล้คุณ',
    'เป็นที่นิยม',
  ];
  String selectedFilter;
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();
    selectedFilter = "ใกล้คุณ";
    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Member");
    postsRef.once().then((DataSnapshot snap)
    {

      var KEYS = snap.value.keys;
      var DATA = snap.value;
      var i = 0;

      postsList.clear();

      for(var individualKey in KEYS )
      {
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
      }

      setState(() {
//        print(postsList[i].name);
//        print(postsList[i].images1);
//        print(postsList[i+1].name);
//        print(postsList[i+1].images1);
//        print(postsList[i].location_long);
          print(postsList.length);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    final itemCountRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "ร้านที่อยู่ใกล้คุณ",
          style: TextStyle(fontSize: 17.0),
        ),
        DropdownButton(
          value: selectedFilter,
          items: filters.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 17.0)),
            );
          }).toList(),
          onChanged: (selected) {
            setState(() {
              selectedFilter = selected;
            });
          },
        )
      ],
    );

    final list = Expanded(
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(postlist : postsList[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.65,
        ),
        itemCount: 140,
      ),
    );

    return Container(
      child: Column(
        children: <Widget>[itemCountRow, list],
      ),
    );
  }
}
