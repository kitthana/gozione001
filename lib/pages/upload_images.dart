import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  File _sampleimage;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _sampleimage = image;
        print('Image Path $_sampleimage');
      });
    }
    Future uploadPic(BuildContext context) async {
      String fileName = basename(_sampleimage.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_sampleimage);
//      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = downURL.toString();
      setState(() {
        print(url);
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Upload", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Builder(
            builder: (context) =>
                Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color(0xff476cfb),
                                  child: ClipOval(
                                    child: new SizedBox(
                                      width: 180.0,
                                      height: 180.0,
                                      child: (_sampleimage != null) ? Image
                                          .file(
                                        _sampleimage,
                                        fit: BoxFit.fill,
                                      ) : Image.network(
                                        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 60.0),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 30.0,

                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                              RaisedButton(
                                color: Color(0xff476cfb),
                                onPressed: () {
                                  uploadPic(context);
                                },

                                elevation: 4.0,
                                splashColor: Colors.blueGrey,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ]
                    )
                )
        )
    );
  }

}
//body: Container(
//        child: _sampleimage == null ? Text('Select an image') : getImage(),
//      ),
//          floatingActionButton: new FloatingActionButton(
//            onPressed: () {
//              uploadPic(context);
//            },
//            tooltip: 'Add Image',
//            child: new Icon(Icons.add),
//
//          ),
