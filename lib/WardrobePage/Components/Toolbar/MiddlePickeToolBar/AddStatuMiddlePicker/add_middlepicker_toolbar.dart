import 'package:flutter/material.dart';
import '../../../../../Config/index.dart';
import '../../CustonIconButton/animated_custom_iconbutton.dart';
import './Components/functionbuttom_add_middlepicker_toolbar.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
//import '../../../../Components/Toolbar/ToolbarUtil/util_toolbar.dart'
import '../../../../../WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../ViewModel/wardrobe_page_viewmodel.dart';

class AddMiddlePickerToolBar extends StatelessWidget {
  final ToolBarUtil toolBarUtil;
  final AnimationController animationController;
  final WardrobePageViewModel viewModel;

  AddMiddlePickerToolBar(
      {Key? key,
      required this.animationController,
      required this.toolBarUtil,
      required this.viewModel})
      : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 24 * 2 - 16 * 2,
      height: 48,
      color: KColor.containerColor,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          AnimatedCustomIconButton(
            animationController: animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/向左.svg',
            isEnable: true,
            color: Colors.black,
            onClick: () {
              animationController.reverse().then((value) {
                toolBarUtil.setStatus!(0);
                toolBarUtil.setToolBarStatus(0);
                toolBarUtil.refreshToolBar!();
              });
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: FunctionButtom(
            animationController: animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 1, 1.0,
                        curve: Curves.fastOutSlowIn))),
          )),
          //Expanded(child: SizedBox(),),
          const SizedBox(
            width: 20,
          ),
          AnimatedCustomIconButton(
            animationController: animationController,
            iconPath: 'assets/icons/systems/应用.svg',
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 3) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            isEnable: false,
            onClick: () {},
          )
        ],
      ),
    );
  }
}
