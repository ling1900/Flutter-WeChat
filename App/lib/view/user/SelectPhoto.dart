import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// linglg：选择图片（发朋友圈时）
class SelectPhoto extends StatefulWidget {
  @override
  SelectPhotoState createState() => new SelectPhotoState();
}


class SelectPhotoState extends State<SelectPhoto> {
  List photoList = [];
  Widget selectPhotoWidget;

  getWrapList() {
    var width = (MediaQuery.of(context).size.width - 40) / 3;

    List warpList = <Widget>[];
    for (var i = 0; i < photoList.length; i++) {
      if (photoList.length <= 9) {
        warpList.add(new GestureDetector(
          child: new Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: Color(0xFFededed),
              ),
              child: new Center(
                child: photoList[i],
              )),
          onTap: () {
            photoList.removeAt(i);
            getWrapList();
          },
        ));
      } else {
        return;
      }
    }
    if (photoList.length != 9 || photoList.length == 0) {
      warpList.add(new GestureDetector(
        child: new Container(
            width: width,
            height: width,
            decoration: new BoxDecoration(
              color: Color(0xFFcccccc),
            ),
            child: new Center(
              child: new Icon(Icons.add, size: 50.0),
            )),
        onTap: () {
          // photoList.insert(photoList.length, photoList.length);
          openImage();
        },
      ));
    }

    selectPhotoWidget = Builder(
      builder: (context) {
        return Wrap(alignment: WrapAlignment.start, spacing: 10.0, runSpacing: 10.0, children: warpList);
      },
    );

    setState(() {
      selectPhotoWidget = selectPhotoWidget;
    });
  }

  Future openImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      photoList.insert(photoList.length, new Image.file(image));
      getWrapList();
    }
  }

  Widget build(BuildContext context) {
    getWrapList();
    return new Container(padding: EdgeInsets.all(10.0), width: MediaQuery.of(context).size.width, child: selectPhotoWidget);
  }
}