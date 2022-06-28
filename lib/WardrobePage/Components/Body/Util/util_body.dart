import 'package:flutter/material.dart';

import '../../../ViewModel/wardrobe_page_viewmodel.dart';
import '../../../PageUtil/util_page.dart';
//import 'package:collection/equality.dart';

class BodyUtil {
  PageUtil pageUtil;
  BodyUtil({required this.pageUtil});

  //格子状态刷新
  List<Function()?> _refreshChequer = [];
  List<Function()?> get refreshChequer => _refreshChequer;
  void setFuncRefreshChequer(List<Function()?> i) {
    _refreshChequer = i;
  }

  void addRefreshChequer(Function()? i) {
    _refreshChequer.add(i);
  }

  //格子状态刷新列表的列表 listRefreshChequer[格子id].
  List<List<Function()?>> _listRefreshChequer = [];
  List<List<Function()?>> get listRefreshChequer => _listRefreshChequer;
  void setFuncListRefreshChequer(List<List<Function()?>> i) {
    _listRefreshChequer = i;
  }

  void addListRefreshChequer(List<Function()?> i) {
    _listRefreshChequer.add(i);
  }

  void setFuncSubListRefreshChequer(List<Function()?> l, int i) {
    if (_listRefreshChequer.length - 1 <= i) {
      for (int j = 0; j <= i - (_listRefreshChequer.length - 1); j++) {
        _listRefreshChequer.add([]);
      }
    }
    _listRefreshChequer[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListRefreshChequerByOne(Function()? l, int boxId, int index) {
    if (_listRefreshChequer.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listRefreshChequer.length - 1); j++) {
        _listRefreshChequer.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listRefreshChequer[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listRefreshChequer[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listRefreshChequer[boxId].length - 1);
            k++) {
          _listRefreshChequer[boxId].add(null);
        }
      }
    }
    _listRefreshChequer[boxId][index] = l;
  }

  //设置格子是否为拖拽状态
  List<void Function(bool)?> _setIsInDrag = [];
  List<void Function(bool)?> get setIsInDrag => _setIsInDrag;
  void setFuncSetIsInDrag(List<void Function(bool)?> i) {
    _setIsInDrag = i;
  }

  void addSetIsInDrag(void Function(bool)? i) {
    _setIsInDrag.add(i);
  }

  //设置格子是否为拖拽状态的列表版本
  List<List<void Function(bool)?>> _listSetIsInDrag = [];
  List<List<void Function(bool)?>> get listSetIsInDrag => _listSetIsInDrag;
  void setFuncListSetIsInDrag(List<List<void Function(bool)?>> i) {
    _listSetIsInDrag = i;
  }

  void addListSetIsInDrag(List<void Function(bool)?> i) {
    _listSetIsInDrag.add(i);
  }

  void setFuncSubListSetIsInDrag(List<void Function(bool)?> l, int i) {
    if (_listSetIsInDrag.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetIsInDrag.length - 1); j++) {
        _listSetIsInDrag.add([]);
      }
    }
    _listSetIsInDrag[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetIsInDragByOne(Function(bool)? l, int boxId, int index) {
    if (_listSetIsInDrag.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetIsInDrag.length - 1); j++) {
        _listSetIsInDrag.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetIsInDrag[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetIsInDrag[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listSetIsInDrag[boxId].length - 1);
            k++) {
          _listSetIsInDrag[boxId].add(null);
        }
      }
    }
    _listSetIsInDrag[boxId][index] = l;
  }

  //设置格子为空白状态
  List<void Function(bool)?> _setIsSpace = [];
  List<void Function(bool)?> get setIsSpace => _setIsSpace;
  void setFuncSetIsSpace(List<void Function(bool)?> i) {
    _setIsSpace = i;
  }

  void addSetIsSapce(Function(bool) i) {
    _setIsSpace.add(i);
  }

  //设置格子为空白状态列表版本
  List<List<void Function(bool)?>> _listSetIsSpace = [];
  List<List<void Function(bool)?>> get listSetIsSpace => _listSetIsSpace;
  void setFuncListSetIsSpace(List<List<void Function(bool)?>> i) {
    _listSetIsSpace = i;
  }

  void addListSetIsSapce(List<Function(bool)?> i) {
    _listSetIsSpace.add(i);
  }

  void setFuncSubListSetIsSpace(List<Function(bool)?> l, int i) {
    if (_listSetIsSpace.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetIsSpace.length - 1); j++) {
        _listSetIsSpace.add([]);
      }
    }
    _listSetIsSpace[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetIsSpaceByOne(Function(bool)? l, int boxId, int index) {
    if (_listSetIsSpace.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetIsSpace.length - 1); j++) {
        _listSetIsSpace.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetIsSpace[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetIsSpace[boxId].length - 1 < index) {
        for (int k = 0; k <= index - (_listSetIsSpace[boxId].length - 1); k++) {
          _listSetIsSpace[boxId].add(null);
        }
      }
    }
    _listSetIsSpace[boxId][index] = l;
  }

  //设置格子存放的物品id
  List<void Function(int)?> _setItemId = [];
  List<void Function(int)?> get setItemId => _setItemId;
  void setFuncSetItemId(List<void Function(int)?> i) {
    _setItemId = i;
  }

  void addSetItemId(void Function(int)? i) {
    _setItemId.add(i);
  }

  //设置格子存放的物品id的列表版本
  List<List<void Function(int)?>> _listSetItemId = [];
  List<List<void Function(int)?>> get listSetItemId => _listSetItemId;
  void setFuncListSetItemId(List<List<void Function(int)?>> i) {
    _listSetItemId = i;
  }

  void addListSetItemId(List<void Function(int)?> i) {
    _listSetItemId.add(i);
  }

  void setFuncSubListSetItemId(List<void Function(int)?> l, int i) {
    if (_listSetItemId.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetItemId.length - 1); j++) {
        _listSetItemId.add([]);
      }
    }
    _listSetItemId[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetItemIdByOne(Function(int)? l, int boxId, int index) {
    if (_listSetItemId.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetItemId.length - 1); j++) {
        _listSetItemId.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetItemId[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetItemId[boxId].length - 1 < index) {
        for (int k = 0; k <= index - (_listSetItemId[boxId].length - 1); k++) {
          _listSetItemId[boxId].add(null);
        }
      }
    }
    _listSetItemId[boxId][index] = l;
  }

  //设置排序index的方法列表
  List<List<void Function(int)?>> _listSetSortIndex = [];
  List<List<void Function(int)?>> get listSetSortIndex => _listSetSortIndex;
  void setFuncListSetSortIndex(List<List<void Function(int)?>> i) {
    _listSetSortIndex = i;
  }

  void addListSetSortIndex(List<void Function(int)?> i) {
    _listSetSortIndex.add(i);
  }

  void setFuncSubListSetSortIndex(List<void Function(int)?> l, int i) {
    if (_listSetSortIndex.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetSortIndex.length - 1); j++) {
        _listSetSortIndex.add([]);
      }
    }
    _listSetSortIndex[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetSortIndexByOne(Function(int)? l, int boxId, int index) {
    if (_listSetSortIndex.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetSortIndex.length - 1); j++) {
        _listSetSortIndex.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetSortIndex[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetSortIndex[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listSetSortIndex[boxId].length - 1);
            k++) {
          _listSetSortIndex[boxId].add(null);
        }
      }
    }
    _listSetSortIndex[boxId][index] = l;
  }

  //设置格子的位置移动的程序
  List<void Function(double, double, double, double)?> _setPosition = [];
  List<void Function(double, double, double, double)?> get setPosition =>
      _setPosition;
  void setFuncSetPosition(
      List<void Function(double, double, double, double)?> i) {
    _setPosition = i;
  }

  void addSetPosition(void Function(double, double, double, double)? i) {
    _setPosition.add(i);
  }

  List<List<void Function(double, double, double, double)?>> _listSetPosition =
      [];
  List<List<void Function(double, double, double, double)?>>
      get listSetPosition => _listSetPosition;
  void addListSetPosition(
      List<void Function(double, double, double, double)?> i) {
    _listSetPosition.add(i);
  }

  void setFuncSubListSetPosition(
      List<void Function(double, double, double, double)?> l, int i) {
    if (_listSetPosition.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetPosition.length - 1); j++) {
        _listSetPosition.add([]);
      }
    }
    _listSetPosition[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetPositionByOne(
      Function(double, double, double, double)? l, int boxId, int index) {
    if (_listSetPosition.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetPosition.length - 1); j++) {
        _listSetPosition.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetPosition[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetPosition[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listSetPosition[boxId].length - 1);
            k++) {
          _listSetPosition[boxId].add(null);
        }
      }
    }
    _listSetPosition[boxId][index] = l;
  }

  //设置格子当前offset的方法
  List<List<void Function(Offset)?>> _listSetCurrentOffset = [];
  List<List<void Function(Offset)?>> get listSetCurrentOffset =>
      _listSetCurrentOffset;
  void setFuncListSetCurrentOffset(List<List<void Function(Offset)?>> i) {
    _listSetCurrentOffset = i;
  }

  void addListSetCurrentOffset(List<void Function(Offset)?> i) {
    _listSetCurrentOffset.add(i);
  }

  void setFuncSubListSetCurrentOffset(List<void Function(Offset)?> l, int i) {
    if (_listSetCurrentOffset.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetCurrentOffset.length - 1); j++) {
        _listSetCurrentOffset.add([]);
      }
    }
    _listSetCurrentOffset[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetCurrentOffsetByOne(
      Function(Offset)? l, int boxId, int index) {
    if (_listSetCurrentOffset.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetCurrentOffset.length - 1); j++) {
        _listSetCurrentOffset.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetCurrentOffset[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetCurrentOffset[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listSetCurrentOffset[boxId].length - 1);
            k++) {
          _listSetCurrentOffset[boxId].add(null);
        }
      }
    }
    _listSetCurrentOffset[boxId][index] = l;
  }

  //设置格子目标offset的方法
  List<List<void Function(Offset)?>> _listSetTargetOffset = [];
  List<List<void Function(Offset)?>> get listSetTargetOffset =>
      _listSetTargetOffset;
  void setFuncListSetTargetOffset(List<List<void Function(Offset)?>> i) {
    _listSetTargetOffset = i;
  }

  void addListSetTargetOffset(List<void Function(Offset)?> i) {
    _listSetTargetOffset.add(i);
  }

  void setFuncSubListSetTargetOffset(List<void Function(Offset)?> l, int i) {
    if (_listSetTargetOffset.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetTargetOffset.length - 1); j++) {
        _listSetTargetOffset.add([]);
      }
    }
    _listSetTargetOffset[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetTargetOffsetByOne(
      Function(Offset)? l, int boxId, int index) {
    if (_listSetTargetOffset.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetTargetOffset.length - 1); j++) {
        _listSetTargetOffset.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetTargetOffset[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetTargetOffset[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listSetTargetOffset[boxId].length - 1);
            k++) {
          _listSetTargetOffset[boxId].add(null);
        }
      }
    }
    _listSetTargetOffset[boxId][index] = l;
  }

  //设置格子开始时offset的方法
  List<List<void Function(Offset)?>> _listSetStartOffset = [];
  List<List<void Function(Offset)?>> get listSetStartOffset =>
      _listSetStartOffset;
  void setFuncListSetStartOffset(List<List<void Function(Offset)?>> i) {
    _listSetStartOffset = i;
  }

  void addListSetStartOffset(List<void Function(Offset)?> i) {
    _listSetStartOffset.add(i);
  }

  void setFuncSubListSetStartOffset(List<void Function(Offset)?> l, int i) {
    if (_listSetStartOffset.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetStartOffset.length - 1); j++) {
        _listSetStartOffset.add([]);
      }
    }
    _listSetStartOffset[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetStartOffsetByOne(
      Function(Offset)? l, int boxId, int index) {
    if (_listSetStartOffset.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetStartOffset.length - 1); j++) {
        _listSetStartOffset.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetStartOffset[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetStartOffset[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listSetStartOffset[boxId].length - 1);
            k++) {
          _listSetStartOffset[boxId].add(null);
        }
      }
    }
    _listSetStartOffset[boxId][index] = l;
  }

  //得到当前offset方法
  List<List<Offset Function()?>> _listGetCurrentOffset = [];
  List<List<Offset Function()?>> get listGetCurrentOffset =>
      _listGetCurrentOffset;
  void setFuncListGetCurrentOffset(List<List<Offset Function()?>> i) {
    _listGetCurrentOffset = i;
  }

  void addListGetCurrentOffset(List<Offset Function()?> i) {
    _listGetCurrentOffset.add(i);
  }

  void setFuncSubListGetCurrentOffset(List<Offset Function()?> l, int i) {
    if (_listGetCurrentOffset.length - 1 <= i) {
      for (int j = 0; j <= i - (_listGetCurrentOffset.length - 1); j++) {
        _listGetCurrentOffset.add([]);
      }
    }
    _listGetCurrentOffset[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListGetCurrentOffsetByOne(
      Offset Function()? l, int boxId, int index) {
    if (_listGetCurrentOffset.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listGetCurrentOffset.length - 1); j++) {
        _listGetCurrentOffset.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listGetCurrentOffset[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listGetCurrentOffset[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listGetCurrentOffset[boxId].length - 1);
            k++) {
          _listGetCurrentOffset[boxId].add(null);
        }
      }
    }
    _listGetCurrentOffset[boxId][index] = l;
  }

  //返回格子sortIndex的方法
  List<List<int Function()?>> _listGetSortIndex = [];
  List<List<int Function()?>> get listGetSortIndex => _listGetSortIndex;
  void setFuncListGetSortIndex(List<List<int Function()?>> i) {
    _listGetSortIndex = i;
  }

  void addListGetSortIndex(List<int Function()?> i) {
    _listGetSortIndex.add(i);
  }

  void setFuncSubListGetSortIndex(List<int Function()?> l, int i) {
    if (_listGetSortIndex.length - 1 <= i) {
      for (int j = 0; j <= i - (_listGetSortIndex.length - 1); j++) {
        _listGetSortIndex.add([]);
      }
    }
    _listGetSortIndex[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListGetSortIndexByOne(
      int Function()? l, int boxId, int index) {
    if (_listGetSortIndex.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listGetSortIndex.length - 1); j++) {
        _listGetSortIndex.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listGetSortIndex[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listGetSortIndex[boxId].length - 1 < index) {
        for (int k = 0;
            k <= index - (_listGetSortIndex[boxId].length - 1);
            k++) {
          _listGetSortIndex[boxId].add(null);
        }
      }
    }
    _listGetSortIndex[boxId][index] = l;
  }

  //设置格子所属boxId
  List<List<void Function(int)?>> _listSetBoxId = [];
  List<List<void Function(int)?>> get listSetBoxId => _listSetBoxId;
  void setFuncListSetBoxId(List<List<void Function(int)?>> i) {
    _listSetBoxId = i;
  }

  void addListSetBoxId(List<void Function(int)?> i) {
    _listSetBoxId.add(i);
  }

  void setFuncSubListSetBoxId(List<void Function(int)?> l, int i) {
    if (_listSetBoxId.length - 1 <= i) {
      for (int j = 0; j <= i - (_listSetBoxId.length - 1); j++) {
        _listSetBoxId.add([]);
      }
    }
    _listSetBoxId[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListSetBoxIdByOne(
      void Function(int)? l, int boxId, int index) {
    if (_listSetBoxId.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listSetBoxId.length - 1); j++) {
        _listSetBoxId.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listSetBoxId[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listSetBoxId[boxId].length - 1 < index) {
        for (int k = 0; k <= index - (_listSetBoxId[boxId].length - 1); k++) {
          _listSetBoxId[boxId].add(null);
        }
      }
    }
    _listSetBoxId[boxId][index] = l;
  }

  //返回格子boxId
  List<List<int Function()?>> _listGetBoxId = [];
  List<List<int Function()?>> get listGetBoxId => _listGetBoxId;
  void setFuncListGetBoxId(List<List<int Function()?>> i) {
    _listGetBoxId = i;
  }

  void addListGetBoxId(List<int Function()?> i) {
    _listGetBoxId.add(i);
  }

  void setFuncSubListGetBoxId(List<int Function()?> l, int i) {
    if (_listGetBoxId.length - 1 <= i) {
      for (int j = 0; j <= i - (_listGetBoxId.length - 1); j++) {
        _listGetBoxId.add([]);
      }
    }
    _listGetBoxId[i] = l;
  }

  //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListGetBoxIdByOne(int Function()? l, int boxId, int index) {
    if (_listGetBoxId.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_listGetBoxId.length - 1); j++) {
        _listGetBoxId.add([]);
      }
      for (int k = 0; k <= index; k++) {
        _listGetBoxId[boxId].add(null);
      }
      //_listRefreshChequer[boxId].add(l);
    } else {
      if (_listGetBoxId[boxId].length - 1 < index) {
        for (int k = 0; k <= index - (_listGetBoxId[boxId].length - 1); k++) {
          _listGetBoxId[boxId].add(null);
        }
      }
    }
    _listGetBoxId[boxId][index] = l;
  }

  //设置排序盒子id sortBoxId
  /*
  List<List<int Function()?>> _listGetBoxId = []; 
  List<List<int Function()?>> get listGetBoxId => _listGetBoxId;
  void setFuncListGetBoxId( List<List<int Function()?>> i){
    _listGetBoxId = i;
  }

  void addListGetBoxId(List<int Function()? > i){
    _listGetBoxId.add(i);
  }

  void setFuncSubListGetBoxId(List<int Function()? > l, int i){
      if(_listGetBoxId.length -1 <= i){
        for(int j = 0; j<= i - (_listGetBoxId.length - 1); j ++ ){
         _listGetBoxId.add([]);
      }
    }
    _listGetBoxId[i] = l;
  }

   //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListGetBoxIdByOne( int Function()? l, int boxId, int index){
    if(_listGetBoxId.length - 1 <= boxId){
      for(int j = 0; j<= boxId - (_listGetBoxId.length - 1); j ++ ){
       _listGetBoxId.add([]);
      }
      for(int k = 0; k <= index; k ++){
       _listGetBoxId[boxId].add(null);
      }
        //_listRefreshChequer[boxId].add(l);
    }else{
      if(_listGetBoxId[boxId].length - 1 < index){
        for(int k = 0; k <= index - (_listGetBoxId[boxId].length - 1); k ++){
          _listGetBoxId[boxId].add(null);
        }
      }
    }
    _listGetBoxId[boxId][index] = l;
  }*/

  //----------------------------------------------
  //获得所有TargetOffset的方法<格子index, offset>

  /*Map<int, Offset> _chequerTargetOffset = {};
  Map<int, Offset> get chequerTargetOffset => _chequerTargetOffset;
  void setChequerTargetOffset(int chequerIndex, Offset i){
    _chequerTargetOffset[chequerIndex] = i;
  }



  Map<int, Map<int,Offset>> _chequerTargetOffsetByBox ={};
  Map<int, Map<int,Offset>> get chequerTargetOffsetByBox => _chequerTargetOffsetByBox;
  void setChequerTargetOffsetByBox(int boxId, int chequerIndex, Offset offset){
    if(_chequerTargetOffsetByBox[boxId] == null || _chequerTargetOffsetByBox[boxId] == {}){
      _chequerTargetOffsetByBox[boxId] = {};
      _chequerTargetOffset = {};
    }
    _chequerTargetOffset[chequerIndex] = offset;
    _chequerTargetOffsetByBox[boxId] = _chequerTargetOffset;
    
  }

  void setChequerTargetOffsetByBoxNull(int boxId){
    _chequerTargetOffsetByBox[boxId] = {};
  }


  void updateChequerTargetOffsetByBox(int boxId, int chequerIndex, Offset offset){
    _chequerTargetOffsetByBox[boxId]![chequerIndex] = offset;
  }*/

  //所有格子的TargetOffset

  //动画控制器方法-------------------
  Future<void> Function()? _startChequerMoveAnimation;
  Future<void> Function()? get startChequerMoveAnimation =>
      _startChequerMoveAnimation;
  void setStartChequerMoveAnimation(Future<void> Function()? i) {
    _startChequerMoveAnimation = i;
  }

  void Function()? _resetChequerMoveAnimation;
  void Function()? get resetChequerMoveAnimation => _resetChequerMoveAnimation;
  void setResetChequerMoveAnimation(void Function()? i) {
    _resetChequerMoveAnimation = i;
  }

  void Function()? _stopChequerMoveAnimation;
  void Function()? get stopChequerMoveAnimation => _stopChequerMoveAnimation;
  void setStopChequerMoveAnimation(void Function()? i) {
    _stopChequerMoveAnimation = i;
  }

  //设置格子开始动画的方法
  /*
  List<List<Future<void> Function ()?>>  _listStartAnimation = []; 
  List<List<Future<void> Function()?>> get listStartAnimation => _listStartAnimation;
  void setFuncListStartAnimation( List<List<Future<void> Function()?>> i){
    _listStartAnimation = i;
  }

  void addListStartAnimation(List<Future<void> Function()? > i){
    _listStartAnimation.add(i);
  }

  void setFuncSubListStartAnimation(List<Future<void> Function()? > l, int i){
      if(_listStartAnimation.length -1 <= i){
        for(int j = 0; j<= i - (_listStartAnimation.length - 1); j ++ ){
         _listStartAnimation.add([]);
      }
    }
    _listStartAnimation[i] = l;
  }

   //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListStartAnimationByOne( Future<void> Function()? l, int boxId, int index){
    if(_listStartAnimation.length - 1 <= boxId){
      for(int j = 0; j<= boxId - (_listStartAnimation.length - 1); j ++ ){
       _listStartAnimation.add([]);
      }
      for(int k = 0; k <= index; k ++){
       _listStartAnimation[boxId].add(null);
      }
        //_listRefreshChequer[boxId].add(l);
    }else{
      if(_listStartAnimation[boxId].length - 1 < index){
        for(int k = 0; k <= index - (_listStartAnimation[boxId].length - 1); k ++){
          _listStartAnimation[boxId].add(null);
        }
      }
    }
    _listStartAnimation[boxId][index] = l;
  }


  //设置格子重制动画的方法
  List<List<void Function()?>> _listResetAnimation = []; 
  List<List<void Function()?>> get listResetAnimation => _listResetAnimation;
  void setFuncListResetAnimation( List<List<void Function()?>> i){
    _listResetAnimation = i;
  }

  void addListResetAnimation(List<void Function()? > i){
    _listResetAnimation.add(i);
  }

  void setFuncSubListResetAnimation(List<void Function()? > l, int i){
      if(_listResetAnimation.length -1 <= i){
        for(int j = 0; j<= i - (_listResetAnimation.length - 1); j ++ ){
         _listResetAnimation.add([]);
      }
    }
    _listResetAnimation[i] = l;
  }

   //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListResetAnimationByOne( Function()? l, int boxId, int index){
    if(_listResetAnimation.length - 1 <= boxId){
      for(int j = 0; j<= boxId - (_listResetAnimation.length - 1); j ++ ){
       _listResetAnimation.add([]);
      }
      for(int k = 0; k <= index; k ++){
       _listResetAnimation[boxId].add(null);
      }
        //_listRefreshChequer[boxId].add(l);
    }else{
      if(_listResetAnimation[boxId].length - 1 < index){
        for(int k = 0; k <= index - (_listResetAnimation[boxId].length - 1); k ++){
          _listResetAnimation[boxId].add(null);
        }
      }
    }
    _listResetAnimation[boxId][index] = l;
  }

  //设置格子动画停止的方法
    List<List<void Function()?>> _listStopAnimation = []; 
  List<List<void Function()?>> get listStopAnimation => _listStopAnimation;
  void setFuncListStopAnimation( List<List<void Function()?>> i){
    _listStopAnimation = i;
  }

  void addListStopAnimation(List<void Function()? > i){
    _listStopAnimation.add(i);
  }

  void setFuncSubListStopAnimation(List<void Function()? > l, int i){
      if(_listStopAnimation.length -1 <= i){
        for(int j = 0; j<= i - (_listStopAnimation.length - 1); j ++ ){
         _listStopAnimation.add([]);
      }
    }
    _listStopAnimation[i] = l;
  }

   //在方法列表中的[boxId]中插入某个func[index]中,参数为盒子id，盒子列表中的index，
  void setFuncSubListStopAnimationByOne( Function()? l, int boxId, int index){
    if(_listStopAnimation.length - 1 <= boxId){
      for(int j = 0; j<= boxId - (_listStopAnimation.length - 1); j ++ ){
       _listStopAnimation.add([]);
      }
      for(int k = 0; k <= index; k ++){
       _listStopAnimation[boxId].add(null);
      }
        //_listRefreshChequer[boxId].add(l);
    }else{
      if(_listStopAnimation[boxId].length - 1 < index){
        for(int k = 0; k <= index - (_listStopAnimation[boxId].length - 1); k ++){
          _listStopAnimation[boxId].add(null);
        }
      }
    }
    _listStopAnimation[boxId][index] = l;
  }
  */

  //------------------

  //刷新box里的列表的所有格子
  List<void Function()> _refreshListInBox = [];
  List<void Function()> get refreshListInBox => _refreshListInBox;
  void setRefreshListInBox(List<void Function()> i) {
    _refreshListInBox = i;
  }

  void addRefreshListInBox(void Function() i) {
    _refreshListInBox.add(i);
  }

  void setSubRefreshListInBox(void Function() i, int boxId) {
    if (_refreshListInBox.length - 1 <= boxId) {
      for (int j = 0; j <= boxId - (_refreshListInBox.length - 1); j++) {
        _refreshListInBox.add(i);
      }
    }
    _refreshListInBox[boxId] = i;
  }

  //刷新box里的 列表 里的所有格子
  //void Function()? _refreshBoxList;
  //void Function()? get refreshBoxList => _refreshBoxList;
  //void setFuncRefreshList(void Function()? i){
  //  _refreshBoxList = i;
  // }

  //设置拖拽元件的位置
  Function(double, double)? _setFloatChequerPosition;
  Function(double, double)? get setFloatChequerPosition =>
      _setFloatChequerPosition;
  void setFuncSetFloatChequerPosition(Function(double, double)? i) {
    _setFloatChequerPosition = i;
  }

  //得到viewMode里箱子的最大位置,参数为格子id
  int getMaxPosition(int i, WardrobePageViewModel viewModel) {
    int position = 0;
    Wardrobe? wardrobe;
    for (var e in viewModel.wardrobes) {
      wardrobe = e.wardrobeId == i ? e : null;
      if (wardrobe != null) {
        break;
      }
    }
    for (var e in wardrobe!.items!) {
      position = e.itemPosition! >= position ? e.itemPosition! : position;
    }
    return position;
  }

  //对viewModel里的格子的物品进行冒泡排序，参数为格子id和viewModel
  Wardrobe sortItemPosition(int i, WardrobePageViewModel viewModel) {
    Wardrobe? wardrobe = Wardrobe();
    for (var e in viewModel.wardrobes) {
      wardrobe = e.wardrobeId == i ? e : null;
      if (wardrobe != null) {
        break;
      }
    }

    for (int i = 0; i < wardrobe!.items!.length - 1; i++) {
      for (int j = 0; j < wardrobe.items!.length - 1 - i; j++) {
        if (wardrobe.items![j].itemPosition! >
            wardrobe.items![j + 1].itemPosition!) {
          Item temp = Item();
          temp = wardrobe.items![j];
          wardrobe.items![j] = wardrobe.items![j + 1];
          wardrobe.items![j + 1] = temp;
        }
      }
    }
    return wardrobe;
  }

  //获得顶部时间留白部位
  double _paddingTop = 0;
  double get paddingTop => _paddingTop;
  void setPaddingTop(double i) {
    _paddingTop = i;
  }

  //重新构建所有盒子page
  //void Function()? _buildBox;
  //void Function()? get buildBox => _buildBox;
  //void setFuncBuildBox( void Function()? i){
  //  _buildBox = i;
  //}

  //设置盒子pagecontroller的值
  void Function(double)? _setPageControllerValue;
  void Function(double)? get setPageControllerValue => _setPageControllerValue;
  void setFuncSetPageControllerValue(void Function(double)? i) {
    _setPageControllerValue = i;
  }

  //设置pageControllerpage的值
  void Function(int)? _setPageControllerPage;
  void Function(int)? get setPageControllerPage => _setPageControllerPage;
  void setFuncSetPageControllerPage(void Function(int)? i) {
    _setPageControllerPage = i;
  }

  //页面控制器的数值
  double _pagePositionValue = 0;
  double get pagePositionValue => _pagePositionValue;
  void setPagePositionValue(double i) {
    _pagePositionValue = i;
  }

  double getPagePositionValue() {
    return pagePositionValue;
  }

  //存放toolBar里icon在滚动条的边界，
  List<double> _boxScrollBound = [];
  List<double> get boxScrollBound => _boxScrollBound;
  void setBoxScrollBound(List<double> i) {
    _boxScrollBound = i;
  }

  //把pageControll.page转化成scrollController的定位
  double pageValueTranslateScrollValue(
      PageController pageController, double width) {
    int startPage = pageController.page!.toInt();
    //print((MediaQuery.of(context).size.width- 24 * 2 - 16 * 2 - 24 * 2 - 20 * 2) / 2);
    if (boxScrollBound.isEmpty ||
        boxScrollBound.length != pageUtil.getIconBoundBasse!().length) {
      setBoxScrollBound(pageUtil.getIconBoundBasse!());
    }

    double spwanedScrollPosition = 0;
    if (startPage + 1 <= boxScrollBound.length - 1) {
      spwanedScrollPosition =
          (boxScrollBound[startPage + 1] - boxScrollBound[startPage]) *
                  (pageController.page! - startPage) +
              boxScrollBound[startPage] -
              (width - 24 * 2 - 16 * 2 - 24 * 2 - 20 * 2) / 2 +
              9 +
              12;
    } else {
      spwanedScrollPosition = (boxScrollBound[boxScrollBound.length - 1] -
                  boxScrollBound[boxScrollBound.length - 2]) *
              (pageController.page! - startPage) +
          boxScrollBound[startPage] -
          (width - 24 * 2 - 16 * 2 - 24 * 2 - 20 * 2) / 2 +
          9 +
          12;
    }

    return spwanedScrollPosition;
  }

  //刷新盒子Page
  void Function()? _refreshBox;
  void Function()? get refreshBox => _refreshBox;
  void setFuncReFreshBox(void Function() i) {
    _refreshBox = i;
  }

  //把滚动中的pageview滚回当前页并锁住pageview不让滚动
  void Function()? _returnPageAndLockPageWhenPageIsScrolling;
  void Function()? get returnPageAndLockPageWhenPageIsScrolling =>
      _returnPageAndLockPageWhenPageIsScrolling;
  void setFuncReturnPageAndLockPageWhenPageIsScrolling(void Function()? i) {
    _returnPageAndLockPageWhenPageIsScrolling = i;
  }

  //解锁pageview让其滚动
  void Function()? _unLockPageScroll;
  void Function()? get unLockPageScroll => _unLockPageScroll;
  void setFuncUnLockPageScroll(void Function()? i) {
    _unLockPageScroll = i;
  }

  //获得scrollController
  PageController? _pageController;
  PageController? get pageController => _pageController;
  void setPageController(PageController? i) {
    _pageController = i;
  }

  //所有盒子的状态是否为拖拽状态，0为正常状态，1为拖拽状态
  int _allDragStatus = 0;
  int get allDragStatus => _allDragStatus;
  void setAllDragStatus(int i) {
    _allDragStatus = i;
  }

  //设置pageView能否拖动
  Function(bool)? _setPageScroll;
  Function(bool)? get setPageScroll => _setPageScroll;
  void setFuncPageScroll(Function(bool) i) {
    _setPageScroll = i;
  }

  //获得每个页面（盒子）的所有格子的容器的列表的scrollController
  List<ScrollController> _boxListScrollControllers = [];
  List<ScrollController> get boxListScrollControllers =>
      _boxListScrollControllers;
  void setBoxListScrollControllers(List<ScrollController> i) {
    _boxListScrollControllers = i;
  }

  void addBoxListScrollControllers(ScrollController i) {
    _boxListScrollControllers.add(i);
  }

  void setSubBoxListScrollControllers(ScrollController i, int boxId) {
    if (_boxListScrollControllers.length - 1 <= boxId) {
      for (int j = 0;
          j <= boxId - (_boxListScrollControllers.length - 1);
          j++) {
        _boxListScrollControllers.add(ScrollController());
      }
    }
    _boxListScrollControllers[boxId] = i;
  }

  //当格子触发移位时的标志，触发时锁住所有拖拽并播放动画
  bool _isInChequerChange = false;
  bool get isInChequerChange => _isInChequerChange;
  void setIsInChequerChange(bool i) {
    _isInChequerChange = i;
  }

  //格子移动动画控制器
  AnimationController? _chequerMovAnimationController;
  AnimationController? get chequerMovAnimationController =>
      _chequerMovAnimationController;
  void setChequerMovAnimationController(AnimationController i) {
    _chequerMovAnimationController = i;
  }

  //通过格子的sortIndex查chequerIndex
  int searchChequerIndexBySortIndex(int boxId, int sortIndex) {
    for (int i = 0; i <= listGetSortIndex[boxId].length - 1; i++) {
      if (listGetSortIndex[boxId][i]!() == sortIndex) {
        return i;
      }
    }
    return -1;
  }
}
