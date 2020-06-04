import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Detailgame1 extends StatefulWidget {

  @override
  _Detailgame1 createState() => _Detailgame1();
}
class _Detailgame1 extends State<Detailgame1> {
  @override
  String barcode = "";

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          appBar: AppBar(
            title: Text('State 1'),
//            actions: <Widget>[IconButton(icon: Icon(Icons.camera_alt), onPressed: scan)],
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                ),
                Text('ร้านแดงอาหารทะเล',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Image.network("https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/1.jpg?alt=media&token=3d126052-9647-4634-8051-d4bffef37470"),
                Text('คำสั่งคือ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                Text('ไปสแกน QRcode',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                Text('กับร้านที่อยู่ในรูปภาพ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                IconButton(icon: Icon(Icons.camera_alt), onPressed: scan),
                Text(barcode, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              ],
            ),
          )
    );
  }
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // The user did not grant the camera permission.
      } else {
        // Unknown error.
      }
    } on FormatException {
      // User returned using the "back"-button before scanning anything.
    } catch (e) {
      // Unknown error.
    }
  }
}