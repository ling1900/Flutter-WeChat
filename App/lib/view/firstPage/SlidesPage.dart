import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import 'FirstPage.dart';


class SlidesPage extends StatefulWidget {
  @override
  _SlidesPageState createState() => new _SlidesPageState();
}


class _SlidesPageState extends State<SlidesPage> {
  List<Slide> _slides = new List();

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this._slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }

  @override
  void initState() {
    super.initState();
    _slides.add(
      new Slide(
        title: "FLUTTER",
        description: "这是模仿的微信App, 纯属用于个人学习参考, 切勿用于商业用途",
        pathImage: 'assets/images/logo.png',
        backgroundColor: Color(0xff409EFF),
      ),
    );
    _slides.add(
      new Slide(
        title: "DART",
        description: "这是模仿的微信App, 纯属用于个人学习参考, 切勿用于商业用途",
        pathImage: 'assets/images/logo.png',
        backgroundColor: Color(0xffE6A23C),
      ),
    );
    _slides.add(
      new Slide(
        title: "WELECOME",
        description: "Open WeChat",
        pathImage: 'assets/images/logo.png',
        backgroundColor: Color(0xff909399),
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
        (route) => route == null);
  }

  void onSkipPress() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
        (route) => route == null);
  }
}
