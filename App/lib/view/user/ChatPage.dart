import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'UserDetailPage.dart';

// linglg：聊天页面
// linglg：可以发送图片，发送文本，自动回复
class ChatPage extends StatefulWidget {
  // linglg：不可改名。_ChatPageState 会使用。
  final detail;

  ChatPage({Key key, this.detail}) : super(key: key);

  @override
  _ChatPageState createState() => new _ChatPageState();
}


class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {
  // linglg：聊天输入框，获得焦点时，关闭“语音”“图片”面板
  var _fsNode = new FocusNode();
  var _textInputController = new TextEditingController();
  var _scrollController = new ScrollController();

  List<Widget> _chatItemWidgetList = <Widget>[];
  // linglg：聊天记录。每个元素是一条聊天（对象）
  List<Map> _chatHistory = [];

  // linglg：是否显示“录音”面板
  // linglg：“录音”面板与“文本”面板、“其它”面板互斥
  // linglg：“其它”面板叠加在“文本”面板之下
  bool _voiceOffstage = false;
  // linglg：是否显示“其它”面板（发送图片等）
  bool _otherOffstage = false;

  // linglg：“录音按钮”动画：逐渐变大，逐渐变小
  Animation _voiceAnimation;
  AnimationController _voiceAnimationController;

  // linglg：自动回复列表
  List<String> _replayChatList = [
    '这是自动留言,我的手机不在身边, 有事请直接Call我....',
    '呵呵,真好笑!!!',
    '你最近好吗?',
    '如果我是DJ你会爱我吗?',
    'hohohohohoho, boom!',
    '刮风那天我试过牵着你手',
  ];

  // =================================================
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
      },
      child: new Scaffold(
        appBar: appBarWidget(),
        body: bodyWidget(),
      ),
    );
  }

  appBarWidget() {
    return new AppBar(
      leading: new IconButton(
        icon: Icon(Icons.keyboard_arrow_left),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/home');
        },
      ),
      title: new Text(
        '${widget.detail['username']}',
        style: new TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.person, size: 30.0),
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new UserDetailPage(detail: widget.detail)));
          },
        )
      ],
      centerTitle: true,
    );
  }

  bodyWidget() {
    return new Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              padding: new EdgeInsets.only(bottom: 50.0),
              // width: MediaQuery.of(context).size.width - 40.0,
              child: ListView(
                controller: _scrollController,
                children: _chatItemWidgetList,
              ),
            ),
            new Positioned(
              bottom: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  color: Color(0xFFebebf3),
                  child: new Column(
                    children: <Widget>[textPanelWidget(), voicePanelWidget(), otherPanelWidget()],
                  )),
            )
          ],
        ));
  }

  textPanelWidget() {
    return new Offstage(
      offstage: _voiceOffstage,
      child: new Row(
        children: <Widget>[
          new Container(
            width: 40.0,
            color: Color(0xFFaaaab6),
            child: new IconButton(
              icon: new Icon(Icons.keyboard_voice),
              onPressed: () {
                setState(() {
                  _fsNode.unfocus();
                  _voiceOffstage = !_voiceOffstage;
                  _otherOffstage = false;
                });
              },
            ),
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width - 140.0,
            child: new TextField(
              focusNode: _fsNode,
              controller: _textInputController,
              decoration: new InputDecoration(border: InputBorder.none, hintText: '输入你的信息...', hintStyle: new TextStyle(color: Color(0xFF7c7c7e))),
              onSubmitted: (val) {
                if (val != '' && val != null) {
                  updateChatItemWidgetList();
                  autoReply(val, 'text');
                }
                _textInputController.clear();
              },
            ),
          ),
          new IconButton(
            icon: Icon(Icons.insert_emoticon, color: Color(0xFF707072)),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(Icons.add_circle_outline, color: Color(0xFF707072)),
            onPressed: () {
              setState(() {
                _fsNode.unfocus();
                _otherOffstage = !_otherOffstage;
              });
            },
          )
        ],
      ),
    );
  }

  voicePanelWidget() {
    return new Offstage(
      // 录音按钮
        offstage: !_voiceOffstage,
        child: new Column(
          children: <Widget>[
            new Container(
              height: 30.0,
              color: Color(0xFFededed),
              alignment: Alignment.centerLeft,
              child: new IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _voiceAnimationController.reset();
                  _voiceAnimationController.stop();
                  setState(() {
                    _voiceOffstage = !_voiceOffstage;
                  });
                },
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              height: 170.0,
              color: Color(0xFFededed),
              child: new Center(
                  child: new AnimatedBuilder(
                    animation: _voiceAnimation,
                    builder: (_, child) {
                      return new GestureDetector(
                        child: new CircleAvatar(
                          radius: _voiceAnimation.value * 30,
                          backgroundColor: Color(0x306b6aba),
                          child: new Center(
                            child: Icon(Icons.keyboard_voice, size: 30.0, color: Color(0xFF6b6aba)),
                          ),
                        ),
                        onLongPress: () {
                          _voiceAnimationController.forward();
                        },
                        onLongPressUp: () {
                          _voiceAnimationController.reset();
                          _voiceAnimationController.stop();
                        },
                      );
                    },
                  )),
            ),
          ],
        ));
  }

  // “其它”面板（发送图片等）
  // 目前只有发送图片
  otherPanelWidget() {
    return new Offstage(
        offstage: !_otherOffstage,
        child: new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170.0,
                    color: Color(0xFFededed),
                    child: Wrap(
                      spacing: 25.0,
                      runSpacing: 10.0,
                      children: <Widget>[
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.photo_size_select_actual, color: Colors.black38),
                            onPressed: () {
                              // linglg：选择图片
                              getImage();
                            },
                          ),
                        ),
                        // ============================
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.videocam, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.linked_camera, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.add_location, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.library_music, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.library_books, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.video_library, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                        new Container(
                          width: (MediaQuery.of(context).size.width - 100) / 4,
                          height: (MediaQuery.of(context).size.width - 100) / 4,
                          color: Color(0xFFffffff),
                          child: new IconButton(
                            iconSize: 50.0,
                            icon: Icon(Icons.local_activity, color: Colors.black38),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )),
              ],
            )));
  }

  // ===================================
  @override
  void initState() {
    _voiceAnimationController = new AnimationController(duration: new Duration(seconds: 1), vsync: this);
    _voiceAnimation = new Tween(begin: 1.0, end: 1.5) //
        .animate(_voiceAnimationController) //
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          _voiceAnimationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          _voiceAnimationController.forward();
        }
      });

    _fsNode.addListener(_focusListener);

    super.initState();
  }

  _focusListener() async {
    if (_fsNode.hasFocus) {
      setState(() {
        _otherOffstage = false;
        _voiceOffstage = false;
      });
    }
  }

  @override
  void dispose() {
    _voiceAnimationController.dispose();
    super.dispose();
  }

  // ===============================
  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      autoReply(image, 'image');
    }
  }

  autoReply(val, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mySelf = json.decode(prefs.getString('userInfo'));

    _chatHistory.add({
      'username': '${mySelf['username']}',
      'id': mySelf['id'],
      'imageUrl': mySelf['imageUrl'],
      'content': val,
      'type': type // image text
    });
    updateChatItemWidgetList();

    Future.delayed(new Duration(seconds: 1), () {
      var item = {
        'username': '${widget.detail['username']}',
        'id': widget.detail['id'],
        'imageUrl': widget.detail['imageUrl'],
        'content': _replayChatList[_chatHistory.length % 5],
        'type': 'text'
      };
      _chatHistory.add(item);
      updateChatItemWidgetList();
    });
  }

  updateChatItemWidgetList() {
    List<Widget> widgetList = [];

    for (var i = 0; i < _chatHistory.length; i++) {
      widgetList.add(chatItemWidget(_chatHistory[i]));
    }

    setState(() {
      _chatItemWidgetList = widgetList;
      _scrollController.animateTo(50.0 * _chatHistory.length + 100, duration: new Duration(seconds: 1), curve: Curves.ease);
    });
  }

  // linglg：聊天项：内容，头像
  chatItemWidget(item) {
    List<Widget> widgetList = [];

    if (item['id'] != widget.detail['id']) {
      // 非本人的信息
      widgetList = [
        new Container(
            margin: new EdgeInsets.only(right: 20.0),
            padding: new EdgeInsets.all(10.0),
            decoration: new BoxDecoration(color: Color(0xFFebebf3), borderRadius: new BorderRadius.circular(10.0)),
            child: new LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: chatContentWidget(item['type'], item['content']),
            )),
        new CircleAvatar(
          backgroundImage: new NetworkImage('${item['imageUrl']}'),
        ),
      ];
    } else {
      // 本人的信息
      widgetList = [
        new CircleAvatar(
          backgroundImage: new NetworkImage('${item['imageUrl']}'),
        ),
        new Container(
          margin: new EdgeInsets.only(left: 20.0),
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(color: Color(0xFFebebf3), borderRadius: new BorderRadius.circular(10.0)),
          child: new LimitedBox(maxWidth: MediaQuery.of(context).size.width - 120.0, child: chatContentWidget(item['type'], item['content'])),
        ),
      ];
    }

    return new Container(
        width: MediaQuery.of(context).size.width - 120.0,
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            mainAxisAlignment: widget.detail['id'] == item['id'] ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widgetList));
  }

  // ling：聊天内容
  chatContentWidget(type, val) {
    switch (type) {
      case 'text':
        return new Text(val,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 100,
            textAlign: TextAlign.left,
            style: new TextStyle(
              height: 1,
            ));
        break;
      case 'image':
        return new Image.file(val);
        break;
      case 'text':
        return new Text(val);
        break;
    }
  }
}
