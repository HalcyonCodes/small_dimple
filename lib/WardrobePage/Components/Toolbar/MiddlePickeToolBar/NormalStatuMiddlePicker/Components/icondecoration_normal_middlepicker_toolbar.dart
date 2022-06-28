import 'package:flutter/material.dart';
import '../../../../../../Config/index.dart';
import '../../../CustonIconButton/custom_iconbutton.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../../Config/config_toolbar.dart';

class IconDecoration extends StatefulWidget {
  //final ScrollController scrollController;
  final ToolBarUtil toolBarUtil;
  final String category;
  final bool isSpace; //判断是否为留白
  final int id;
  //final AnimationController? animationController;

  const IconDecoration(
      {Key? key,
      required this.id,
      required this.toolBarUtil,
      required this.category,
      required this.isSpace})
      : super(key: key);

  @override
  _IconDecorationState createState() => _IconDecorationState();
}

class _IconDecorationState extends State<IconDecoration>
    with TickerProviderStateMixin {
  late Animation animation;

  bool _isInMid = false;
  GlobalKey nKey = GlobalKey();

  bool _hasIcon = true; //是否显示icon
  bool _isEmpty = false; //是否保留空白位置
  bool _isSpace = false;

  late int _id;
  int get id => _id;
  void setWardrobeId(int id) {
    _id = id;
  }

  int getWardrobeId() {
    return id;
  }

  AnimationController? _animationController;
  AnimationController get animationController => _animationController!;
  void setAnimationController(AnimationController i) {
    _animationController = i;
  }

  void setHasIcon(bool i) {
    _hasIcon = i;
    if (mounted) {
      setState(() {});
    }
  }

  bool get hasIcon => _hasIcon;

  void setIsEmpty(bool i) {
    _isEmpty = i;
    //setState(() {});
  }

  bool get isEmpty => _isEmpty;

  bool getIsEmpty() {
    return isEmpty;
  }

  void setIsSpace(bool i) {
    _isSpace = i;
    if (isSpace) {
      setHasIcon(false);
      setIsEmpty(true);
    }
  }

  bool get isSpace => _isSpace;

  bool getIsSpace() {
    return isSpace;
  }

  @override
  void initState() {
    super.initState();
    setWardrobeId(widget.id);

    widget.toolBarUtil.refreshIsMid.add(refreshIsMid); //给util添加置灰方法
    widget.toolBarUtil.addIconOffset(getIconPosition); //给util添加获得位置方法
    widget.toolBarUtil.addIconCategory(getIconCategory); //给util添加获得分类方法
    widget.toolBarUtil.addHasIcon(setHasIcon); //是否显示icon图标
    widget.toolBarUtil.addIconMovIn(moveIn);
    widget.toolBarUtil.addIconMovOut(moveOut);
    widget.toolBarUtil.addIsSpaceStatus(getIsSpace); //获得是否为留白
    widget.toolBarUtil.addGetWardrobeIds(getWardrobeId);
    widget.toolBarUtil.addSetIsEmpty(setIsEmpty);
    widget.toolBarUtil.addSetIconIdInState(setWardrobeId);
    widget.toolBarUtil.addGetIconMovInStatus(getIsInMovIn);
    widget.toolBarUtil.addGetIconMovOutStatus(getIsInMovOut);

    widget.toolBarUtil.addSetIconMovInStatus(setIsInMovIn);
    widget.toolBarUtil.addSetIconMovOutStatus(setIsInMovOut);
    widget.toolBarUtil.addGetIsEmpty(getIsEmpty);

    setAnimationController(AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50)));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.linear)));
    widget.toolBarUtil.addIconAnimationControllers(animationController);

    if (widget.isSpace) {
      setIsSpace(true);
      animationController.value = 0.0; //!isCompleted
    } else {
      animationController.value = 1.0;
    }
    //print(animationController.isCompleted);
    //print(1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, snapshot) {
          return Container(
            key: nKey,
            width: animationController.isAnimating
                ? (24.0 + 18) * animation.value
                : animationController.isCompleted
                    ? 24 + 18
                    : 0,
            height: animationController.isAnimating
                ? (24.0 + 18) * animation.value
                : animationController.isCompleted
                    ? 24 + 18
                    : 0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: KColor.containerColor),
            child: SizedBox(
              width: animationController.isAnimating
                  ? (24.0) * animation.value
                  : animationController.isCompleted
                      ? 24
                      : 0,
              height: animationController.isAnimating
                  ? (24.0) * animation.value
                  : animationController.isCompleted
                      ? 24
                      : 0,
              child: hasIcon
                  ? CustomIconButton(
                      isEnable: true,
                      color: isInMid ? Colors.black : KColor.greyColor,
                      iconPath: ToolBarConfig.iconMapping(widget.category))
                  : SizedBox(
                      width: animationController.isCompleted ? 24 : 0,
                      height: animationController.isCompleted ? 24 : 0,
                    ),
            ),
          );
        });
  }

  void refreshIsMid(bool isInMid) {
    if (mounted) {
      _isInMid = isInMid;
      setState(() {});
    }
  }

  bool get isInMid => _isInMid;

  Offset getIconPosition() {
    RenderBox renderBox = nKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  String getIconCategory() {
    return widget.category;
  }

  Future<void> moveOut() async {
    if (!animationController.isCompleted) {
      animationController.value = 1.0;
      setIsEmpty(false);
    }
    if (animationController.isCompleted && isEmpty == false) {
      setIsInMovOut(true);
      await animationController.reverse().then((value) {
        setIsEmpty(true);
        setIsInMovOut(false);
      });
    }
  }

  Future<void> moveIn() async {
    if (animationController.isCompleted) {
      animationController.value = 0.0;
      setIsEmpty(true);
    }
    if (!animationController.isCompleted && isEmpty == true) {
      setIsInMovIn(true);
      await animationController.forward().then((value) {
        setIsEmpty(false);
        setIsInMovIn(false);
      });
    }
  }

  bool _isInMovIn = false;
  bool get isInMovIn => _isInMovIn;
  void setIsInMovIn(bool b) {
    _isInMovIn = b;
  }

  bool getIsInMovIn() {
    return isInMovIn;
  }

  bool _isInMovOut = false;
  bool get isInMovOut => _isInMovOut;
  void setIsInMovOut(bool b) {
    _isInMovOut = b;
  }

  bool getIsInMovOut() {
    return isInMovOut;
  }
}
