import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/pages/detail.dart';
import 'package:test_app/router.dart' as router;
import 'package:test_app/utils/colors.dart';
import 'package:test_app/pages/nearbyhomepage.dart';

class ProductCard extends StatelessWidget {
//  final Product product;
  final Posts postlist;

  const ProductCard({Key key, @required this.postlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 5.0);

    final image =
        Hero(tag: postlist.name, child: Image.network(postlist.images1));

    final name = Text(
      "วันหยุด : ${postlist.dayoff.toUpperCase()}",
      textAlign: TextAlign.center,
      style: TextStyle(
//        color: Color.fromRGBO(5, 219, 204,1),
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    );

    final brand = Text(
      postlist.description.toUpperCase(),
      style: TextStyle(fontSize: 10.0,),
    );

    final price = Text(
      "${postlist.name.toString()}",
      style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 11.0,
        color: Color.fromRGBO(207, 35, 5, 1)
      ),
    );

    final lat = double.parse(postlist.location_lat);
    final long = double.parse(postlist.location_long);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: MaterialButton(
        color: AppColors.primaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail(
                    postlist.name, postlist.images1, postlist.description,lat,long,postlist.working_start,postlist.working_end,postlist.images2,postlist.images3,postlist.images4,postlist.images5,postlist.phone))),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              image,
              spacer,
              name,
              spacer,
              spacer,
              brand,
              spacer,
              price
            ],
          ),
        ),
      ),
    );
  }
}
