import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/nearbyhomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  FirebaseUser get user => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Nearby(user),
      debugShowCheckedModeBanner: false,
    );
  }
}
