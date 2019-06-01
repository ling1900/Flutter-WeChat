import 'package:flutter/material.dart';

import 'SelectPhoto.dart';

// linglg：发朋友圈
class SendPhotoPage extends StatefulWidget {
  @override
  _SendPhotoPageState createState() => new _SendPhotoPageState();
}


class _SendPhotoPageState extends State<SendPhotoPage> {
  var textController = new TextEditingController();
  var fsNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // ===============================
        appBar: new AppBar(
          // linglg：左侧返回按钮
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            FlatButton(
              child: new Text('发表', style: new TextStyle(color: new Color(0xFF64c223), fontWeight: FontWeight.bold)),
              onPressed: () {
                print('发表文字');
              },
            )
          ],
        ),
        // ===============================
        body: new Container(
          child: ListView(
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: new TextField(
                  focusNode: fsNode,
                  controller: textController,
                  decoration: new InputDecoration(hintText: '这一刻的想法...', border: InputBorder.none),
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  onSubmitted: (value) {
                    fsNode.unfocus();
                  },
                ),
              ),
              new SelectPhoto(),
              // ============
              new ListTile(leading: Icon(Icons.person_pin_circle), title: new Text('所在位置')),
              new Divider(height: 2.0, color: Color(0xFFededed)),
              new ListTile(
                leading: Icon(Icons.people),
                title: new Text('谁可以看'),
              ),
              new Divider(height: 2.0, color: Color(0xFFededed)),
              new ListTile(leading: Icon(Icons.insert_link), title: new Text('提醒谁看')),
            ],
          ),
        ));
  }
}


