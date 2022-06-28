import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IndexPage/index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //锁定竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //状态栏主题
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return const MaterialApp(
        title: 'Small Dimple',
        debugShowCheckedModeBanner: false,
        home: IndexPage());
  }
}
