import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../user/SendPhotoPage.dart';
import '../user/TimeLinePage.dart';
import '../user/AddFriendPage.dart';


class MenuFloatButton extends StatefulWidget {
  @override
  _MenuFloatButtonState createState() => new _MenuFloatButtonState();
}


class _MenuFloatButtonState extends State<MenuFloatButton> {
  // linglg：隐藏“二级按钮”
  bool _btnHide = true;
  Map _userInfo = {};

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userInfo = json.decode(prefs.getString('userInfo'));
  }

  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: new Container(
          width: 120.0,
          height: 120.0,
          child: new Stack(
            children: <Widget>[
              // linglg：浮动按钮
              new Positioned(
                  width: 50.0,
                  height: 50.0,
                  bottom: 0,
                  right: 0,
                  child: Transform.rotate(
                    child: new FloatingActionButton(
                      child: new Icon(Icons.add),
                      backgroundColor: const Color(0xFF6f69c1),
                      onPressed: () {
                        setState(() {
                          _btnHide = !_btnHide;
                        });
                      },
                    ),
                    angle: !_btnHide ? 0.8 : 0,
                  )),
              // =======================================================
              // linglg：“二级按钮”
              // linglg：朋友圈
              new Positioned(
                width: 42.0,
                height: 42.0,
                bottom: 0,
                left: 0,
                child: new Visibility(
                    visible: !_btnHide,
                    child: Center(
                      child: CircleAvatar(
                        child: new IconButton(
                          icon: new Icon(Icons.camera),
                          color: const Color(0xFFffffff),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new TimeLinePage(detail: _userInfo)));
                          },
                        ),
                        backgroundColor: const Color(0xFF6f69c1),
                      ),
                    )),
              ),
              // linglg：搜索并添加好友
              new Positioned(
                width: 42.0,
                height: 42.0,
                top: 25.0,
                left: 25.0,
                child: new Visibility(
                    visible: !_btnHide,
                    child: Center(
                      child: CircleAvatar(
                        child: new IconButton(
                          icon: new Icon(Icons.person_add),
                          color: const Color(0xFFffffff),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new AddFriendPage()));
                          },
                        ),
                        backgroundColor: const Color(0xFF6f69c1),
                      ),
                    )),
              ),
              // linglg：发朋友圈
              new Positioned(
                width: 42.0,
                height: 42.0,
                top: 0,
                right: 0,
                child: new Visibility(
                    visible: !_btnHide,
                    child: Center(
                      child: CircleAvatar(
                        child: new IconButton(
                          icon: new Icon(Icons.photo_camera),
                          color: const Color(0xFFffffff),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new SendPhotoPage()));
                          },
                        ),
                        backgroundColor: const Color(0xFF6f69c1),
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
