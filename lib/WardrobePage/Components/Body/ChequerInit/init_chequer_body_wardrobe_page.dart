import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
//import 'package:small_dimple/Config/index.dart';
//import 'package:small_dimple/WardrobePage/Components/Body/Util/util_body.dart';
import '../Util/util_body.dart';
import '../Chequer/chequer_body_wardrobe_page.dart';
import '../Chequer/dragcontroller_body_wardrobe_page.dart';

class ChequerInit extends StatefulWidget {
  final AnimationController chequerMoveAnimationController;
  final Animation<double> chequerMoveAnimation;
  final AnimationController buildAnimationController;
  final Animation<double> buildAnimation;
  final DragController dragController;
  final String? path;
  final BodyUtil bodyUtil;
  final int itemId; //物品id
  final int boxId; //盒子id
  final int chequerIndex; //第几个盒子
  final Offset startOffset;
  final Offset targetOffset;
  //final bool isInDrag;

  const ChequerInit(
      {Key? key,
      this.path,
      required this.bodyUtil,
      required this.boxId,
      required this.chequerIndex,
      required this.startOffset,
      required this.targetOffset,
      required this.buildAnimationController,
      required this.chequerMoveAnimationController,
      required this.chequerMoveAnimation,
      required this.itemId,
      required this.buildAnimation,
      required this.dragController
      //required this.isInDrag
      })
      : super(key: key);

  @override
  _ChequerInitState createState() => _ChequerInitState();
}

class _ChequerInitState extends State<ChequerInit> {
  bool _isInDrag = false;
  bool get isInDrag => _isInDrag;
  void setIsInDrag(bool i) {
    _isInDrag = i;
  }

  void refreshUi() {
    setState(() {});
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

  Offset _startOffset = Offset.zero;
  Offset get startOffset => _startOffset;
  void setStartOffset(Offset i) {
    _startOffset = i;
  }

  Offset _targetOffset = Offset.zero;
  Offset get targetOffset => _targetOffset;
  void setTargetOffset(Offset i) {
    _targetOffset = i;
  }

  //位于第几个盒子,拖拽后格子发生变化，boxIndex表示位于第几个格子，提交后只根据boxIndex修改数据position,
  //上一层list刷新后还是原来的格子，只是存放的数据不一样，
  //在拖拽时虽然格子位移，但通过boxInde表明是第几个格子，刷新后格子是会回到原来的位置显示新的数据，
  int _chequerIndex = 0;
  int get chequerIndex => _chequerIndex;
  void setChequerIndex(int i) {
    _chequerIndex = i;
  }

  @override
  void initState() {
    super.initState();
  }

  void init() {
    widget.path != null ? setIsSpace(false) : setIsSpace(true);
    setIsInDrag(widget.bodyUtil.allDragStatus == 1 ? true : false);
    setItemId(widget.itemId);
    setBoxId(widget.boxId);
    setStartOffset(widget.startOffset);
    setTargetOffset(widget.targetOffset);
    setChequerIndex(widget.chequerIndex);
    //---注册方法----
    //widget.bodyUtil.addRefreshChequer(refreshUi);
    //widget.bodyUtil.addSetIsInDrag(setIsInDrag);
    //widget.bodyUtil.addSetIsSapce(setIsSpace);
    //widget.bodyUtil.addSetItemId(setItemId);
    //print('chequer init');
  }

  @override
  Widget build(BuildContext context) {
    init();
    //print(isInDrag);

    //widget.width ?? setWidth((MediaQuery.of(context).size.width - 24 * 4)/3);
    return Chequer(
      animationController: widget.chequerMoveAnimationController,
      buildAnimationController: widget.buildAnimationController,
      animation: widget.chequerMoveAnimation,
      buildAnimation: widget.buildAnimationController,
      dragController: widget.dragController,
      isInDrag: isInDrag,
      isSpace: isSpace,
      path: widget.path == null ? '' : widget.path!,
      startOffset: startOffset,
      targetOffset: targetOffset,
      itemId: itemId,
      boxId: boxId,
      bodyUtil: widget.bodyUtil,
      chequerIndex: chequerIndex,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // print( 'dispose');
  }
}
