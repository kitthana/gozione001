import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/pages/home_firebase.dart';
import 'package:test_app/pages/nearbyhomepage.dart';
import 'models/product_details/product_details.dart';

const String homeViewRoute = '/';
const String productDetailsViewRoute = 'product_details';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      FirebaseUser user;
      return MaterialPageRoute(builder: (context) => Nearby(user));
    case productDetailsViewRoute:
      return MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
          product: settings.arguments,
        ),
      );
      break;
    default:
      FirebaseUser user;
      return MaterialPageRoute(builder: (context) => Nearby(user));
  }
}
