import 'package:flutter/material.dart';

import '../../../ViewModel/wardrobe_page_viewmodel.dart';
import '../ChequerListPage/page_list_chequer_body_wardrobe.dart';
import '../../Body/Util/util_body.dart';

class GestureChequerListPage extends StatefulWidget {
  //final PageController pageController;
  final WardrobePageViewModel viewModel;
  final BodyUtil bodyUtil;
  final AnimationController animationController;
  final double height;
  final double paddingTopHeight;

  const GestureChequerListPage(
      {Key? key,
      required this.animationController,
      required this.bodyUtil,
      required this.viewModel,
      required this.paddingTopHeight,
      //required this.pageController,
      required this.height})
      : super(key: key);

  @override
  State<GestureChequerListPage> createState() => _GestureChequerListPageState();
}

class _GestureChequerListPageState extends State<GestureChequerListPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height - widget.paddingTopHeight - 48,
      child: SizedBox(
        /*onLongPressStart: onLongPressStart,
        onLongPress: onLongPress,
        onLongPressMoveUpdate: onLongPressMoveUpdate,
        onLongPressEnd: onLongPressEnd,
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,*/

        child: ChequerListPage(
          animationController: widget.animationController,
          viewModel: widget.viewModel,
          bodyUtil: widget.bodyUtil,
          //pageController: widget.pageController,
        ),
      ),
    );
  }

  void onLongPressStart(LongPressStartDetails details) {}

  void onLongPress() {}

  void onLongPressMoveUpdate(LongPressMoveUpdateDetails deatils) {}

  void onLongPressEnd(LongPressEndDetails deatils) {}

  void onPanStart(DragStartDetails details) {}

  void onPanUpdate(DragUpdateDetails details) {}

  void onPanEnd(DragEndDetails details) {}
}
