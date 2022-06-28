import 'package:flutter/material.dart';

import '../Util/util_body.dart';
import '../AnimatedChequer/animated_chequer_body_wardrobe_page.dart';
import '../../../../Config/config_chequer_position.dart';
import './dragcontroller_body_wardrobe_page.dart';
import 'dart:async';

//控制单元，用于控制其移动之类操作
class Chequer extends StatefulWidget {
  final AnimationController animationController;
  final AnimationController buildAnimationController;
  final Animation<double> animation;
  final Animation<double> buildAnimation;
  final DragController dragController;
  final bool isSpace;
  final bool isInDrag;
  final String path;
  final Offset startOffset;
  final Offset targetOffset;
  final int chequerIndex;
  final int boxId;
  final int itemId;
  final BodyUtil bodyUtil;

  const Chequer({
    Key? key,
    required this.animationController,
    required this.buildAnimationController,
    required this.buildAnimation,
    required this.animation,
    required this.dragController,
    required this.isInDrag,
    required this.isSpace,
    required this.path,
    required this.startOffset,
    required this.targetOffset,
    required this.chequerIndex,
    required this.boxId,
    required this.itemId,
    required this.bodyUtil,
  }) : super(key: key);

  @override
  State<Chequer> createState() => _ChequerState();
}

class _ChequerState extends State<Chequer> {
  bool _isInDrag = false;
  bool get isInDrag => _isInDrag;
  void setIsInDrag(bool i) {
    _isInDrag = i;
  }

  bool _isSpace = false;
  bool get isSpace => _isSpace;
  void setIsSpace(bool i) {
    _isSpace = i;
  }

  int _itemId = 0;
  int get itemId => _itemId;
  void setItemId(int i) {
    _itemId = i;
  }

  int getItemId() {
    return itemId;
  }

  int _boxId = 0;
  int get boxId => _boxId;
  void setBoxId(int i) {
    _boxId = i;
  }

  int getBoxId() {
    return boxId;
  }

  //存放排序时位于哪个格子
  int _boxSortId = 0;
  int get boxSortId => _boxSortId;
  void setBoxSortId(int boxId) {
    _boxSortId = boxId;
  }

  //返回排序盒子id
  int getBoxSortId() {
    return boxSortId;
  }

  //存放排序id
  int _sortIndex = 0;
  int get sortIndex => _sortIndex;
  void setSortIndex(int i) {
    _sortIndex = i;
  }

  int getSortIndex() {
    return sortIndex;
  }

  Offset _currentOffset = Offset.zero;
  Offset get currentOffset => _currentOffset;
  void setCurrentOffset(Offset i) {
    _currentOffset = i;
  }

  Offset getCurrentOffset() {
    return _currentOffset;
  }

  Offset _startOffset = Offset.zero;
  Offset get startOffset => _startOffset;
  void setStartOffset(Offset i) {
    _startOffset = i;
  }

  Offset _targetOffset = Offset.zero;
  Offset get targetOffset => _targetOffset;
  void setTargetOffset(Offset i) {
    _targetOffset = i;
    //widget.bodyUtil.updateChequerTargetOffsetByBox(boxId, chequerIndex, i);
  }

  int getChequerIndex() {
    return widget.chequerIndex;
  }

  //void setTargetOffsetWhenInit(Offset i)
  // {
  //  _targetOffset = i;
  //}

  void refreshUi() {
    setIsRefreshFromUtil(true);

    setState(() {});
  }

  bool _isRefreshFromUtil = false;
  bool get isRefreshFromUtil => _isRefreshFromUtil;
  void setIsRefreshFromUtil(bool i) {
    _isRefreshFromUtil = i;
  }

  GlobalKey key = GlobalKey();

  //存放图标内点击的位置的坐标
  double _localX = 0;
  double get localX => _localX;
  void setLocalX(double i) {
    _localX = i;
  }

  double _localY = 0;
  double get localY => _localY;
  void setLocalY(double i) {
    _localY = i;
  }

  //位于第几个盒子,拖拽后格子发生变化，boxIndex表示位于第几个格子，提交后只根据boxIndex修改数据position,
  //上一层list刷新后还是原来的格子，只是存放的数据不一样，
  //在拖拽时虽然格子位移，但通过boxInde表明是第几个格子，刷新后格子是会回到原来的位置显示新的数据，
  int _chequerIndex = 0;
  int get chequerIndex => _chequerIndex;
  void setChequerIndex(int i) {
    _chequerIndex = i;
  }

  /*Future<void> chequerMoveAnimationStart() async {
    //widget.chequerMoveAnimationController!.forward();
    widget.animationController.forward();
  }

  void chequerMoveAnimationReset() {
    //widget.chequerMoveAnimationController!.reset();
    widget.animationController.reset();
  }

  void chequerMoveAnimationStop() {
    widget.animationController.stop();
  }*/

  //--
  Timer? timer;

  init() {
    setIsSpace(widget.isSpace);
    setIsInDrag(widget.isInDrag); //
    setItemId(widget.itemId);
    setBoxId(widget.boxId);
    setStartOffset(widget.startOffset);
    setChequerIndex(widget.chequerIndex);
    setTargetOffset(widget.targetOffset);
    setSortIndex(widget.chequerIndex);
    //setTargetOffsetWhenInit(widget.targetOffset);
    //widget.bodyUtil.setChequerTargetOffsetByBox(boxId, chequerIndex, targetOffset);
    //---注册方法----
    //widget.bodyUtil.addRefreshChequer(refreshUi);
    //widget.bodyUtil.addSetIsInDrag(setIsInDrag);
    //widget.bodyUtil.addSetIsSapce(setIsSpace);
    //widget.bodyUtil.addSetItemId(setItemId);
    widget.bodyUtil
        .setFuncSubListRefreshChequerByOne(refreshUi, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListSetIsInDragByOne(setIsInDrag, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListSetIsSpaceByOne(setIsSpace, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListSetItemIdByOne(setItemId, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListSetPositionByOne(setPosition, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListSetStartOffsetByOne(setStartOffset, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListSetCurrentOffsetByOne(
        setCurrentOffset, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListSetTargetOffsetByOne(
        setTargetOffset, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListSetSortIndexByOne(setSortIndex, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListGetCurrentOffsetByOne(
        getCurrentOffset, boxId, chequerIndex);
    widget.bodyUtil
        .setFuncSubListGetSortIndexByOne(getSortIndex, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListSetBoxIdByOne(setBoxId, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListGetBoxIdByOne(getBoxId, boxId, chequerIndex);
    /*widget.bodyUtil.setFuncSubListStartAnimationByOne(chequerMoveAnimationStart, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListResetAnimationByOne(chequerMoveAnimationReset, boxId, chequerIndex);
    widget.bodyUtil.setFuncSubListStopAnimationByOne(chequerMoveAnimationStop, boxId, chequerIndex);*/
    //print('chequer init');
    //--------------------------
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isRefreshFromUtil ? () {} : init();

    setIsRefreshFromUtil(false);

    return AnimatedChequer(
      key: key,
      chequerId: chequerIndex,
      bodyUtil: widget.bodyUtil,
      boxId: boxId,
      buildAnimation: widget.buildAnimation,
      buildAnimationController: widget.buildAnimationController,
      animationController: widget.animationController,
      animation: widget.animation,
      isInDrag: isInDrag,
      isSpace: isSpace,
      path: widget.path,
      startOffset: startOffset,
      targetOffset: targetOffset,
      onLongPress: widget.bodyUtil.allDragStatus == 0 ? onLongPress : null,
      onLongPressEnd: onLongPressEnd,
      onLongPressMoveUpdate:
          widget.bodyUtil.allDragStatus == 1 ? onLongPressMoveUpdate : null,
      onLongPressStart: onLongPressStart,
      //onPanStart: onPanStart,
      //onPanUpdate: onPanUpdate,
      //onPanEnd: onPanEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
    );
  }

  //void onTapDown(TapDownDetails details){
  //按下之后锁住pageView,使得左右拖拽信息不被pageview捕获，拖拽开始后就解锁pageview
  //print('ontag');

  //}

  void onLongPressStart(LongPressStartDetails details) {
    //print('pressstart');
    //widget.bodyUtil.setPageScroll!(false);
    setLocalX(details.localPosition.dx);
    setLocalY(details.localPosition.dy);
  }

  void onLongPress() {
    //print('按住');
    //print(boxId);

    if (widget.bodyUtil.allDragStatus == 0) {
      widget.bodyUtil.setAllDragStatus(1); //设置全局状态为1
      for (int j = 0; j <= widget.bodyUtil.listSetIsInDrag.length - 1; j++) {
        for (int i = 0;
            i <= widget.bodyUtil.listSetIsInDrag[j].length - 1;
            i++) {
          widget.bodyUtil.listSetIsInDrag[j][i]!(true);
        }
        for (int i = 0;
            i <= widget.bodyUtil.listRefreshChequer[j].length - 1;
            i++) {
          widget.bodyUtil.listRefreshChequer[j][i]!();
        }
      }
    }
  }

  void onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    if (widget.bodyUtil.allDragStatus == 1) {
      widget.bodyUtil.setPageScroll!(true);
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onLongPressEnd(LongPressEndDetails details) {
    widget.bodyUtil.setPageScroll!(true);
  }

  /*void onPanStart( DragStartDetails details){
    print('panstart');
    //获得点击时在图标的位置
     if(widget.bodyUtil.allDragStatus == 1){
      //widget.bodyUtil.setPageScroll!(false);
      widget.bodyUtil.setPageScroll!(true);
    }
  }
  
  void onPanUpdate(DragUpdateDetails details){
    print('panundate');
    if(widget.bodyUtil.allDragStatus == 1){
      
      setPosition(details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }
  
  void onPanEnd(DragEndDetails details){
    widget.bodyUtil.setPageScroll!(true);
    print('panEnd');
  }*/

  void onVerticalDragDown(DragDownDetails details) {
    //print('verdown');

    if (widget.bodyUtil.allDragStatus == 1) {
      setLocalX(details.localPosition.dx);
      setLocalY(details.localPosition.dy);
      widget.bodyUtil.setPageScroll!(false);
      widget.dragController.setInitBoxId(boxId);
      widget.dragController.setInitChequerId(chequerIndex);
      widget.dragController.setStartIndexFromChequerId(boxId, chequerIndex);
      //Offset offset = Offset(details.globalPosition.dx, details.globalPosition.dy - ChequerPosition.topHeight + widget.bodyUtil.boxListScrollControllers[boxId].position.pixels );
      //widget.dragController.setStartOffset(offset);
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onVerticalDragStart(DragStartDetails details) {
    //print('verStart');

    if (widget.bodyUtil.allDragStatus == 1) {
      widget.bodyUtil.setPageScroll!(true);
      widget.dragController.setInitBoxId(boxId);
      widget.dragController.setInitChequerId(chequerIndex);
      widget.dragController.setStartIndexFromChequerId(boxId, chequerIndex);
      //Offset offset = Offset(details.globalPosition.dx, details.globalPosition.dy - ChequerPosition.topHeight + widget.bodyUtil.boxListScrollControllers[boxId].position.pixels );
      //widget.dragController.setStartOffset(offset);
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (widget.bodyUtil.allDragStatus == 1) {
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onVerticalDragCancel() {
    if (widget.bodyUtil.allDragStatus == 1) {
      widget.bodyUtil.setPageScroll!(true);
      //setLocalX(0);
      //setLocalY(0);
    }
  }

  void onVerticalDragEnd(DragEndDetails details) {
    if (widget.bodyUtil.allDragStatus == 1) {
      //print('vDragEnd');
      widget.bodyUtil.setPageScroll!(true);
      //setLocalX(0);
      //setLocalY(0);
    }
  }

  void onHorizontalDragDown(DragDownDetails details) {
    //print('hordown');
    if (widget.bodyUtil.allDragStatus == 1) {
      setLocalX(details.localPosition.dx);
      setLocalY(details.localPosition.dy);
      widget.bodyUtil.setPageScroll!(false);
      widget.dragController.setInitBoxId(boxId);
      widget.dragController.setInitChequerId(chequerIndex);
      widget.dragController.setStartIndexFromChequerId(boxId, chequerIndex);
      //Offset offset = Offset(details.globalPosition.dx, details.globalPosition.dy - ChequerPosition.topHeight + widget.bodyUtil.boxListScrollControllers[boxId].position.pixels );
      //widget.dragController.setStartOffset(offset);
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onHorizontalDragStart(DragStartDetails details) {
    //print('horStart');
    if (widget.bodyUtil.allDragStatus == 1) {
      widget.bodyUtil.setPageScroll!(true);
      widget.dragController.setInitBoxId(boxId);
      widget.dragController.setInitChequerId(chequerIndex);
      widget.dragController.setStartIndexFromChequerId(boxId, chequerIndex);
      //Offset offset = Offset(details.globalPosition.dx, details.globalPosition.dy - ChequerPosition.topHeight + widget.bodyUtil.boxListScrollControllers[boxId].position.pixels );
      //widget.dragController.setStartOffset(offset);
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    //print (details.localPosition.dx);
    if (widget.bodyUtil.allDragStatus == 1) {
      setPosition(
          details.globalPosition.dx, details.globalPosition.dy, localX, localY);
    }
  }

  void onHorizontalDragCancel() {
    if (widget.bodyUtil.allDragStatus == 1) {
      widget.bodyUtil.setPageScroll!(true);
      //setLocalX(0);
      //setLocalY(0);
    }
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    if (widget.bodyUtil.allDragStatus == 1) {
      //print('hdragEnd');
      widget.bodyUtil.setPageScroll!(true);
      //setLocalX(0);
      //setLocalY(0);
    }
  }

  void setPosition(double x, double y, double localX, double localY) {
    //Offset offset = Offset(x, y - ChequerPosition.boxWidth);
    //print(x);
    //print('sss' + localX.toString());
    Offset offset = Offset(
        x - localX,
        y -
            ChequerPosition.topHeight +
            widget.bodyUtil.boxListScrollControllers[boxId].position.pixels -
            localY);
    //print(offset.dx);
    //print('sss' + offset.dy.toString());
    setTargetOffset(offset);
    //setCurrentOffset(offset);
    setStartOffset(offset);
    refreshUi();
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 200), () {
      //print('afterTimer='+DateTime.now().toString());
      Offset originOffset = Offset(
          x,
          y -
              ChequerPosition.topHeight +
              widget.bodyUtil.boxListScrollControllers[boxId].position
                  .pixels); //拖动图标的左上角
      widget.dragController.chequerMove(originOffset);
    });
  }
}
