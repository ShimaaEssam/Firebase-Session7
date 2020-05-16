import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class HomeStorage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeStorage> {

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Image', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.image, color: Colors.redAccent,),
              onTap: () {
                setState(() {
                  fileType = 'image';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('Audio', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.audiotrack, color: Colors.redAccent,),
              onTap: () {
                setState(() {
                  fileType = 'audio';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('Video', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.video_label, color: Colors.redAccent,),
              onTap: () {
                setState(() {
                  fileType = 'video';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('PDF', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.pages, color: Colors.redAccent,),
              onTap: () {
                setState(() {
                  fileType = 'pdf';
                });
                filePicker(context);
              },
            ),
            ListTile(
              title: Text('Others', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.attach_file, color: Colors.redAccent,),
              onTap: () {
                setState(() {
                  fileType = 'others';
                });
                filePicker(context);
              },
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
//      bottomNavigationBar: BottomAppBar(
//        child: new Row(
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: <Widget>[
//            IconButton(
//              icon: Icon(
//                  Icons.cloud_upload
//              ),
//              onPressed: () {},
//            ),
//            IconButton(
//              icon: Icon(
//                  Icons.view_list
//              ),
//              onPressed: () {
//
//              },
//            )
//          ],
//        ),
//      ),
      appBar: AppBar(
        title: Text('Firestorage Demo', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'audio') {
        file = await FilePicker.getFile(type: FileType.audio);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'video') {
        file = await FilePicker.getFile(type: FileType.video);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(type: FileType.custom);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'others') {
        file = await FilePicker.getFile(type: FileType.any);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }

  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("images/$filename");
    }
    if (fileType == 'audio') {
      storageReference =
          FirebaseStorage.instance.ref().child("audio/$filename");
    }
    if (fileType == 'video') {
      storageReference =
          FirebaseStorage.instance.ref().child("videos/$filename");
    }
    if (fileType == 'pdf') {
      storageReference =
          FirebaseStorage.instance.ref().child("pdf/$filename");
    }
    if (fileType == 'others') {
      storageReference =
          FirebaseStorage.instance.ref().child("others/$filename");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }
}
/*
Read Image
need to get url first
//
final ref = FirebaseStorage.instance.ref().child('images/').child('testimage');//.child('images') law gwa folder
// no need of the file extension, the name will do fine.
var url = await ref.getDownloadURL();
print(url);
Once you've the url,

Image.network(url);
 */