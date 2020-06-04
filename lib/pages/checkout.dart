import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/models/cart_item.dart';
import 'package:test_app/models/foods.dart';
import 'package:test_app/models/post2.dart';
import 'package:test_app/models/post3.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  final TextEditingController _couponlControl = new TextEditingController();
  List<Posts3> postsProduct = [];
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final DBref = FirebaseDatabase.instance.reference();


  @override
  void initState(){
    DatabaseReference postsRef =
    FirebaseDatabase.instance.reference().child("Member").child("A001").child("product");
    postsRef.once().then((DataSnapshot snap) {

      var KEYS = snap.value.keys;
      var DATA = snap.value;
//      print(KEYS);
//      print(DATA);
      postsProduct.clear();
      for (var individualKey in KEYS) {
//        print(DATA[individualKey]['date']);
        Posts3 post3 = new Posts3(
          DATA[individualKey]['images'],
          DATA[individualKey]['name'],
          DATA[individualKey]['price'],
        );
        postsProduct.add(post3);
      }
      return postsProduct;
    });
//    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(240, 101, 31, 1),
        title: Text(
          "ซื้อสินค้า",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            tooltip: "Back",
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: ()=>Navigator.pop(context),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,130),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "ที่อยู่",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
//        Column(
//            children: List.generate(postsProduct.length,(index){
//              return Text(postsProduct[index].name.toString());
//            }),
//          ),
            ListTile(
              title: Text(
                "ที่อยู่ของคุณ",
                style: TextStyle(
//                    fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: Text("7/1 หมู่ 7 ตําบลปลายโพงพาง อําเภออัมพวา จังหวัดสมุทรสงคราม 75110"),
            ),

            SizedBox(height: 10.0),

            Text(
              "การจ่ายเงิน",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),

            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text("None"),
                subtitle: Text(
                  "XXXX XXXX XXXX XXXX",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.creditCard,
                  size: 50.0,
                  color: Color.fromRGBO(240, 101, 31, 1),
                ),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),

            Text(
              "รายการ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),

            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: postsProduct == null ? 0 :postsProduct.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                List<Posts3> product = postsProduct;
//                print(foods);
//                print(postsProduct.length);
                return CartItem(
                  images: product[index].images,
                  isFav: false,
                  name: product[index].name,
                  price: product[index].price,
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),
          ],
        ),
      ),

      bottomSheet: Card(
        elevation: 4.0,
        child: Container(

          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey[200],),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200],),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "คูปองส่วนลด",
                      prefixIcon: Icon(
                        Icons.redeem,
                        color: Color.fromRGBO(240, 101, 31, 1),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    controller: _couponlControl,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.fromLTRB(10,5,5,5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "ทั้งหมด",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text(
                          r"$--",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).accentColor,
                          ),
                        ),

                        Text(
                          "Delivery charges included",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(5,5,10,5),
                    width: 150.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Color.fromRGBO(240, 101, 31, 1),
                      child: Text(
                        "สั่งซื้อ".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: (){},
                    ),
                  ),

                ],
              ),



            ],
          ),

          height: 130,
        ),
      ),
    );
  }
}
