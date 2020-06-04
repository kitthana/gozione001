import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Detailgame2 extends StatefulWidget {

  @override
  _Detailgame2 createState() => _Detailgame2();
}

class _Detailgame2 extends State<Detailgame2> {
  //final ImagePicker _imagePicker = ImagePickerChannel();

  File _imageFile;

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Image.file(_imageFile);
    } else {
      return Text('Take an image to start', style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treasure Hunt'),
      ),
      body: Column(
        children: [
          Text('รูปปั้นผีเสื้อสมุทร',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          Image.network('https://firebasestorage.googleapis.com/v0/b/gozione.appspot.com/o/unnamed.jpg?alt=media&token=6ed0f013-b882-4287-871e-53025d1e52b1'),
          Text('คำสั่งคือ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
          Text('ไปถ่ายรูป',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
          Text('กับสิ่งที่อยู่ในรูปภาพ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
          IconButton(icon: Icon(Icons.save)),
          Expanded(child: Center(child: _buildImage())),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: Key('retake'),
                text: 'Photos',
                onPressed: () => captureImage(ImageSource.gallery),
              ),
              _buildActionButton(
                key: Key('upload'),
                text: 'Camera',
                onPressed: () => captureImage(ImageSource.camera),
              ),
            ]));
  }

  Widget _buildActionButton({Key key, String text, Function onPressed}) {
    return Expanded(
      child: FlatButton(
          key: key,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }
}
