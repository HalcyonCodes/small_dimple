import 'package:flutter/material.dart';
//import 'package:SmallDimple/WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
//mport '../../../WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
import '../../../WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
//import './ChequerGesture/gesture_chequer_body_wardrobe_page.dart';
//import './ChequerGesture/gesture_chequer_body_wardrobe_page.dart';
import '../Body/ChequerGesture/gesture_chequer_body_wardrobe_page.dart';
import '../../../WardrobePage/PageUtil/util_page.dart';
import '../Body/Util/util_body.dart';

class Body extends StatefulWidget {
  final AnimationController animationController;
  final WardrobePageViewModel viewModel;
  final int boxId;
  final double height;
  final PageUtil pageUtil;
  final double paddingHeight;
  const Body({
    Key? key,
    required this.animationController,
    required this.viewModel,
    required this.boxId,
    //required this.pageController,
    required this.height,
    required this.pageUtil,
    required this.paddingHeight,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  BodyUtil? bodyUtil;

  @override
  void initState() {
    super.initState();
    bodyUtil = BodyUtil(pageUtil: widget.pageUtil);
    //widget.pageUtil.setFuncSetPageCtrollerValue(bodyUtil!.setPageControllerValue);
    bodyUtil!.setAllDragStatus(0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bodyUtil!.pageUtil.setFuncRefreshBoxList(bodyUtil!.refreshListInBox);
      bodyUtil!.pageUtil.setFuncRefreshBox(bodyUtil!.refreshBox!);
      bodyUtil!.pageUtil
          .setFuncGetPageControllerValue(bodyUtil!.getPagePositionValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height - widget.paddingHeight - 48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureChequerListPage(
            height: widget.height,
            animationController: widget.animationController,
            bodyUtil: bodyUtil!,
            viewModel: widget.viewModel,
          )
        ],
      ),
    );
  }
}
