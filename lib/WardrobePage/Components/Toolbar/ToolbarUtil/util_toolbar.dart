import 'package:flutter/material.dart';
import '../../../PageUtil/util_page.dart';

class ToolBarUtil {

  PageUtil? pageUtil;
  ToolBarUtil({required this.pageUtil});

  

  //设置toolbar状态，用于在搜索，正常状态，工具栏状态间切换
  Function(int)? _setStatus;
  Function(int)? get setStatus => _setStatus;
  void setStatusFunction(Function(int)? i) {
    _setStatus = i;
  }

  int _toolBarStatus = 0;
  int get toolBarStatus => _toolBarStatus;
  void setToolBarStatus(int i){
    _toolBarStatus = i;
  }

  int getToolBarStatus(){
    return _toolBarStatus;
  }


  //刷新toolBar
  Function()? _refreshToolBar;
  Function()? get refreshToolBar => _refreshToolBar;
  void setRefreshToolBar(Function()? i) {
    _refreshToolBar = i;
  }

  //更新按紧正常状态下中间图标后出现的图标的位置
  Function(double x, double y)? _updateDragPosition;
  Function(double x, double y)? get updateDragPosition => _updateDragPosition;
  void setUpdateDragPosition(Function(double x, double y)? i) {
    _updateDragPosition = i;
  }

  //把中间的图标置成黑色
  List<Function(bool)> _refreshIsMid = [];
  List<Function(bool)> get refreshIsMid => _refreshIsMid;
  void setRefreshIsMid(List<Function(bool)> i){
    _refreshIsMid = i;
  }

  //获得中间滚动条的滚动距离
  double Function()? _getScrollPosition;
  double Function()? get getScrollPosition => _getScrollPosition;
  void setGetScrollPosition(double Function() i ){
    _getScrollPosition = i;
  }

  //获得中间图标滚动组件每个图标的边界
  List<double> _scrollBound = [];
  List<double> get scrollBound => _scrollBound;
  void setScrollBound( List<double> i){
   _scrollBound = i;
  }

  //得到某个中间图标组件的位置的方法的列表
  List<Offset Function()?>? _getIconOffset = [];
  List<Offset Function()?>? get getIconOffset => _getIconOffset;
  void setGetIconOffset( List<Offset Function()?>? i){
    _getIconOffset = i;
  }

  void addIconOffset(Offset Function()? i){
    _getIconOffset!.add(i);
  }

  //获得图标的分类的方法
  List<String Function()?>? _getIconCategory = [];
  List<String Function()?>? get getIconCategory => _getIconCategory;
  void setGetIconCategory(List<String Function()?> i){
    _getIconCategory = i;
  }
  
  void addIconCategory(String Function() i){
    _getIconCategory!.add(i);
  }

  //设置Icon拖拽后释放时要返回的位置
  Function(double, double)? _setIconRemoveTarget;
  Function(double, double)? get setIconRemoveTarget => _setIconRemoveTarget;
  void setRemoveTargetFun(Function(double, double)? i){
    _setIconRemoveTarget = i;
  }

  //图标被拖拽后原地显示为空白的方法的列表
  List<void Function(bool)?>? _hasIcon = [];
  List<void Function(bool)?>? get hasIcon => _hasIcon;
  void setHasIcon(List<void Function(bool)?>?  i){
    _hasIcon = i;
  }
  void addHasIcon(void Function(bool)? i){
    _hasIcon!.add(i);
  }

  //图标被拖拽后移出的方法
  List<Future<void> Function()?>? _iconMovOut = [];
  List<Future<void>  Function()?>? get iconMovOut => _iconMovOut;

  void setIconMovOut(List<Future<void> Function()?>?  i){
    _iconMovOut = i;
  }
  void addIconMovOut(Future<void> Function()? i){
    _iconMovOut!.add(i);
  }

  //图标被拖拽后移入的方法
  List<Future<void> Function()?>? _iconMovIn = [];
  List<Future<void> Function()?>? get iconMovIn => _iconMovIn;

  void setIconMovIn(List<Future<void> Function()?>?  i){
    _iconMovIn = i;
  }
  void addIconMovIn(Future<void> Function()? i){
    _iconMovIn!.add(i);
  }

  //获得图标是否为占位符的方法
  List<Function()?>? _getIsSpace = [];
  List<Function()?>? get getIsSpace => _getIsSpace;

  void setgetIsSpaceStatus(List<Function()?>?  i){
    _getIsSpace = i;
  }
  void addIsSpaceStatus(Function()? i){
    _getIsSpace!.add(i);
  }

  //获得所有icon动画的控制器
  List<AnimationController> _iconAnimationControllers = [];
  List<AnimationController> get iconAnimationControllers => _iconAnimationControllers;
  void setIconAnimationControllers(List<AnimationController> i){
    _iconAnimationControllers = i;
  } 
  void addIconAnimationControllers(AnimationController i){
    _iconAnimationControllers.add(i);
  }

  //得到某个icon的Id
  List<int Function()?> _getWardrobeIds = [];
  List<int Function()?> get getWardrobeIds => _getWardrobeIds;
  void setGetWardrobeIds(List<int Function()?> i){
    _getWardrobeIds = i;
  }

  void addGetWardrobeIds (int Function()? i){
    _getWardrobeIds.add(i);
  }

  //根据元件index获得icon在viewmodel中的id
  int getIconInViewModelIndex(int i){
    if(i % 2 == 0){
      return (i - 1) ~/ 2;
    }else if( i % 2 == 1){
      return (i + 1 - 1) ~/ 2;
    }
    return -1;
  }

  //刷新itempicker
  void Function()? _refreshItemPicker;
  void Function()? get refreshItemPicker => _refreshItemPicker;
  void setRefreshItemPicker(void Function()? i){
    _refreshItemPicker = i;
  }

  //设置滚动条初始值
  void Function(double)? _setScrollInitPosition;
  void Function(double)? get setScrollInitPosition => _setScrollInitPosition;
  void setFuncSetScrollInitPosition(void Function(double)? i){
    _setScrollInitPosition = i;
  }
    
  //设置操作中的iconId
  void Function(int)? _setControlId;
  void Function(int)? get setControlid => _setControlId;
  void setFuncSetControlId(void Function(int)? i){
    _setControlId = i;
  }
  
  //返回操作Id
  int Function()? _getControlId;
  int Function()? get getControlId => _getControlId; 
  void setFuncGetControlId(int Function()? i){
     _getControlId = i;
  }

  //设置iconDecoration队列的isEmpty字段
  List<void Function(bool)?> _setIsEmpty = [];
  List<void Function(bool)?> get setIsEmpty => _setIsEmpty;
  void setFuncSetIsEmpty( List<void Function(bool)?> i){
    _setIsEmpty = i;
  }

  void addSetIsEmpty( void Function(bool)? i){
    _setIsEmpty.add(i);
  }
  
  //设置icon队列的id
  List<void Function(int)?> _setIconIdInState = [];
  List<void Function(int)?> get setIconIdInState => _setIconIdInState;
  void setFuncSetIconIdInState(List<void Function(int)?> i){
    _setIconIdInState = i;
  }

  void addSetIconIdInState(void Function(int)? i){
    _setIconIdInState.add(i);
  }

  //获得icon队列中所有元件的个数
  int Function()? _getIconListCount;
  int Function()? get getIconListCount => _getIconListCount;

  void setGetIconListCount(int Function()i){
    _getIconListCount = i;
  }

  //选中中间icon的Index
  int Function()? _selectIconMid;
  int Function()? get selectIconMid => _selectIconMid;
  void setSelectIconMid( int Function()? i){
    _selectIconMid = i;
  }

  //中间置灰
  void Function(int)? _setIconMid;
  void Function(int)? get setIconMid => _setIconMid;
  void setFuncSetIconMid( void Function(int)? i){
    _setIconMid = i;
  }

  //得到所有icon拉伸动画的状态
  List<bool Function()?> _getIconMovInStatus = [];
  List<bool Function()?> get getIconMovInStatus => _getIconMovInStatus;
  
  void setFuncGetIconMovInStatus(List<bool Function()?> b){
    _getIconMovInStatus = b;
  }

  void addGetIconMovInStatus(bool Function()? b){
    _getIconMovInStatus.add(b);
  }

  //设置所有icon拉伸动画的状态
  List<Function(bool)?> _setIconMovInStatus = [];
  List<Function(bool)?> get setIconMovInStatus => _setIconMovInStatus;
  
  void setFuncSetIconMovInStatus(List<Function(bool)?> b){
    _setIconMovInStatus = b;
  }

  void addSetIconMovInStatus( Function(bool)? b){
    _setIconMovInStatus.add(b);
  }


  //得到所有icon缩小动画的状态
  List<bool Function()?> _getIconMovOutStatus = [];
  List<bool Function()?> get getIconMovOutStatus => _getIconMovOutStatus;
  
  void setFuncGetIconMovOutStatus(List<bool Function()?> b){
    _getIconMovOutStatus = b;
  }

  void addGetIconMovOutStatus(bool Function()? b){
    _getIconMovOutStatus.add(b);
  }

  //设置所有icon缩小动画的状态
  List< Function(bool)?> _setIconMovOutStatus = [];
  List< Function(bool)?> get setIconMovOutStatus => _setIconMovOutStatus;
  
  void setFuncSetIconMovOutStatus(List< Function(bool)?> b){
    _setIconMovOutStatus = b;
  }

  void addSetIconMovOutStatus(Function(bool)? b){
    _setIconMovOutStatus.add(b);
  }

  //得知icon是否是empty状态
  List<bool Function()?> _getIsEmpty = [];
  List<bool Function()?> get getIsEmpty => _getIsEmpty;
  void setFuncGetIsEmpty( List<bool Function()?> i){
    _getIsEmpty = i;
  }
  
  void addGetIsEmpty( bool Function()? i){
    _getIsEmpty.add(i);
  }

  //设置滚动条滚动位置
  void Function(double)? _setScrollPosition;
  void Function(double)? get setScrollPosition => _setScrollPosition;
  void setFuncSetScrollPosition(Function(double)? i){
    _setScrollPosition = i;
  }

  //获得没有加留白的原始图标的边界
  List<double> getIconBoundBase(){
    List<double> boundTemp = [];
    for(int i = 0; i <= scrollBound.length - 1; i ++){
      if(i<4){
        if(boundTemp.isNotEmpty){}else{
          boundTemp.add(scrollBound[0]);
        }
      }else if (i >= 4 && i < scrollBound.length - 1){
        if(i % 2 == 0){
           boundTemp.add(scrollBound[i]);
        }
      }
    }
    return boundTemp;
  }

  //icon滚动条转化成page
  int iconDecorationsIndexTranslatePage(int iconIndex){
    int result = (iconIndex - 2 )~/2;
    return result;
  }

  //在toolbar切换搜索或其他状态时的scrollPosition数值
  double _scrollPositionBeforeSwitchStatus = 9 + 12;
  double get scrollPositionBeforeSwitchStatus => _scrollPositionBeforeSwitchStatus;
  void setScrollPositionBeforeSwitchStatus(double? i){
    _scrollPositionBeforeSwitchStatus = i ?? getScrollPosition!();
  }

  
}
