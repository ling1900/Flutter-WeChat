import 'package:flutter/material.dart';

import 'MyDrawer.dart';
import 'ChatList.dart';

// linglg：主页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _lastClickTime = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // 双击退出应用
        int nowTime = new DateTime.now().microsecondsSinceEpoch;
        if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
          return new Future.value(true);
        } else {
          _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
          new Future.delayed(const Duration(milliseconds: 1500), () {
            _lastClickTime = 0;
          });
          return new Future.value(false);
        }
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'WeChat',
            style: new TextStyle(color: const Color(0xFFFFFFFF)),
          ),
          centerTitle: true,
          // linglg：头部右侧下拉菜单
          actions: <Widget>[
            PopupMenuButton(
              offset: Offset(0.0, 60.0),
              icon: Icon(Icons.add),
              itemBuilder: (_) {
                return [
                  new PopupMenuItem(child: new Text('发起群聊'), value: '1'),
                  new PopupMenuItem(child: new Text('扫一扫'), value: '1'),
                  new PopupMenuItem(child: new Text('收付款'), value: '1'),
                  new PopupMenuItem(child: new Text('帮助与反馈'), value: '1'),
                ];
              },
            )
          ],
        ),
        // linglg：左侧抽屉（左侧菜单）
        drawer: new MyDrawer(),
        // linglg：聊天列表
        body: new ChatList(),
      ),
    );
  }
}
