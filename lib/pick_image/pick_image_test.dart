import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PickImageState();
  }
}

class PickImageState extends State<PickImagePage> {
  List<File> _images = [];
  bool isSelectFromAlbum = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("选择照片"),
      ),
      body: Wrap(
        children: _showImage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPickBottomDialog();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  //展示选择对话框
  _showPickBottomDialog() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text("从相册选择"),
                onTap: () {
                  isSelectFromAlbum = true;
                  _getImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("拍照"),
                onTap: () {
                  isSelectFromAlbum = false;
                  _getImage();
                },
              )
            ],
          );
        });
  }

  Future _getImage() async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(
        source: isSelectFromAlbum ? ImageSource.gallery : ImageSource.camera);

    setState(() {
      _images.add(image);
    });
  }

  _showImage() {
    return _images.map((f) {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.file(
              f,
              height: 90,
              width: 120,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _images.remove(f);
                });
              },
              child: ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.black45),
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
