import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
import '../../../../../../Config/index.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/CustonIconButton/custom_iconbutton.dart';
import '../../../../../Components/Toolbar/CustonIconButton/custom_Iconbutton.dart';
//import 'package:small_dimple/WardrobePage/Config/config_toolbar.dart';
import '../../../../../Config/config_toolbar.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../Toolbar/ToolbarUtil/util_toolbar.dart';

class FloatIcon extends StatefulWidget {
  final ToolBarUtil toolBarUtil;
  final AnimationController iconPositionAnimationController;
  final String category;
  final double dx;
  final double dy;
  final int controlId;
  //final double targetDx;
  //final double targetDy;

  const FloatIcon(
      {Key? key,
      required this.category,
      required this.toolBarUtil,
      required this.dx,
      required this.dy,
      required this.iconPositionAnimationController,
      required this.controlId //required this.targetDx, required this.targetDy
      })
      : super(key: key);

  @override
  _FloatIconState createState() => _FloatIconState();
}

class _FloatIconState extends State<FloatIcon> {
  String iconPath = '';
  late Animation animation;

  int _controlId = 0;
  int get controlId => _controlId;

  void setControlId(int i) {
    _controlId = i;
  }

  int getControlId() {
    return _controlId;
  }

  @override
  void initState() {
    super.initState();
    //print(widget.controlId);
    setControlId(widget.controlId);

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.iconPositionAnimationController,
        curve: const Interval(0, 1.0, curve: Curves.ease)));
    _x = widget.dx;
    _y = widget.dy;
    iconPath = ToolBarConfig.iconMapping(widget.category);
    widget.toolBarUtil.setUpdateDragPosition(setPosition);
    widget.toolBarUtil.setRemoveTargetFun(setRemoveTarget);
    widget.toolBarUtil.setFuncSetControlId(setControlId);
    widget.toolBarUtil.setFuncGetControlId(getControlId);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          top: widget.iconPositionAnimationController.isAnimating
              ? (y - iconRemoveTargetY) * (1 - animation.value) +
                  iconRemoveTargetY
              : widget.iconPositionAnimationController.isCompleted
                  ? iconRemoveTargetY
                  : y,
          left: widget.iconPositionAnimationController.isAnimating
              ? (x - iconRemoveTargetX) * (1 - animation.value) +
                  iconRemoveTargetX
              : widget.iconPositionAnimationController.isCompleted
                  ? iconRemoveTargetX
                  : x,
          child: Container(
            width: 24 + 18,
            height: 24 + 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: KColor.containerColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [KShadow.shadow]),
            child: Container(
              height: 24,
              width: 24,
              //margin: const EdgeInsets.symmetric(horizontal: 9),
              alignment: Alignment.center,
              child: CustomIconButton(
                  isEnable: true,
                  color: Colors.black,
                  iconPath: iconPath), //需要加入点击滚动，按紧进入切换图标方法
            ),
          ),
        );
      },
    );
  }

  double _x = 0;
  double _y = 0;

  double get x => _x;
  double get y => _y;

  void setPosition(double x, double y) {
    if (mounted) {
      _x = x - (24 + 18) / 2;
      _y = y - (24 + 18) / 2;
      setState(() {});
    }
  }

  double _iconRemoveTargetX = 0;
  double _iconRemoveTargetY = 0;

  double get iconRemoveTargetX => _iconRemoveTargetX;
  double get iconRemoveTargetY => _iconRemoveTargetY;

  void setRemoveTarget(double x, double y) {
    if (mounted) {
      _iconRemoveTargetX = x;
      _iconRemoveTargetY = y;
    }
  }
}
