import 'package:flutter/material.dart';
import './Components/Body/body.dart';

//import 'package:small_dimple/config/index.dart';
import '../Config/index.dart';
import './Components/Toolbar/toolbar.dart';
import '../WardrobePage/PageUtil/util_page.dart';
//import './ViewModel/wardrobe_page_viewmodel.dart';
import '../WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';

class FutureWardrobePage extends StatefulWidget {
  final WardrobePageViewModel viewModel;
  final AnimationController animationController;
  final PageUtil pageUtil;

  const FutureWardrobePage(
      {Key? key,
      required this.viewModel,
      required this.animationController,
      required this.pageUtil})
      : super(key: key);

  @override
  State<FutureWardrobePage> createState() => _FutureWardrobePageState();
}

class _FutureWardrobePageState extends State<FutureWardrobePage> {

  late Future<int> data;

  @override
  void initState() {
    super.initState();
    data = widget.viewModel.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: KColor.backgroundColor,
      appBar: ToolBar(
        paddingHeight: MediaQuery.of(context).padding.top,
        viewModel: widget.viewModel,
        pageUtil: widget.pageUtil,
      ),
      body: FutureBuilder<int>(
          future: data,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('none');

              case ConnectionState.waiting:
                //后期需要添加等待页
                return const Text('waiting');

              case ConnectionState.active:
                return const Text('active');

              case ConnectionState.done:
                if (snapshot.hasError) {
                  //请求失败，添加从新刷新控件
                  return const Text('ddddk');
                } else {
                  return Body(
                    paddingTopHeight: MediaQuery.of(context).padding.top,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        48,
                    animationController: widget.animationController,
                    viewModel: widget.viewModel,
                    boxId: 0,
                    pageUtil: widget.pageUtil,
                  );
                }
              default:
                return const Text('Unkonwn state');
            }
          }),
    );
  }
}
