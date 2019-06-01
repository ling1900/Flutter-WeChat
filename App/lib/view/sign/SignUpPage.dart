import 'package:flutter/material.dart';

// linglg：注册页面
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  var _username_textEditingController = new TextEditingController();
  var _password_textEditingController = new TextEditingController();
  var _passwordAgain_textEditingController = new TextEditingController();

  var _username_fsNode = new FocusNode();
  var _password_fsNode = new FocusNode();
  var _passwordAgain_fsNode = new FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // ========================
        appBar: new AppBar(
          backgroundColor: new Color(0xFFf9f9f9),
          // linglg：左侧返回按钮
          leading: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_left),
            color: Color(0xFF555555),
            onPressed: () {
              // linglg：返回上一页
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          title: new Text(
            'SignUp',
            style: new TextStyle(color: const Color(0xFF555555)),
          ),
          centerTitle: true,
        ),
        // ========================
        body: bodyWidget()
    );
  }

  bodyWidget() {
    return new ListView(
      children: <Widget>[
        // 微信logo
        new Center(
          child: new Container(
            width: MediaQuery.of(context).size.width,
            height: 240.0,
            child: new Image.asset('assets/images/logo.png'),
          ),
        ),
        // linglg：用户名文本框
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: new TextField(
            focusNode: _username_fsNode,
            controller: _username_textEditingController,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(prefixIcon: new Icon(Icons.person_outline, size: 35.0, color: Color(0xFF393939)), hintText: 'UserName'),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_password_fsNode);
            },
          ),
        ),
        // linglg：密码文本框
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 30.0),
          child: new TextField(
            focusNode: _password_fsNode,
            keyboardType: TextInputType.text,
            controller: _password_textEditingController,
            decoration: new InputDecoration(prefixIcon: new Icon(Icons.lock_outline, size: 35.0, color: Color(0xFF393939)), hintText: 'PassWord'),
            obscureText: true,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_passwordAgain_fsNode);
            },
          ),
        ),
        // linglg：“确认密码”文本框
        new Container(
          margin: new EdgeInsets.only(top: 20.0, bottom: 50.0),
          padding: new EdgeInsets.symmetric(horizontal: 30.0),
          child: new TextField(
            focusNode: _passwordAgain_fsNode,
            keyboardType: TextInputType.text,
            controller: _passwordAgain_textEditingController,
            decoration: new InputDecoration(prefixIcon: new Icon(Icons.lock, size: 35.0, color: Color(0xFF393939)), hintText: 'RepeatPassWord'),
            obscureText: true,
            onEditingComplete: () {
              _passwordAgain_fsNode.unfocus();
            },
          ),
        ),
        // linglg：“注册”按钮
        signUpBtnWidget(),
      ],
    );
  }

  signUpBtnWidget() {
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 30.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: new RaisedButton(
        padding: new EdgeInsets.symmetric(vertical: 15.0),
        color: const Color(0xFF64c223),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        child: new Text(
          'SIGNUP',
          style: new TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        onPressed: () {
          print(_username_textEditingController.text);
          if (_username_textEditingController.text != '' //
              && //
              (_password_textEditingController.text == _passwordAgain_textEditingController.text //
                  && _password_textEditingController.text != '' ) //
          ) {
            // 输入合法
            // linglg：显示对话框
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                  title: new Text('提示'),
                  content: new Text('WelCome To WeChat...'),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("SignIn"),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signIn');
                      },
                    )
                  ],
                )
            );
          } else {
            // 输入不合法
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text('提示'),
                    content: new Text('注册信息有误,请检查...'),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('back'),
                        onPressed: () {
                          // linglg：返回上一页
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
            );
          }
        },
      ),
    );
  }
}
