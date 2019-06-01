import 'package:flutter/material.dart';

import './view/firstPage//FirstPage.dart';
import './view/home/HomePage.dart';
import './view/sign/SignInPage.dart';

main() {
  return runApp(new MyWeChatApp());
}

// ========================
class MyWeChatApp extends StatefulWidget {
  @override
  _MyWeChatAppState createState() => new _MyWeChatAppState();
}


class _MyWeChatAppState extends State<MyWeChatApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter仿微信',
        theme: new ThemeData(
          primaryColorBrightness: Brightness.dark,
          primaryColor: const Color(0xFF64c223),
          hintColor: const Color(0xFFcfcfcf),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        home: new FirstPage(),
        routes: <String, WidgetBuilder>{ //
          '/home': (_) => new HomePage(), //
          '/signIn': (_) => new SignInPage() //
        });
  }
}
