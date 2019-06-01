import 'package:flutter/material.dart';

import 'ChatPage.dart';
import 'TimeLinePage.dart';


class UserDetailPage extends StatefulWidget {
  final detail;

  UserDetailPage({Key key, this.detail}) : super(key: key);

  @override
  _UserDetailPageState createState() => new _UserDetailPageState();
}


class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    var photoWith = (MediaQuery.of(context).size.width - 150) / 4;

    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          userInfoWidget(),
          // ====================
          // linglg：leading 和 title ，文本显示对不齐
//          new ListTile(leading: new Text('Address:'), title: new Text('China GuangZhou')),
          new ListTile(title: new Text('Address: China GuangZhou')),
          new Divider(height: 2.0, color: Color(0xFFededed)),
//          new ListTile(leading: new Text('Signature:'), title: new Text('${widget.detail['userDesc']}')),
          new ListTile(title: new Text('Signature: ${widget.detail['userDesc']}')),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          // ====================
          // linglg：朋友圈图片
          new GestureDetector(
            child: new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text('Album:'),
                  new Image.network(widget.detail['imageUrl'], width: photoWith, height: photoWith),
                  new Image.network(widget.detail['imageUrl'], width: photoWith, height: photoWith),
                  new Image.network(widget.detail['imageUrl'], width: photoWith, height: photoWith),
                  new Image.network(widget.detail['imageUrl'], width: photoWith, height: photoWith)
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => new TimeLinePage(detail: widget.detail)));
            },
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          // ====================
          // linglg：发送消息
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: new RaisedButton(
              padding: new EdgeInsets.symmetric(vertical: 15.0),
              color: const Color(0xFF64c223),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: new Text(
                'Send Message',
                style: new TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new ChatPage(detail: widget.detail)));
              },
            ),
          ),
          // ====================
          // linglg：视频聊天
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 50.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: new RaisedButton(
              padding: new EdgeInsets.symmetric(vertical: 15.0),
              color: const Color(0xFFededed),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: new Text(
                'Video Call',
                style: new TextStyle(fontSize: 16.0),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new ChatPage(detail: widget.detail)));
              },
            ),
          ),
        ],
      ),
    );
  }

  userInfoWidget() {
    return new Container(
        height: 260.0,
        child: new Stack(
          children: <Widget>[
            new Opacity(
                opacity: 0.4,
                child: new Container(
                  height: 240.0,
                  decoration: new BoxDecoration(image: new DecorationImage(image: new NetworkImage(widget.detail['backgroundUrl']), fit: BoxFit.fill)),
                )),
            new Positioned(
              top: 0,
              child: new Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                child: new Row(
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 30.0),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: new Text(
                          'Detailed',
                          style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ),
            ),
            new Positioned(
                top: 80,
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Column(
                    children: <Widget>[
                      new CircleAvatar(
                        radius: 40.0,
                        backgroundImage: new NetworkImage(widget.detail['imageUrl']),
                      ),
                      new Center(
                        child: new Text(
                          '${widget.detail['username']}',
                          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.5),
                        ),
                      ),
                      new Center(
                        child: new Text(
                          '如果我是Dj你会爱我吗?',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            new Positioned(
                right: 15.0,
                bottom: 0.0,
                child: new FloatingActionButton(
                  backgroundColor: const Color(0xFF6b6aba),
                  child: Icon(
                    Icons.settings,
                    size: 30.0,
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => new
                    //   )
                    // );
                  },
                ))
          ],
        ));
  }
}
