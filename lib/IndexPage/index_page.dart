import 'package:flutter/material.dart';
import '../WardrobePage/wardrobe_page.dart';



class IndexPage extends StatefulWidget {
  const IndexPage({ Key? key }) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  
  List<Widget> bodies = [
    WardrobePage(),
  ];


  @override
  Widget build(BuildContext context) {

    return IndexedStack(
      children: bodies,
    );
  }
}