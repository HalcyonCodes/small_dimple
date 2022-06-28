

import 'package:flutter/material.dart';

class PageUtil{

  //设置toolBar图标滚动条滚动位置
  void Function(double)? _setScrollPosition;
  void Function(double)? get setScrollPosition => _setScrollPosition;
  void setFuncSetScrollPosition(Function(double)? i){
    _setScrollPosition = i;
  }

  //设置box的pagecorolller的滚动位置
  void Function(double)? _setPageControllerValue;
  void Function(double)? get setPageControllerValue => _setPageControllerValue;
  void setFuncSetPageControllerValue(Function(double)? i){
    _setPageControllerValue = i;
  }

  //设置pageController的页数
    Function(int)? _setPageControllerPage;
  Function(int)? get setPageControllerPage => _setPageControllerPage;
  void setFuncSetPageControllerPage(Function(int)? i){
    _setPageControllerPage = i;
  }

  //得到box的pageController的数值
  Function()? _getPageControllerValue;
  Function()? get getPageControllerValue => _getPageControllerValue;
  void setFuncGetPageControllerValue(Function()? i){
    _getPageControllerValue = i;
  }

  //得到当前page页的定位
  //double Function()? _getPagePosition;
  //double Function()? get getPagePosition => _getPagePosition;
  //void setPagePosition(double Function()? i){
  //  _getPagePosition = i;
  //}

  //得到toolBar原始图标所在的边界
  List<double> Function()? _getIconBoundBase;
  List<double> Function()? get getIconBoundBasse => _getIconBoundBase;
  void setFuncGetIconBoundBase(List<double> Function()? i){
    _getIconBoundBase = i;
  }

  //得到toolBar是否搜索等的状态
  Function()? _getStatus;
  Function()? get getStatus => _getStatus;
  void setFuncGetStatus(Function()? i) {
    _getStatus = i;
  }

  //判断滚动是由哪个发起的，如果是pageController发起的为1，如果是tollBar发起的为0
  int _spwanedScrollCharacter = 0;
  int get spwanedScrollCharacter => _spwanedScrollCharacter;
  void setSpwanedScrollCharacter(int i){
    _spwanedScrollCharacter = i;
  }

  //刷新盒子List
  List<void Function()> _refreshBoxList = [];
  List<void Function()> get refreshBoxList => _refreshBoxList;
  void setFuncRefreshBoxList(List<void Function()> i){
    _refreshBoxList = i;
  }
  
  //刷新盒子page
  void Function()? _refreshBox;
  void Function()? get refreshBox => _refreshBox;
  void setFuncRefreshBox(void Function() i){
    _refreshBox = i;
  }

  //将icondecoration列表里的index转化成viewmodel里的index
  int Function(int)? _iconDecorationsIndexTranslatePage;
  int Function(int)? get iconDecorationsIndexTranslatePage => _iconDecorationsIndexTranslatePage;
  void setIconDecorationsIndexTranslatePage(int Function(int)? i){
    _iconDecorationsIndexTranslatePage = i;
  }


  //把滚动中的pageview滚回当前页并锁住pageview不让滚动
  void Function()? _returnPageAndLockPageWhenPageIsScrolling;
  void Function()? get returnPageAndLockPageWhenPageIsScrolling => _returnPageAndLockPageWhenPageIsScrolling;
  void setFuncReturnPageAndLockPageWhenPageIsScrolling(void Function()? i){
    _returnPageAndLockPageWhenPageIsScrolling = i;
  }

  //解锁pageview让其滚动
  void Function()? _unLockPageScroll;
  void Function()? get unLockPageScroll => _unLockPageScroll;
  void setFuncUnLockPageScroll(void Function()? i){
    _unLockPageScroll = i;
  }

  //把page转化成icondecoration的数值
  double Function(PageController, double)? _pageValueTranslateScrollValue;
  double Function(PageController, double)? get pageValueTranslateScrollValue => _pageValueTranslateScrollValue;
  void setFuncPageValueTranslateScrollValue (double Function(PageController, double)? i){
    _pageValueTranslateScrollValue = i;
  }

  //得到pageController
   PageController? _pageController;
  PageController? get pageController => _pageController;
  void setPageController(PageController? i){
    _pageController = i;
  }

  //得到屏幕的宽度
  double _screenWidth = 0;
  double get screenWidth => _screenWidth;
  void setScreenWidth(double i){
    _screenWidth = i;
  }

  //所有盒子的个数
  int _boxCount = 0;
  int get boxCount => _boxCount;
  void setBoxCount(int i){
    _boxCount = i;
  }

  //顶部安全区的高度
  double _screenTopPadding = 0;
  double get screenTopPadding => _screenTopPadding;
  void setScreenTopPadding(double i){
    _screenTopPadding = i;
  }

  
}