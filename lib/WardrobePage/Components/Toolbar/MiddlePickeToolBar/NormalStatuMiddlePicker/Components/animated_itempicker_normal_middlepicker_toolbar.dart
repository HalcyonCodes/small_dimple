import 'package:flutter/material.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../ToolbarUtil/util_toolbar.dart';

import './itempicker_normal_middlepicker_toolbar.dart';
//import 'package:small_dimple/WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
import '../../../../../../WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';

class AnimatedItemPicker extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final double width;
  final ToolBarUtil toolBarUtil;
  final WardrobePageViewModel viewModel;
  const AnimatedItemPicker(
      {Key? key,
      required this.animationController,
      required this.animation,
      required this.width,
      required this.toolBarUtil,
      required this.viewModel})
      : super(key: key);

  @override
  _AnimatedItemPickerState createState() => _AnimatedItemPickerState();
}

class _AnimatedItemPickerState extends State<AnimatedItemPicker> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              FadeTransition(
                opacity: widget.animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        30 * (1.0 - widget.animation.value), 0.0, 0.0),
                    child: ItemPicker(
                      scrollInitOffset:
                          widget.toolBarUtil.scrollPositionBeforeSwitchStatus,
                      viewModel: widget.viewModel,
                      toolBarUtil: widget.toolBarUtil,
                      dWidth: widget.width,
                    )),
              ),
            ],
          );
        });
  }
}
