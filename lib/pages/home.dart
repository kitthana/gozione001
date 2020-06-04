import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/pages/Resetpassword.dart';
import 'package:test_app/pages/home_firebase.dart';
import 'package:test_app/pages/nearbyhomepage.dart';
import 'package:test_app/pages/signup.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        appBar: AppBar(
            title: Text("Gozione", style: TextStyle(color: Colors.white)),
            backgroundColor: Color.fromRGBO(240, 101, 31, 1)),
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.green[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTextFieldEmail(),
                      buildTextFieldPassword(),
//                      buildButtonSignIn(),
                      RaisedButton(
                        child: Text(
                          'ลงชื่อเข้าใช้',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.cyan),
                        ),
                        onPressed: () {
                          signIn();
//                          Navigator.pushNamed(context, '/home-page',
//                              arguments: FirebaseUser);
                        },
                      ),
                      buildOtherLine(),
                      RaisedButton(
                        child: Text(
                          "สมัครสมาชิก",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.cyan),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MySignUpPage()));
                        },
                      ),
                      buildOtherLine2(),
                      buildButtonForgotPassword(context),
                    ],
                  )),
            )));
  }

  Container buildButtonSignIn() {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      child: Text("ลงชื่อเข้าใช้",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(12),
    );
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "อีเมล"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration.collapsed(hintText: "พาสเวิร์ด"),
            style: TextStyle(fontSize: 18)));
  }

  signIn() {
    _auth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((user) {
      print("signed in ${user.toString()}");
      checkAuth(context);
    }).catchError((error) {
      print(error);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    });
  }

  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Nearby(user)),
          ModalRoute.withName('/'));
    }
  }

  Widget buildOtherLine() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text("ยังไม่ได้สมัครสมาชิก?",
                  style: TextStyle(color: Colors.black87))),
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }

  Widget buildOtherLine2() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text("อื่นๆ", style: TextStyle(color: Colors.black87))),
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }

  buildButtonForgotPassword(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("ลืมรหัสผ่าน",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.red[300]),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => navigateToResetPasswordPage(context));
  }

  navigateToResetPasswordPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyResetPasswordPage()));
  }
}
