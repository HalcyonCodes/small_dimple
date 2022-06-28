import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/CustonIconButton/animated_custom_iconbutton.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../../Config/index.dart';
import '../../../Toolbar/CustonIconButton/animated_custom_iconbutton.dart';
//import '../../../Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../../WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import './Conmponents/animated_searchpicker_middlepicker_toolbar.dart';
import '../../../../ViewModel/wardrobe_page_viewmodel.dart';

class SearchMiddlePickerToolBar extends StatelessWidget {
  final AnimationController animationController;
  final ToolBarUtil toolBarUtil;
  final WardrobePageViewModel viewModel;
  final FocusNode verifyNode = FocusNode();

  SearchMiddlePickerToolBar(
      {Key? key,
      required this.animationController,
      required this.toolBarUtil,
      required this.viewModel})
      : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      animationController.reset();
      await animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 24 * 2 - 16 * 2,
      height: 30,
      color: KColor.containerColor,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCustomIconButton(
            animationController: animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/放大镜.svg',
            isEnable: false,
            color: Colors.black,
            onClick: () {},
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: AnimatedSearchPicker(
              animationController: animationController,
              verifyNode: verifyNode,
              animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animationController,
                      curve: const Interval((1 / 3) * 1, 1.0,
                          curve: Curves.fastOutSlowIn))),
            ),
          ),

          //Expanded(child: SizedBox(),),
          const SizedBox(
            width: 16,
          ),
          AnimatedCustomIconButton(
            animationController: animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/向左.svg',
            isEnable: true,
            color: Colors.black,
            onClick: () {
              verifyNode.unfocus();
              animationController.reverse().then((value) {
                toolBarUtil.setStatus!(0);
                toolBarUtil.setToolBarStatus(0);
                toolBarUtil.refreshToolBar!();
              });
            },
          )
        ],
      ),
    );
  }
}
