import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
//import 'package:small_dimple/WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
import '../../../../../../Config/index.dart';
import '../../../../Toolbar/ToolbarUtil/util_toolbar.dart';
//mport '../../../../../ViewModel/wardrobe_page_viewmodel.dart';
import '../../../../../../WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
import './sizespace_normal_middlepicker_toolbar.dart';
import './icondecoration_normal_middlepicker_toolbar.dart';

class ItemPicker extends StatefulWidget {
  final double? scrollInitOffset;
  final double dWidth;
  final ToolBarUtil toolBarUtil;
  final WardrobePageViewModel viewModel;

  const ItemPicker({
    Key? key,
    required this.dWidth,
    required this.toolBarUtil,
    required this.viewModel,
    this.scrollInitOffset,
  }) : super(key: key);

  @override
  _ItemPickerState createState() => _ItemPickerState();
}

class _ItemPickerState extends State<ItemPicker> {
  late ScrollController scrollController;

  List<Widget> iconDecorations = []; //存放所有图标元素

  List<double> scrollBound = []; //存放图标所在位置的间隔

  double whiteSpace = 0;

  int iconIndex = 2; //后期需要修改

  double _scrollInitOffset = 0;

  double get scrollInitOffset => _scrollInitOffset;

  void setScrollInitOffset(double i) {
    _scrollInitOffset = i;
  }

  @override
  void initState() {
    super.initState();

    widget.scrollInitOffset == null
        ? 9 + 13
        : setScrollInitOffset(widget.scrollInitOffset!);
    scrollController = ScrollController(initialScrollOffset: scrollInitOffset);

    whiteSpace =
        (widget.dWidth - 24 * 2 - 16 * 2 - 24 * 2 - 20 * 2) / 2; //滚动条显示的部分的一半
    widget.toolBarUtil.setRefreshIsMid([]);
    widget.toolBarUtil.setGetIconOffset([]);
    widget.toolBarUtil.setGetIconCategory([]);
    widget.toolBarUtil.setHasIcon([]);
    widget.toolBarUtil.setIconMovIn([]);
    widget.toolBarUtil.setIconMovOut([]);
    widget.toolBarUtil.setgetIsSpaceStatus([]);
    widget.toolBarUtil.setIconAnimationControllers([]);
    widget.toolBarUtil.setGetWardrobeIds([]);
    widget.toolBarUtil.setFuncSetIsEmpty([]);
    widget.toolBarUtil.setFuncSetIconIdInState([]);
    widget.toolBarUtil.setFuncGetIconMovInStatus([]);
    widget.toolBarUtil.setFuncGetIconMovOutStatus([]);
    widget.toolBarUtil.setFuncSetIconMovInStatus([]);
    widget.toolBarUtil.setFuncSetIconMovOutStatus([]);
    widget.toolBarUtil.setFuncGetIsEmpty([]);
    //---------------------------------------------------
    widget.toolBarUtil.setRefreshItemPicker(refreshItemPicker);
    widget.toolBarUtil.setFuncSetScrollInitPosition(setScrollInitOffset);
    widget.toolBarUtil.setGetIconListCount(getIconListCount);
    widget.toolBarUtil.setSelectIconMid(selectIconMid);
    widget.toolBarUtil.setFuncSetIconMid(setIconMid);
    widget.toolBarUtil.setFuncSetScrollInitPosition(setScrollInitOffset);
    //widget.toolBarUtil.setFuncSetScrollInitPosition(setScrollPosition);
    //widget.toolBarUtil.setFuncSetScrollPosition(setScrollPosition);
    iconDecorations = [];
    iconDecorations = buidIconDecoration();
    //selectScrollBound();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectScrollBound();
      setIconMid(iconIndex);
      widget.toolBarUtil.setGetScrollPosition(getScrollPositon);
      widget.toolBarUtil.pageUtil!.setFuncSetScrollPosition(setScrollPosition);
    });
  }

  List<Widget> buidIconDecoration() {
    List<Widget> i = [];
    i.add(SizedSpace(
        width: whiteSpace, toolBarUtil: widget.toolBarUtil, height: 48));
    List<Widget> temps = List.generate(
        (widget.viewModel.wardrobes.length +
            widget.viewModel.wardrobes.length +
            1), //图标个数 + 留白个数
        (index) {
      if (index == 0) {
        //-------占位----------
        return IconDecoration(
          id: -1,
          toolBarUtil: widget.toolBarUtil,
          category: '上装',
          isSpace: true,
        );
      } else if (index > 0 &&
          index <
              (widget.viewModel.wardrobes.length +
                  widget.viewModel.wardrobes.length)) {
        if (index % 2 == 0) {
          //此时为留白处
          return IconDecoration(
            id: -1,
            toolBarUtil: widget.toolBarUtil,
            category: '上装',
            isSpace: true,
          );
        } else {
          return IconDecoration(
            id: widget.viewModel.wardrobes[index ~/ 2].wardrobeId!,
            toolBarUtil: widget.toolBarUtil,
            category: widget.viewModel.wardrobes[index ~/ 2].category!,
            isSpace: false,
          );
        }
      } else if (index ==
          (widget.viewModel.wardrobes.length +
              widget.viewModel.wardrobes.length)) {
        //-------占位----------
        return IconDecoration(
          id: -1,
          toolBarUtil: widget.toolBarUtil,
          category: '上装',
          isSpace: true,
        );
      }
      return IconDecoration(
        id: -1,
        toolBarUtil: widget.toolBarUtil,
        category: '上装',
        isSpace: true,
      );
    });
    i.addAll(temps);
    i.add(SizedSpace(
        width: whiteSpace, toolBarUtil: widget.toolBarUtil, height: 48));
    return i;
  }

  @override
  Widget build(BuildContext context) {
    iconDecorations = [];
    iconDecorations = buidIconDecoration();

    scrollController = ScrollController(initialScrollOffset: scrollInitOffset);
    return Container(
        width: MediaQuery.of(context).size.width -
            24 * 2 -
            16 * 2 -
            24 * 2 -
            20 * 2, //留白 * 2 + 内边距 * 2 + 左右图标 * 2 + 图标到主体距离 * 2
        height: 48,
        color: KColor.containerColor,
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              //widget.toolBarUtil.pageUtil!.setSpwanedScrollCharacter(0);

            }
            if (notification is ScrollUpdateNotification) {
              iconIndex = selectIconMid();
              setIconMid(iconIndex);
            }
            if (notification is ScrollEndNotification) {
              //这里需要加入对page的判断
              if (widget.toolBarUtil.pageUtil!.spwanedScrollCharacter == 0) {
                dragPosition();
                int page = widget.toolBarUtil
                    .iconDecorationsIndexTranslatePage(iconIndex);
                //
                widget.toolBarUtil.pageUtil!.setPageControllerPage!(page);
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: iconDecorations,
            ),
          ),
        ));
  }

  void selectScrollBound() {
    widget.toolBarUtil.setScrollBound([]);
    double baseBound = whiteSpace; //- 9 - 13 ; //显示的一半 - icon一半 - 边界一半
    scrollBound.add(baseBound);
    scrollBound.add(baseBound);
    scrollBound.add(baseBound);
    scrollBound.add(baseBound);
    for (int i = 4; i <= iconDecorations.length - 3; i++) {
      if (widget.toolBarUtil.getIsSpace![i]!()) {
        //当它是留白时,边界将与icon图标重叠
        scrollBound.add(baseBound);
      } else {
        baseBound = baseBound + 9 + 24 + 9; //初始 + icon左半边界 + 一个icon + 右半边界
        scrollBound.add(baseBound);
      }
    }
    scrollBound.add(baseBound);
    scrollBound.add(baseBound + 9 + 24 + 9);
    widget.toolBarUtil.setScrollBound(scrollBound);
  }

  void dragPosition() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      double distance = 0;
      distance = scrollBound[iconIndex] + 9 + 12 - whiteSpace;
      await scrollController.animateTo(distance,
          duration: const Duration(milliseconds: 60), curve: Curves.linear);
    });
  }

  int selectIconMid() {
    int index = 0;
    double currentPosition = scrollController.position.pixels + whiteSpace;
    for (int i = 1; i <= iconDecorations.length - 4; i++) {
      if (currentPosition >= scrollBound[i] &&
          currentPosition < scrollBound[i + 2]) {
        index = i;
        return index;
      }
      if (currentPosition < scrollBound[3]) {
        index = 2;
        return index;
      }
      if (currentPosition >= scrollBound[iconDecorations.length - 3]) {
        index = iconDecorations.length - 3;
        return index;
      }
    }
    return index;
  }

  void setIconMid(int index) {
    if (index - 2 >= 0) {
      //本来是index -1 ，因为多了留白所以变为 index - 2，
      widget.toolBarUtil.refreshIsMid[index - 2](false);
    }
    if (index >= 0 && index <= widget.toolBarUtil.refreshIsMid.length - 1) {
      widget.toolBarUtil.refreshIsMid[index](true);
    }
    if (index + 2 <= widget.toolBarUtil.refreshIsMid.length - 1) {
      //本来是 index + 1 表示下一个，结果因为留白表示下2个 index + 2
      widget.toolBarUtil.refreshIsMid[index + 2](false);
    }
  }

  double getScrollPositon() {
    return scrollController.position.pixels;
  }

  void refreshItemPicker() {
    setState(() {});
  }

  int getIconListCount() {
    return iconDecorations.length;
  }

  void setScrollPosition(double x) {
    scrollController.jumpTo(x);
  }
}
