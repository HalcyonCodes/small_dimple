import 'package:flutter/material.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../Toolbar/ToolbarUtil/util_toolbar.dart';

class SizedSpace extends StatefulWidget {
  final double width;
  final double height;
  final ToolBarUtil toolBarUtil;
  SizedSpace(
      {Key? key,
      required this.width,
      required this.toolBarUtil,
      required this.height})
      : super(key: key);

  @override
  _SizedSpaceState createState() => _SizedSpaceState();
}

class _SizedSpaceState extends State<SizedSpace> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.toolBarUtil.refreshIsMid.add((b) {}); //给util添加置灰方法
    widget.toolBarUtil.addIconOffset(() {
      return Offset.zero;
    }); //给util添加获得位置方法
    widget.toolBarUtil.addIconCategory(() {
      return '';
    }); //给util添加获得分类方法
    widget.toolBarUtil.addHasIcon((b) {}); //是否显示icon图标
    widget.toolBarUtil.addIconMovIn(() async {});
    widget.toolBarUtil.addIconMovOut(() async {});
    widget.toolBarUtil.addIsSpaceStatus(() {}); //获得是否为留白
    widget.toolBarUtil
        .addIconAnimationControllers(AnimationController(vsync: this));
    widget.toolBarUtil.addGetWardrobeIds(() {
      return -1;
    });
    widget.toolBarUtil.addSetIsEmpty((b) {});
    widget.toolBarUtil.addSetIconIdInState((b) {});

    widget.toolBarUtil.addGetIconMovInStatus(() {
      return false;
    });
    widget.toolBarUtil.addSetIconMovInStatus((b) {});

    widget.toolBarUtil.addGetIconMovOutStatus(() {
      return false;
    });
    widget.toolBarUtil.addSetIconMovOutStatus((b) {});
    widget.toolBarUtil.addGetIsEmpty(() {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
    );
  }
}
