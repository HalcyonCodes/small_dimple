import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/CustonIconButton/animated_custom_iconbutton.dart';
import '../../../../../Config/index.dart';
//import '../../ToolbarUtil/util_toolbar.dart';
import '../../../../../WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../CustonIconButton/animated_custom_iconbutton.dart';
import '../NormalStatuMiddlePicker/Components/gesture_itempicker_normal_middlepicker_toolbar.dart';
import '../../../../ViewModel/wardrobe_page_viewmodel.dart';

//NormalMiddlePickerToolBar

class NormalMiddlePickerToolBar extends StatefulWidget {
  final AnimationController animationController;
  final ToolBarUtil toolBarUtil;
  final WardrobePageViewModel viewModel;

  const NormalMiddlePickerToolBar(
      {Key? key,
      required this.animationController,
      required this.toolBarUtil,
      required this.viewModel})
      : super(key: key);

  @override
  _NormalMiddlePickerToolBarState createState() =>
      _NormalMiddlePickerToolBarState();
}

class _NormalMiddlePickerToolBarState extends State<NormalMiddlePickerToolBar> {
  @override
  void initState() {
    super.initState();

    if (widget.toolBarUtil.pageUtil!.pageController!.page != null) {
      double scrollValue =
          widget.toolBarUtil.pageUtil!.pageValueTranslateScrollValue!(
              widget.toolBarUtil.pageUtil!.pageController!,
              widget.toolBarUtil.pageUtil!.screenWidth);
      widget.toolBarUtil.setScrollPositionBeforeSwitchStatus(scrollValue);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.animationController.forward();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        for (int i = 0; i <= widget.toolBarUtil.getIconListCount!() - 1; i++) {
          widget.toolBarUtil.refreshIsMid[i](false);
        }
        int iconIndex = widget.toolBarUtil.selectIconMid!();
        widget.toolBarUtil.setIconMid!(iconIndex);
        //double pageValue =  widget.toolBarUtil.pageUtil!.getPageControllerValue!();
      });
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
            animationController: widget.animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: const Interval((1 / 3) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/放大镜.svg',
            isEnable: true,
            color: Colors.black,
            onClick: () {
              //print(1);
              widget.animationController.reverse().then((value) {
                widget.toolBarUtil.setStatus!(1);
                widget.toolBarUtil.setToolBarStatus(1);
                widget.toolBarUtil.setScrollPositionBeforeSwitchStatus(null);
                widget.toolBarUtil.refreshToolBar!();
              });
            },
          ),
          const SizedBox(
            width: 20,
          ),
          GestureItemPicker(
            viewModel: widget.viewModel,
            width: width,
            animationController: widget.animationController,
            toolBarUtil: widget.toolBarUtil,
          ),
          const SizedBox(
            width: 20,
          ),
          AnimatedCustomIconButton(
            animationController: widget.animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: const Interval((1 / 3) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/加.svg',
            isEnable: true,
            color: KColor.auxiliaryColor,
            onClick: () {
              widget.animationController.reverse().then((value) {
                widget.toolBarUtil.setStatus!(2);
                widget.toolBarUtil.setToolBarStatus(2);
                widget.toolBarUtil.setScrollPositionBeforeSwitchStatus(null);
                widget.toolBarUtil.refreshToolBar!();
              });
            },
          )
        ],
      ),
    );
  }
}
