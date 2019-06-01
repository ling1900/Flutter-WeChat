import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'ChatPage.dart';
import 'UserDetailPage.dart';
import '../searchPage/SearchPage.dart';

// linglg：通讯录
class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => new _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List _a2z = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  // linglg：好友列表，按字母分组
  Map<String, List<Map>> _userGroupMap = {
    'A': [
      {
        'username': 'A kuaifengle',
        'id': 1,
        'userDesc': 'https://github.com/kuaifengle',
        'lastTime': '20.11',
        'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
        'backgroundUrl': 'http://pic31.photophoto.cn/20140404/0005018792087823_b.jpg'
      },
      {
        'username': 'A Only',
        'id': 2,
        'userDesc': '砖石一颗即永恒',
        'lastTime': '16.18',
        'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
        'backgroundUrl':
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=ccd0b58aa181af2a0ef5dfc44266fde2&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D0f22919fb8b7d0a26fc40cdea3861c7c%2F0df431adcbef7609e92064b224dda3cc7cd99ef0.jpg'
      },
      {
        'username': 'A 哈哈',
        'id': 3,
        'userDesc': '呵呵',
        'lastTime': '24.00',
        'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
        'backgroundUrl':
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=dd17c39c2f725d8e3f4fd69a668c5d9b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D93cf8a986f380cd7f213aaaec92dc741%2F902397dda144ad347a33f2afdaa20cf431ad850d.jpg'
      },
      {
        'username': 'A 呵呵',
        'id': 4,
        'userDesc': '干嘛,呵呵, 去洗澡',
        'lastTime': '10.20',
        'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
        'backgroundUrl':
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=2189213cef3d70c482f52359d2727d15&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F810a19d8bc3eb13584856f6fac1ea8d3fc1f44a0.jpg'
      },
      {
        'username': 'A Dj',
        'id': 5,
        'userDesc': '如果我是Dj你会爱我吗',
        'lastTime': '19.28',
        'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
        'backgroundUrl': ''
      }
    ],
    'B': [
      {
        'username': 'B kuaifengle',
        'id': 1,
        'userDesc': 'git',
        'lastTime': '20.11',
        'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
        'backgroundUrl':
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=cbe8bb555ee75a64d442738db9cb4e01&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D5f1716e99a529822113e3180bfa311be%2F730e0cf3d7ca7bcb1372ed01b4096b63f624a896.jpg'
      },
      {
        'username': 'B Only',
        'id': 2,
        'userDesc': '砖石一颗即永恒',
        'lastTime': '16.18',
        'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
        'backgroundUrl': ''
      },
      {
        'username': 'B 哈哈',
        'id': 3,
        'userDesc': '呵呵',
        'lastTime': '24.00',
        'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
        'backgroundUrl': ''
      },
      {
        'username': 'B 呵呵',
        'id': 4,
        'userDesc': '干嘛,呵呵, 去洗澡',
        'lastTime': '10.20',
        'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
        'backgroundUrl': ''
      },
      {
        'username': 'B Dj',
        'id': 5,
        'userDesc': '如果我是Dj你会爱我吗',
        'lastTime': '19.28',
        'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
        'backgroundUrl': ''
      }
    ],
    'C': [
      {
        'username': 'C kuaifengle',
        'id': 1,
        'userDesc': 'git',
        'lastTime': '20.11',
        'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
        'backgroundUrl': ''
      },
      {
        'username': 'C Only',
        'id': 2,
        'userDesc': '砖石一颗即永恒',
        'lastTime': '16.18',
        'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
        'backgroundUrl': ''
      },
      {
        'username': 'C 哈哈',
        'id': 3,
        'userDesc': '呵呵',
        'lastTime': '24.00',
        'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
        'backgroundUrl': ''
      },
      {
        'username': 'C 呵呵',
        'id': 4,
        'userDesc': '干嘛,呵呵, 去洗澡',
        'lastTime': '10.20',
        'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
        'backgroundUrl': ''
      },
      {
        'username': 'C Dj',
        'id': 5,
        'userDesc': '如果我是Dj你会爱我吗',
        'lastTime': '19.28',
        'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
        'backgroundUrl': ''
      }
    ],
  };

  final SlidableController _slidableController = new SlidableController();
  var _scrollController = new ScrollController();

  // ============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: new Stack(
            children: <Widget>[
              new CustomScrollView(controller: _scrollController, slivers: bodyWidgetList()),
            ],
          ),
    ));
  }

  // ============================
  bodyWidgetList() {
    List widgetList = <Widget>[
      // linglg：搜索栏
      new SliverToBoxAdapter(
        child: new GestureDetector(
          child: new Container(
              height: 50.0,
              color: new Color(0xFFefeef3),
              child: ListTile(
                leading: IconButton(
                  padding: EdgeInsets.all(0.0),
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: new Text('Search'),
                trailing: Icon(Icons.search, color: Color(0xFF61ab32)),
              )),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new SearchPage()));
          },
        ),
      )
    ];

    // 好友列表
    for (var i = 0; i < _a2z.length; i++) {
      if (_userGroupMap[_a2z[i]] != null && _userGroupMap[_a2z[i]].length > 0) {
        widgetList.add(userGroup_sshBuilder(_a2z[i], i));
      } else {
        continue;
      }
    }
    return widgetList;
  }

  // linglg：name：组名。index：组序号。
  userGroup_sshBuilder(name, index) {
    return new SliverStickyHeaderBuilder(
      builder: (context, state) {
        // linglg：组名
        return userGroup_headerWidget(context, state, name);
      },
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
          (context, i) {
            return userItemWidget(context, i, name);
          },
          childCount: _userGroupMap[name].length,
        ),
      ),
    );
  }

  // linglg：组名
  userGroup_headerWidget(context, state, name) {
    return new Container(
      height: 34.0,
      color: (state.isPinned ? Color(0xFF94c875) : Color(0xFFc5c5cf)).withOpacity(1.0 - state.scrollPercentage),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: new Text(
        '${name}',
        style: const TextStyle(color: Color(0xFFffffff), fontWeight: FontWeight.bold),
      ),
    );
  }

  userItemWidget(context, i, name) {
    var item = _userGroupMap[name][i];
    //
    return new GestureDetector(
      // linglg：左右滑动
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
            subtitle: new Text('${item['userDesc']}'),
            trailing: new Text('${item['lastTime']}'),
          ),
        ),
        // linglg：左滑，右侧操作按钮
        secondaryActions: <Widget>[
          new IconSlideAction(
              caption: '消息',
              color: Color(0xFF61ab32),
              icon: Icons.message,
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new ChatPage(detail: item)));
              }),
          new IconSlideAction(
            caption: '删除',
            color: Color(0xFFf76767),
            icon: Icons.delete_outline,
            onTap: () => _showSnackBar('Delete'),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new UserDetailPage(detail: item);
        }));
      },
    );
  }

  _showSnackBar(val) {
    print(val);
  }
}
