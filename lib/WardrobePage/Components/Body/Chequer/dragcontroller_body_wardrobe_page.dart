import 'package:flutter/material.dart';

import '../../../../Config/config_chequer_position.dart';
//import 'package:small_dimple/WardrobePage/Components/Body/Util/util_body.dart';
import '../../../Components/Body/Util/util_body.dart';

class DragController {
  final BodyUtil bodyUtil;
  DragController({required this.bodyUtil}) {}

  //设置刚进来时拖拽的那个chequerId
  int _initChequerId = 0;
  int get initChequerId => _initChequerId;
  void setInitChequerId(int id) {
    _initChequerId = id;
  }

  //设置刚进来时拖拽的boxId
  int _initBoxId = 0;
  int get initBoxId => _initBoxId;
  void setInitBoxId(int boxId) {
    _initBoxId = boxId;
  }

  //选出那个需要播放移出动画的index，移出动画时所有格子向左移动
  Offset _startOffset = Offset.zero;
  Offset get startOffset => _startOffset;
  void setStartOffset(Offset i) {
    _startOffset = i;
    /*bodyUtil.chequerTargetOffsetByBox[boxId]!.keys.where((e)=>
      (i.dx >= bodyUtil.chequerTargetOffsetByBox[boxId]![e]!.dx  && i.dx <= bodyUtil.chequerTargetOffsetByBox[boxId]![e]!.dx + ChequerPosition.boxWidth)
      &&
      (i.dy >= bodyUtil.chequerTargetOffsetByBox[boxId]![e]!.dy  && i.dy <= bodyUtil.chequerTargetOffsetByBox[boxId]![e]!.dy + ChequerPosition.boxWidth)
    );

   _startOffset = ChequerPosition.chequerOffset.where((e) => 
      (i.dx >= e.dx  && i.dx <= e.dx + ChequerPosition.boxWidth)
        &&
      (i.dy >= e.dy  && i.dy <= e.dy + ChequerPosition.boxWidth)
    ).first;*/
  }

  //选出那个需要移入动画的index，移入动画时所有格子向右移动
  Offset _endOffset = Offset.zero;
  Offset get endOffset => _endOffset;
  void setEndOffset(Offset i) {
    _endOffset = i;
    /*_endOffset = ChequerPosition.chequerOffset.where((e) => 
      (i.dx >= e.dx-24  && i.dx <= e.dx + ChequerPosition.boxWidth)
        &&
      (i.dy >= e.dy-24  && i.dy <= e.dy + ChequerPosition.boxWidth)
    ).first;*/
  }

  //选出那个改变chequer的box
  int _spwandBoxIndex = 0;
  int get spwanBoxIndex => _spwandBoxIndex;
  void setSpwanBoxIndex(int i) {
    _spwandBoxIndex = i;
  }

  //获得当前的拖动的方块的左上角在屏幕的起始位置
  Offset _spwandOffset = Offset.zero;
  Offset get spwandOffset => _spwandOffset;
  void setSpwandOffset(Offset i) {
    _spwandOffset = i;
  }

  //根据chequerId得到排序id作为起始index
  int _startIndex = 0;
  int get startIndex => _startIndex;
  void setStartIndexFromChequerId(int boxId, int chequerId) {
    _startIndex = bodyUtil.searchChequerIndexBySortIndex(boxId, chequerId);
    setInitChequerId(chequerId);
  }

  //将sortIndex设置为startIndex
  void setStartIndex(int sortIndex) {
    _startIndex = sortIndex;
  }

  //将操作index里的sortIndex设置为endIndex
  void setInitIndexChequerToEndIndex(int initIndex) {
    //bodyUtil.listSetSortIndex[initBoxId][] lllddldldldl
  }

  //设置起始页
  int _startPage = 0;
  int get startPage => _startPage;
  void setStartPage(int page) {
    _startPage = page;
  }

  //设置目标页
  int _targetPage = 0;
  int get targetPage => _targetPage;
  void setTargetPage() {
    _targetPage = bodyUtil.pagePositionValue.toInt();
  }

  //计算得出拖拽结束的格子位置
  int _endIndex = 0;
  int get endIndex => _endIndex;

  void setEndIndex() {
    int targetPage = bodyUtil.pagePositionValue.toInt();

    //筛选出行个数
    int targetY = ChequerPosition.chequerOffset
        .where((e) =>
            //(spwandOffset.dy - ChequerPosition.topHeight + bodyUtil.boxListScrollControllers[targetPage].position.pixels + ChequerPosition.boxWidth)
            (spwandOffset.dy + ChequerPosition.boxWidth) >=
                (e.dy + ChequerPosition.boxWidth / 2) &&
            (e.dx) < ChequerPosition.rowData![1])
        .length;

    int targetX = ChequerPosition.rowData!
        .where((e) =>
            spwandOffset.dx + ChequerPosition.boxWidth >=
            e + ChequerPosition.boxWidth / 2)
        .length;

    //_endIndex = (targetY ) * 3 + (targetX ) - 1 ;
    _endIndex = (targetY - 1) * 3 + targetX - 1;
    if (_endIndex >= bodyUtil.listRefreshChequer[targetPage].length - 1) {
      _endIndex = bodyUtil.listRefreshChequer[targetPage].length - 1;
    }

    int a;
  }

  //保存改变targeOffset的index的列表，用于启动动画
  List<int> _changedChequerIndex = [];
  List<int> get changedChequerIndex => _changedChequerIndex;
  void setChangedChequerIndex(List<int> i) {
    _changedChequerIndex = i;
  }

  void addChangedChequerIndex(int i) {
    _changedChequerIndex.add(i);
  }

  //保存改变targetOffset的箱子page的列表，和changedTargetIndex一一对应
  List<int> _changedPageIndex = [];
  List<int> get changedPageIndex => _changedPageIndex;
  void setChangedPageIndex(List<int> i) {
    _changedPageIndex = i;
  }

  void addChangedPageIndex(int i) {
    _changedPageIndex.add(i);
  }

  //保存改变了的箱子的目标排序idsortIndex的列表，和changedTargetIndex一一对应
  List<int> _changedSortIndex = [];
  List<int> get changedSortIndex => _changedSortIndex;
  void setChangedSortIndex(List<int> i) {
    _changedSortIndex = i;
  }

  void addChangedSortIndex(int i) {
    _changedSortIndex.add(i);
  }

  void setChangeIndexNull() {
    setChangedChequerIndex([]);
    setChangedPageIndex([]);
    setChangedSortIndex([]);
  }

  //配置动画
  void setAnimatedTargetOffset() {
    //int targetPage = bodyUtil.pagePositionValue.toInt();
    //目标在当前盒子里
    if (startPage == targetPage) {
      //传入的是sortIndex
      bool isRight =
          (endIndex - startIndex) < 0 ? true : false; //从高位往低位的index拖拽时，所有图标向右挪动
      //print('endIndex' + endIndex.toString());
      //print('startIndex' + startIndex.toString());
      //print(isRight);
      for (int i = (isRight ? endIndex : startIndex + 1);
          i <= (isRight ? startIndex - 1 : endIndex);
          i++) {
        //print('gg');

        //通过sortIndex查index
        int chequerIndex = bodyUtil.searchChequerIndexBySortIndex(
            startPage, i); //传入的是sortIndex
        if (isRight) {
          //从高位往低位
          bodyUtil.listSetTargetOffset[startPage]
              [chequerIndex]!(ChequerPosition.chequerOffset[i + 1]);
          addChangedSortIndex(i + 1); //保存修改后的排序id
        } else {
          //从低位往高位
          bodyUtil.listSetTargetOffset[startPage]
              [chequerIndex]!(ChequerPosition.chequerOffset[i - 1]);
          addChangedSortIndex(i - 1); //保存修改后的排序id
        }

        addChangedPageIndex(startPage);
        addChangedChequerIndex(chequerIndex); //保存的是chequerId

        // print('ddd');
      }
    } else {
      //目标在其他盒子里
      //原有页播放移出动画，并把startIndex以后的所有格子全部向左移动
      for (int j = startIndex + 1;
          j <= bodyUtil.listRefreshChequer[startPage].length - 1;
          j++) {
        //用bodyutil.listRefreshChequer获得最大格子数
        int chequerIndex = bodyUtil.searchChequerIndexBySortIndex(startPage, j);
        bodyUtil.listSetTargetOffset[startPage]
            [chequerIndex]!(ChequerPosition.chequerOffset[j - 1]);
        addChangedSortIndex(j - 1);
        addChangedPageIndex(startPage);
        addChangedChequerIndex(chequerIndex);
      }

      //目标页播放转入动画，并把targetIndex以后的所有格子全部向右移动
      for (int k = endIndex + 1;
          k <= bodyUtil.listRefreshChequer[targetPage].length - 1;
          k++) {
        int chequerIndex = bodyUtil.searchChequerIndexBySortIndex(startPage, k);

        bodyUtil.listSetTargetOffset[targetPage]
            [chequerIndex]!(ChequerPosition.chequerOffset[k + 1]);

        addChangedSortIndex(k + 1);
        addChangedPageIndex(targetPage);
        addChangedChequerIndex(chequerIndex);
      }
    }

    int a;
  }

  //配置动画
  /*
  void setAnimatedTargetOffset(){
    
    //int targetPage = bodyUtil.pagePositionValue.toInt();
    //目标在当前盒子里
    setChangeTargetIndex([]);
    setChangePageIndex([]);

    if(startPage == targetPage){

      bool isRight = (endOffset.dy - startOffset.dy) < 0 && (endOffset.dx - startOffset.dx) < 0? true : false; //从高位往低位的index拖拽时，所有图标向右挪动
      //选出受影响的index
      if(isRight){
        //从高位往低位拖拽，
        List<int> effectIndex = bodyUtil.chequerTargetOffsetByBox[targetPage]!.keys.where((e)=>
          //第一层的图标
          ((bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dx + ChequerPosition.boxWidth / 2 >= endOffset.dx)
          && (endOffset.dy  <= bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy - 24)  
          && (endOffset.dy  >= bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy + ChequerPosition.boxWidth / 2)) 
          &&
          //第一层到最后一层中间
          ((bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy >= endOffset.dy + ChequerPosition.boxWidth / 2)&& (bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy <= startOffset.dy) )
          &&
          //最后一层
          ((bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dx + ChequerPosition.boxWidth / 2 <= startOffset.dx)
          && (startOffset.dy + ChequerPosition.boxWidth <= bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy + ChequerPosition.boxWidth)
          && (startOffset.dy + ChequerPosition.boxWidth >= bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy - ChequerPosition.boxWidth / 2))
        ).toList();
        
        setChangeTargetIndex(effectIndex);
        List<int> effectPage = List.generate(effectIndex.length, (index) { return targetPage;});
        setChangePageIndex(effectPage);

      }else{
        //从低位往高位拖
        List<int> effectIndex = bodyUtil.chequerTargetOffsetByBox[targetPage]!.keys.where((e)=>
          //最后一层的图标
          (((bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dx + ChequerPosition.boxWidth / 2) <= endOffset.dx )
          && ((endOffset.dy + ChequerPosition.boxWidth) >= (bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy + ChequerPosition.boxWidth /2))  
          && ((endOffset.dy + ChequerPosition.boxWidth) <= (bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy + ChequerPosition.boxWidth ))) 
          &&
          //第一层到最后一层中间
          ((bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy <= endOffset.dy )&& (bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy >= (startOffset.dy + ChequerPosition.boxWidth / 2)) )
          &&
          //第一层
          (((bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dx + ChequerPosition.boxWidth / 2) >= (startOffset.dx + ChequerPosition.boxWidth))
          && ((startOffset.dy + ChequerPosition.boxWidth) >= (bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy + ChequerPosition.boxWidth/ 2))
          && ((startOffset.dy + ChequerPosition.boxWidth) <= (bodyUtil.chequerTargetOffsetByBox[targetPage]![e]!.dy + ChequerPosition.boxWidth)))
        ).toList();

        setChangeTargetIndex(effectIndex);
        List<int> effectPage = List.generate(effectIndex.length, (index) { return targetPage;});
        setChangePageIndex(effectPage);
      }
       
     
    }else{
      //目标在其他盒子里
      //原有页播放移出动画，并把startIndex以后的所有格子全部向左移动
      /*for(int j = startIndex + 1; j <= bodyUtil.listRefreshChequer[startPage].length - 1; j++ ){ //用bodyutil.listRefreshChequer获得最大格子数
        bodyUtil.listSetTargetOffset[startPage][j]!(ChequerPosition.chequerOffset[j - 1]);
          addChangePageIndex(startPage);
          addChangeTargetIndex(j);
      }

      //目标页播放转入动画，并把targetIndex以后的所有格子全部向右移动
      for(int k = endIndex + 1; k <= bodyUtil.listRefreshChequer[targetPage].length - 1; k++ ){
        bodyUtil.listSetTargetOffset[targetPage][k]!(ChequerPosition.chequerOffset[k + 1]);
          addChangePageIndex(targetPage);
          addChangeTargetIndex(k);
      }*/
    }
 

     int a;
  }
  */
  //判断是否在原地

  //void setInitChequerSortIndexToEndIndex(int endIndex){
  // bodyUtil.listSetSortIndex[]
  // }

  //刷新被涉及的格子
  void refreshSpwandChequer() {
    //目标在当前盒子里
    for (int i = 0; i <= changedChequerIndex.length - 1; i++) {
      bodyUtil.listRefreshChequer[changedPageIndex[i]]
          [changedChequerIndex[i]]!();
    }
  }

  //播放动画
  Future<void> startChequerAnimation() async {
    await bodyUtil.startChequerMoveAnimation!();
  }

  //重制动画
  void resetChequerAnimation() {
    bodyUtil.resetChequerMoveAnimation!();
  }

  //停止动画
  void stopChequerAnimation() {
    bodyUtil.stopChequerMoveAnimation!();
  }

  //设置格子的初始offset
  void setAnimatedStartOffsetFromCurrentOffset() {
    for (int i = 0; i <= changedChequerIndex.length - 1; i++) {
      //bool isRight = (endIndex - startIndex) < 0? true : false; //从高位往低位的index拖拽时，所有图标向右挪动
      //if(isRight){
      //bodyUtil.listSetTargetOffset[startPage][i]!(ChequerPosition.chequerOffset[i + 1]);
      //bodyUtil.listSetStartOffset[changedPageIndex[i]][changedChequerIndex[i]]!(bodyUtil.listGetCurrentOffset[changedPageIndex[i]][changedChequerIndex[i]]!());
      bodyUtil.listSetStartOffset[changedPageIndex[i]][changedChequerIndex[i]]!(
          bodyUtil.listGetCurrentOffset[changedPageIndex[i]]
              [changedChequerIndex[i]]!());
      // print('ddd');
      //}else{
      //从低位往高位
      //  bodyUtil.listSetStartOffset[changedPageIndex[i]][changedTargetIndex[i]]!(ChequerPosition.chequerOffset[changedTargetIndex[i] - 1]);
      //}
      print(bodyUtil
          .listGetCurrentOffset[changedPageIndex[i]][changedChequerIndex[i]]!()
          .dx);
    }
  }

  //设置格子index
  void setChequerSortIndex() {
    for (int i = 0; i <= changedChequerIndex.length - 1; i++) {
      /*bool isRight = (endIndex - startIndex) < 0? true : false; //从高位往低位的index拖拽时，所有图标向右挪动

      if(isRight){
        //bodyUtil.listSetTargetOffset[startPage][i]!(ChequerPosition.chequerOffset[i + 1]);
        bodyUtil.listSetSortIndex[changedPageIndex[i]][changedTargetIndex[i]]!(changedTargetIndex[i] + 1);
         // print('ddd');
      }else{
        //从低位往高位
        //bodyUtil.listSetStartOffset[changedPageIndex[i]][changedTargetIndex[i]]!(ChequerPosition.chequerOffset[changedTargetIndex[i] - 1]);
        bodyUtil.listSetSortIndex[changedPageIndex[i]][changedTargetIndex[i]]!(changedTargetIndex[i] - 1);
      }*/
      bodyUtil.listSetSortIndex[changedPageIndex[i]]
          [changedChequerIndex[i]]!(changedSortIndex[i]);
    }
  }

  void setChequerStartOffset() {
    for (int i = 0; i <= changedChequerIndex.length - 1; i++) {
      bodyUtil.listSetStartOffset[changedPageIndex[i]][changedChequerIndex[i]]!(
          ChequerPosition.chequerOffset[changedSortIndex[i]]);
    }
  }

  //dragEnd时调用，用于使图标发生变化
  void chequerMove(Offset offset) async {
    //setEndOffset(offset);
    setSpwandOffset(offset);
    setEndIndex();
    if (startIndex == endIndex) {
    } else {
      stopChequerAnimation(); //停止动画

      setAnimatedStartOffsetFromCurrentOffset(); //将运行一半的格子位置设置为初始位置
      refreshSpwandChequer(); //刷新组件
      //if(bodyUtil.chequerMovAnimationController!.isCompleted){
      setChangeIndexNull();
      // print('init');
      //}
      resetChequerAnimation();
      setAnimatedTargetOffset(); //设置格子目标位移坐标
      setChequerSortIndex(); //将操作格子的排序sortIndex设置为目标sortIndex
      //setStartIndexFromChequerId(targetPage,endIndex); //将保存的开始chequerIndex的sortIndex修改为endIndex
      //将拖拽的格子的sortIndex设置为拖拽结束时的sortIendex
      refreshSpwandChequer(); //刷新组件

      await startChequerAnimation(); //启动控制器
      //setAnimatedStartOffsetFromCurrentOffset();
      print('finish');
      //setAnimatedStartOffset();
    }
  }
  //

}
