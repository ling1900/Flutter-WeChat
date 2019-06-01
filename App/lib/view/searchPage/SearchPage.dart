import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
  // linglg：搜索历史
  Widget _searchHistoryListWrap;

  // linglg：文本框：搜索词
  var _search_textEditingController = new TextEditingController();
  var _search_focusNode = new FocusNode();

  // ===============================
  void initState() {
    super.initState();
    getAndUpdateSearchHistoryList();
  }

  void getAndUpdateSearchHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var arr = prefs.getString('searchList');

    var searchList = arr == null || arr.split(',') == null ? [] : arr.split(',');
    updateSearchHistoryList(searchList);
  }

  updateSearchHistoryList(searchList) {
    List<Widget> widgetList = [];

    for (var i = 1; i < searchList.length; i++) {
      var text = searchList[i];
      widgetList.add(new GestureDetector(
        child: new Container(
            height: 40.0,
            padding: new EdgeInsets.all(10.0),
            decoration: new BoxDecoration(color: Colors.black12, borderRadius: new BorderRadius.circular(10.0)),
            child: new Text(
              '${text}',
              style: new TextStyle(color: Colors.black),
            )),
        onTap: () {
          _search_textEditingController.value = new TextEditingValue(text: text);
        },
      ));
    }

    setState(() {
      _searchHistoryListWrap = new Wrap(
        spacing: 10.0, // gap between adjacent chips
        runSpacing: 6.0,
        children: widgetList,
      );
    });
  }

  // ===============================
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new ListView(
              children: <Widget>[
                searchBarWidget(),
                new Container(
                    margin: new EdgeInsets.all(10.0),
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Text('历史搜索', style: new TextStyle(color: Colors.black45, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('searchList', '');
                          getAndUpdateSearchHistoryList();
                        },
                      )
                    ])),
                new Container(padding: new EdgeInsets.all(10.0), child: _searchHistoryListWrap),
      ],
    )));
  }

  searchBarWidget() {
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: new TextField(
        focusNode: _search_focusNode,
        autofocus: false,
        decoration: new InputDecoration(
            icon: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _search_focusNode.unfocus();
                _search_textEditingController.clear();
                Navigator.of(context).pop();
              },
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                _search_textEditingController.clear();
                // var value = _searchController.text;
                // if (value != null && value != '') {
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                //   prefs.setString('searchList', prefs.getString('searchList') + ','+ value.toString());
                //   getAndBuildSearchHistoryList();
                // }
              },
            )),
        // linglg：由输入法的“回车”来触发提交
        onSubmitted: (String value) async {
          if (value != null && value != '') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var arr = prefs.getString('searchList');
            var searchList = arr == null || arr.split(',') == null ? '' : arr;
            prefs.setString('searchList', searchList + ',' + value.toString());
            getAndUpdateSearchHistoryList();
          }
        },
        controller: _search_textEditingController,
      ),
    );
  }
}
