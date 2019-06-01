import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'MenuFloatButton.dart';
import '../user/ChatPage.dart';
import '../searchPage/SearchPage.dart';


// linglg：聊天列表
class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => new _ChatListState();
}


class _ChatListState extends State<ChatList> {
  List<Map> _chatInfoList = [
    {
      'username': 'kuaifengle',
      'id': 1,
      'userDesc': 'https://github.com/kuaifengle',
      'chatMsg': '我的 github 地址 https://github.com/kuaifengle',
      'lastTime': '20.11',
      'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
      'backgroundUrl': 'http://pic31.photophoto.cn/20140404/0005018792087823_b.jpg'
    },
    {
      'username': 'Only',
      'id': 2,
      'userDesc': '砖石一颗即永恒',
      'chatMsg': '在吗',
      'lastTime': '16.18',
      'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
      'backgroundUrl':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=ccd0b58aa181af2a0ef5dfc44266fde2&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D0f22919fb8b7d0a26fc40cdea3861c7c%2F0df431adcbef7609e92064b224dda3cc7cd99ef0.jpg'
    },
    {
      'username': '哈哈',
      'id': 3,
      'userDesc': '不用随便呵呵',
      'chatMsg': '呵呵',
      'lastTime': '24.00',
      'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
      'backgroundUrl':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=dd17c39c2f725d8e3f4fd69a668c5d9b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D93cf8a986f380cd7f213aaaec92dc741%2F902397dda144ad347a33f2afdaa20cf431ad850d.jpg'
    },
    {
      'username': '呵呵',
      'id': 4,
      'userDesc': '我只能呵呵了',
      'chatMsg': '我去洗澡了',
      'lastTime': '10.20',
      'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
      'backgroundUrl':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=2189213cef3d70c482f52359d2727d15&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F810a19d8bc3eb13584856f6fac1ea8d3fc1f44a0.jpg'
    },
    {
      'username': 'Dj',
      'id': 5,
      'userDesc': '如果我是Dj你会爱我吗',
      'chatMsg': '19块钱',
      'lastTime': '19.28',
      'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
      'backgroundUrl': ''
    }
  ];

  final SlidableController _slidableController = new SlidableController();

  // =========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        new Container(
          child: new ListView(
            children: chatItemWidgetList(),
          ),
        ),
        new MenuFloatButton()
      ],
    ));
  }

  // =========================================
  chatItemWidgetList() {
    List widgetList = <Widget>[
      new GestureDetector(
        child: new Container(
            height: 50.0,
            color: new Color(0xFFefeef3),
            child: ListTile(
              leading: Icon(Icons.search),
              title: new Text('Search'),
              trailing: new IconButton(
                icon: Icon(Icons.keyboard_voice),
                onPressed: () {
                  print('语音');
                },
              ),
            )),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new SearchPage()));
        },
      ),
    ];

    for (var i = 0; i < _chatInfoList.length; i++) {
      widgetList.add(chatItemWidget(_chatInfoList[i]));
    }
    return widgetList;
  }

  chatItemWidget(item) {
    return new GestureDetector(
      // linglg：可左右滑动
      child: new Slidable(
        controller: _slidableController,
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.2,
        child: new Container(
          decoration: new BoxDecoration(border: new BorderDirectional(bottom: new BorderSide(color: Color(0xFFe1e1e1), width: 1.0))),
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage('${item['imageUrl']}'),
            ),
            title: new Text('${item['username']}'),
            subtitle: new Text('${item['chatMsg']}'),
            trailing: new Text('${item['lastTime']}'),
          ),
        ),
        // linglg：左滑时出现的“右侧操作按钮”
        secondaryActions: <Widget>[
          new IconSlideAction(
              caption: '置顶',
              color: Color(0xFF61ab32),
              icon: Icons.vertical_align_top,
              onTap: () {
                // Navigator.of(context).push(
                //   new MaterialPageRoute(
                //    builder: (_) => new ChatPage(detail: item)
                //   )
                // );
              }),
          new IconSlideAction(
            caption: '删除会话',
            color: Color(0xFFf76767),
            icon: Icons.delete_outline,
            onTap: () => _showSnackBar('Delete'),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new ChatPage(detail: item);
        }));
      },
    );
  }

  _showSnackBar(val) {
    print(val);
  }
}
