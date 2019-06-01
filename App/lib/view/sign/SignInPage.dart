import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'SignUpPage.dart';

// linglg：登录页面
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}


class _SignInPageState extends State<SignInPage> with SingleTickerProviderStateMixin {
  var _username_textEditingController = new TextEditingController();
  var _password_textEditingController = new TextEditingController();

  var _username_fsNode = new FocusNode();
  var _password_fsNode = new FocusNode();

  Animation _animationLogo;
  Animation _animationUsername;
  Animation _animationPassword;
  Animation _animationBtn;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(duration: new Duration(seconds: 1), vsync: this);
    _animationLogo = new Tween(begin: -1.0, end: 0.0) //
        .animate(new CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    _animationUsername = new Tween(begin: -1.0, end: 0.0) //
        .animate(new CurvedAnimation(parent: _animationController, curve: Interval(0.2, 1, curve: Curves.fastOutSlowIn)));
    _animationPassword = new Tween(begin: -1.0, end: 0.0) //
        .animate(new CurvedAnimation(parent: _animationController, curve: Interval(0.4, 1, curve: Curves.fastOutSlowIn)));
    _animationBtn = new Tween(begin: -1.0, end: 0.0) //
        .animate(new CurvedAnimation(parent: _animationController, curve: Interval(0.6, 1, curve: Curves.fastOutSlowIn)));

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //
    return new AnimatedBuilder(
      animation: _animationLogo,
      builder: (BuildContext context, child) {
        return new Scaffold(
            body: new ListView(
              children: <Widget>[
                // 微信logo
                new Transform(
                  transform: Matrix4.translationValues(width * _animationLogo.value, 0, 0),
                  child: new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 260.0,
                      child: new Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                // 用户名文本框
                new Transform(
                  transform: Matrix4.translationValues(width * _animationUsername.value, 0, 0),
                  child: new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    child: new TextField(
                      focusNode: _username_fsNode,
                      keyboardType: TextInputType.text,
                      controller: _username_textEditingController,
                      decoration: new InputDecoration(prefixIcon: new Icon(Icons.person_outline, size: 35.0, color: Color(0xFF393939)), hintText: 'UserName'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_password_fsNode);
                      },
                    ),
                  ),
                ),
                // 密码文本框
                new Transform(
                  transform: Matrix4.translationValues(width * _animationPassword.value, 0, 0),
                  child: new Container(
                    margin: new EdgeInsets.only(bottom: 50.0),
                    padding: new EdgeInsets.symmetric(horizontal: 30.0),
                    child: new TextField(
                      focusNode: _password_fsNode,
                      controller: _password_textEditingController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(prefixIcon: new Icon(Icons.lock_outline, size: 35.0, color: Color(0xFF393939)), hintText: 'PassWord'),
                      obscureText: true,
                    ),
                  ),
                ),
                // 登录按钮
                signInBtnWidget(width),
                // 进入“注册”页面
                new Transform(
                    transform: Matrix4.translationValues(width * _animationBtn.value, 0, 0),
                    child: new Container(
                      margin: new EdgeInsets.only(left: 150.0, right: 150.0, top: 80.0),
                      child: new OutlineButton(
                        borderSide: new BorderSide(color: Color(0xFFbcbcbc)),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        child: new Text(
                          'SIGNUP',
                          style: new TextStyle(color: Color(0xFFbcbcbc), fontSize: 12.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new SignUpPage()));
                        },
                      ),
                    )
                ),
                //
              ],
        ));
      },
    );
  }

  signInBtnWidget(width) {
    return new Transform(
      transform: Matrix4.translationValues(width * _animationBtn.value, 0, 0),
      child: new Container(
        margin: new EdgeInsets.symmetric(horizontal: 30.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new RaisedButton(
          padding: new EdgeInsets.symmetric(vertical: 15.0),
          color: const Color(0xFF64c223),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          child: new Text(
            'LOGIN',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var userInfo = {
              'username': 'kuaifengle',
              'id': 1,
              'userDesc': 'https://github.com/kuaifengle',
              'lastTime': '20.11',
              'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
              'backgroundUrl': 'http://pic31.photophoto.cn/20140404/0005018792087823_b.jpg'
            };

            prefs.setString('userInfo', json.encode(userInfo));
            // linglg：进入首页
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
      ),
    );
  }
}
