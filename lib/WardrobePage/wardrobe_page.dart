import 'package:flutter/material.dart';

import './ViewModel/wardrobe_page_viewmodel.dart';
import './future_wardrobe_page.dart';
import './PageUtil/util_page.dart';

import '../Config/config_chequer_position.dart';

class WardrobePage extends StatefulWidget {
  final WardrobePageViewModel viewModel = WardrobePageViewModel();
  // final PageController pageController = PageController();

  WardrobePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final PageUtil pageUtil = PageUtil();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    pageUtil.setScreenWidth(MediaQuery.of(context).size.width);
    ChequerPosition.setScreenWidth(MediaQuery.of(context).size.width);
    ChequerPosition.setScreenHeight(MediaQuery.of(context).size.height);
    ChequerPosition.setScreenPaddingTop(MediaQuery.of(context).padding.top);
    ChequerPosition.setWidgetHeight();
    ChequerPosition.setBoxWidth();
    ChequerPosition.buildChequerPosition();
    ChequerPosition.setTopHeight();
    ChequerPosition.setRowData();

    return FutureWardrobePage(
      viewModel: widget.viewModel,
      animationController: animationController!,
      pageUtil: pageUtil,
      //pageController: widget.pageController,
    );
  }
}
