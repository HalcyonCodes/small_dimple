import 'dart:ffi';

import 'package:flutter/material.dart';

class ChequerPosition {
  static List<Offset> _chequerOffset = [];
  static List<Offset> get chequerOffset => _chequerOffset;
  static void setChequerOffset(List<Offset> i) {
    _chequerOffset = i;
  }

  static double _screenWidth = 0;
  static double get screenWidth => _screenWidth;
  static void setScreenWidth(double i) {
    _screenWidth = i;
  }

  static double _screenHeight = 0;
  static double get screenHeight => _screenHeight;
  static void setScreenHeight(double i) {
    _screenHeight = i;
  }

  static double _screenPaddingTop = 0;
  static double get screenPaddingTop => _screenPaddingTop;
  static void setScreenPaddingTop(double i) {
    _screenPaddingTop = i;
  }

  //包裹chequer的容器的高度
  static double _widgetHeight = 0;
  static double get widgetHeight => _widgetHeight;
  static void setWidgetHeight() {
    _widgetHeight = screenHeight - screenPaddingTop - 48.0;
  }

  static double _boxWidth = 0;
  static double get boxWidth => _boxWidth;
  static void setBoxWidth() {
    _boxWidth = (screenWidth - 24 * 2 - 24 * 2) / 3;
  }

  static double _boxCount = 102;
  static double get boxCount => _boxCount;
  static void setBoxCount(double i) {
    _boxCount = i;
  }

  //创建所有格子在滚动条中的所有位置的坐标，参数：盒子个数，盒子高度
  //每行3个，间隔24
  static void buildChequerPosition() {
    setChequerOffset([]);

    int col = boxCount ~/ 3;
    List<Offset> offsets = [];

    double y = 24;
    double x = 24;

    for (int j = 0; j <= col - 1; j++) {
      y = 24 + j * (24 + boxWidth);
      x = 24;
      for (int i = 0; i <= 2; i++) {
        x = 24 + i * (24 + boxWidth);
        Offset offset = Offset(x, y);
        offsets.add(offset);
      }
    }

    setChequerOffset(offsets);
  }

  //chequer拖拽时dy坐标减去的从屏幕上方到toolbar的高度
  static double _topHeight = 0;
  static double get topHeight => _topHeight;
  static void setTopHeight(){
    _topHeight = screenHeight - widgetHeight;
  }

  //行的位置
  static List<double>? _rowData ;
  static List<double>? get rowData => _rowData;
  static void setRowData(){
    _rowData =[];
    double x;
    for (int i = 0; i <= 2; i++) {
      x = 24 + i * (24 + boxWidth);
      _rowData?.add(x);
    }
  }

}
