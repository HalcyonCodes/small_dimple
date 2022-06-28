import 'package:flutter/material.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../../Components/Toolbar/ToolbarUtil/util_toolbar.dart';
//import 'floaticon_drag_normal_middlepicker_toolbar.dart';
import './floaticon_drag_normal_middlepicker_toolbar.dart';
//import '../../../../../ViewModel/wardrobe_page_viewmodel.dart';
import '../../../../../ViewModel/wardrobe_page_viewmodel.dart';
import './animated_itempicker_normal_middlepicker_toolbar.dart';

class GestureItemPicker extends StatefulWidget {
  final WardrobePageViewModel viewModel;
  final double width;
  final AnimationController animationController;
  final ToolBarUtil toolBarUtil;
  const GestureItemPicker(
      {Key? key,
      required this.width,
      required this.animationController,
      required this.toolBarUtil,
      required this.viewModel})
      : super(key: key);

  @override
  _GestureItemPickerState createState() => _GestureItemPickerState();
}

class _GestureItemPickerState extends State<GestureItemPicker>
    with TickerProviderStateMixin {
  late AnimationController iconRemoveAnimationController;

  LongPressStartDetails startDetail = const LongPressStartDetails();

  OverlayEntry? overlayEntry; //拖拽时出现的图标

  int currentDragIndex = 0; //当前被拖拽的图标的index;

  int targetDragIndex = 0; //拖拽到某位置时图标的index;

  int? animatingMovInIndex; //当前播放撑开icon留白动画的图标的Index

  int? animatingMovOutIndex; //当前播放缩小icon留白动画的图标的Index

  int dragIndex = 0; //被拖动的图标的原始index；

  bool isDraged = false; //判断是否在原地

  bool isBaseIndex = false; //判断是否是第一次拖动且没有过边界

  @override
  void initState() {
    super.initState();
    iconRemoveAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 240)); //被拖拽的icon的返回时动画控制器
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (detail) {
        //widget.toolBarUtil.pageUtil!.setSpwanedScrollCharacter(0);
      },
      onLongPress: () {
        //如果pageview滚动一半
        //toolBar 和 pageview都跳到没滚动完成的那一页
        //锁住pageview滚动
        if (!widget.animationController.isCompleted &&
            !iconRemoveAnimationController.isCompleted) {
          //如果组件本身的加载动画没完成的话就不会执行
        } else {
          widget.toolBarUtil.pageUtil!
              .returnPageAndLockPageWhenPageIsScrolling!();
          setIconAllMid();
          widget
              .toolBarUtil.hasIcon![getLongPressIconIndex(startDetail)]!(false);
          currentDragIndex = getLongPressIconIndex(
              startDetail); //设置初始拖拽图标的index，用于和拖拽后所在的index进行对比从而得到哪个占位符要缩小或者扩张
          dragIndex = currentDragIndex;

          overlayEntry = OverlayEntry(builder: (constext) {
            return FloatIcon(
              controlId: widget.toolBarUtil
                  .getWardrobeIds[getLongPressIconIndex(startDetail)]!(),
              iconPositionAnimationController: iconRemoveAnimationController,
              dx: widget.toolBarUtil
                  .getIconOffset![getLongPressIconIndex(startDetail)]!().dx,
              dy: widget
                      .toolBarUtil
                      .getIconOffset![getLongPressIconIndex(startDetail)]!()
                      .dy +
                  6,
              toolBarUtil: widget.toolBarUtil,
              category: widget.toolBarUtil
                  .getIconCategory![getLongPressIconIndex(startDetail)]!(),
            );
          });
          if (overlayEntry != null) {
            Overlay.of(context)!.insert(overlayEntry!);
          }
        }
      },
      onLongPressStart: (detail) {
        startDetail = detail;
      },
      onLongPressMoveUpdate: (LongPressMoveUpdateDetails detail) {
        if (!widget.animationController.isCompleted &&
            !iconRemoveAnimationController.isCompleted) {
        } else {
          //isDraged = true;
          if (overlayEntry != null) {
            if (widget.toolBarUtil.updateDragPosition != null) {
              widget.toolBarUtil.updateDragPosition!(
                  detail.globalPosition.dx, detail.globalPosition.dy);
            }
          }
          //判断拖拽时对应的选中的间隔并对它进行width扩张动画，并记录选中的图标的index
          targetDragIndex = getMovingIconIndex(
              detail.globalPosition.dx); //得到当前选中的index，为留白的index

          //目标图标在原始拖动图标的左边且相邻
          if (dragIndex - 1 == targetDragIndex) {
            targetDragIndex = dragIndex - 3; //

          } else if (targetDragIndex < dragIndex - 1) {
            targetDragIndex = targetDragIndex - 2;
          }
          if (dragIndex + 1 == targetDragIndex) {
            //目标图标在原始图标的右边且相邻
            isDraged = false;
          }

          if (currentDragIndex <= targetDragIndex &&
              currentDragIndex > targetDragIndex - 2) {
          } else {
            //isBaseIndex = true;

            isDraged = true;
            widget.toolBarUtil.iconMovOut![currentDragIndex]!();
            widget.toolBarUtil.iconMovIn![targetDragIndex]!();

            currentDragIndex = targetDragIndex; //设置当前的index防止重复执行
          }
        }
      },
      onLongPressEnd: (detail) async {
        if (!widget.animationController.isCompleted &&
            !iconRemoveAnimationController.isCompleted) {
        } else {
          int index = 0;
          if (overlayEntry != null) {
            if (!isDraged) {
              index = getLongPressIconIndex(startDetail) + 1;
              int subTagetIndex = 0;
              if (index - 1 == dragIndex) {
                if (!widget.toolBarUtil.getIsEmpty[dragIndex]!() &&
                    widget.toolBarUtil.getIsEmpty[index]!()) {
                  //当图标本身不展开时
                  subTagetIndex = dragIndex;
                } else if (widget.toolBarUtil.getIsEmpty[dragIndex]!() &&
                    !widget.toolBarUtil.getIsEmpty[index]!()) {
                  //图标的下一个占白区域展开时
                  subTagetIndex = index;
                }
              }

              widget.toolBarUtil.setIconRemoveTarget!(
                  widget.toolBarUtil.getIconOffset![subTagetIndex]!().dx,
                  widget.toolBarUtil.getIconOffset![subTagetIndex]!().dy);
            } else {
              //-------------------
              //这个地方的算法不能动，反正能工作，原因未知
              //-------------------
              index = getMovingIconIndex(
                  detail.globalPosition.dx); //得到当前选中的index，为留白的index

              //目标图标在原始拖动图标的左边且相邻
              if (dragIndex - 1 == index) {
                index = dragIndex - 3; //
              } else if (index < dragIndex - 1) {
                index = index - 2;
              }
              //--------------------
              widget.toolBarUtil.setIconRemoveTarget!(
                  widget.toolBarUtil.getIconOffset![index]!().dx, //
                  widget.toolBarUtil.getIconOffset![index]!().dy //- 6
                  );
            }

            await iconRemoveAnimationController.forward();
            if (iconRemoveAnimationController.isCompleted) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                //--判断icon缩小拉伸的动画结束没，没有的话直接结束----
                //await initIconAnimatedStatus();
                await delayIconAnimated();
                //------------
                overlayEntry!.remove();
                overlayEntry = null;
                setIconAllGrey();
                iconRemoveAnimationController.reset();
                //初始化拖拽时的对比index
                targetDragIndex = 0;
                currentDragIndex = 0;
                //----设置图标队列------
                //print(widget.toolBarUtil.getIconListCount!());
                int targetId = widget.toolBarUtil.getWardrobeIds[index % 2 == 0
                    ? index
                    : index == widget.toolBarUtil.getIconListCount!() - 2
                        ? index - 1
                        : index + 1]!();
                int sortIndex =
                    widget.toolBarUtil.getIconInViewModelIndex(index);
                int controlId = widget.toolBarUtil.getControlId!();
                widget.viewModel
                    .updateWardrobeSort(targetId, controlId, sortIndex);
                double scroll = widget.toolBarUtil.getScrollPosition!();
                widget.toolBarUtil.setScrollInitPosition!(scroll);
                initIconStack(index);
                //rebuidIconListId();
                widget.toolBarUtil.refreshItemPicker!();
                rebuildIconListId();
                widget.toolBarUtil
                    .setIconMid!(widget.toolBarUtil.selectIconMid!());

                int targetIndex = widget.toolBarUtil.pageUtil!
                    .iconDecorationsIndexTranslatePage!(index);
                int startIndex = widget.toolBarUtil.pageUtil!
                    .iconDecorationsIndexTranslatePage!(dragIndex);
                //print ('startIndex' + startIndex.toString());
                //print('targetIndex' + targetIndex.toString());
                //int targetPageIndex = widget.toolBarUtil.pageUtil!.iconDecorationsIndexTranslatePage!(widget.toolBarUtil.selectIconMid!());
                //print(pageIndex);
                widget.toolBarUtil.pageUtil!.refreshBox!();
                //widget.toolBarUtil.pageUtil!.refreshBox!();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //widget.toolBarUtil.pageUtil!.refreshBoxList[pageIndex]();
                  List<int> intList =
                      selectRefreshBoxAfterDragIcon(startIndex, targetIndex);
                  //print(e);
                  //print(intList);
                  for (var e in intList) {
                    if (e <=
                        widget.toolBarUtil.pageUtil!.refreshBoxList.length -
                            1) {
                      //由于有些页面pageview没有加载并注册refresh方法，所以需要空掉
                      widget.toolBarUtil.pageUtil!.refreshBoxList[e]();
                    }
                  }
                  //解锁pageview滚动
                  widget.toolBarUtil.pageUtil!.unLockPageScroll!();
                });
              });
            }
          }
        }
        isDraged = false;
      },
      child: AnimatedItemPicker(
        toolBarUtil: widget.toolBarUtil,
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                const Interval((1 / 3) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        width: widget.width,
        viewModel: widget.viewModel,
      ),
    );
  }

  void initIconStack(int targetIndex) {
    //还原图标队列属性
    widget.toolBarUtil.hasIcon![dragIndex]!(true);
    widget.toolBarUtil.iconAnimationControllers[targetIndex].value = 0.0;
    widget.toolBarUtil.setIsEmpty[targetIndex]!(true);
    widget.toolBarUtil.iconAnimationControllers[dragIndex].value = 1.0;
    widget.toolBarUtil.setIsEmpty[dragIndex]!(false);
  }

  //选定拖拽后box需要变化的box范围, 参数为icondecoration转化为原始boxIndex后的index
  List<int> selectRefreshBoxAfterDragIcon(int startIndex, int targetIndex) {
    List<int> result = [];

    if (startIndex - targetIndex > 0) {
      //说明是把后方图标往前拽
      //result.add(targetIndex);
      for (int i = 0; i <= startIndex - targetIndex; i++) {
        result.add(targetIndex + i);
      }
      //result.add(startIndex);

    } else if (startIndex - targetIndex < 0) {
      //说明是把前方图标往后拽
      //result.add(targetIndex);
      for (int i = 0; i <= targetIndex - startIndex; i++) {
        result.add(startIndex + i);
      }
      //result.add(startIndex);
    }
    return result;
  }

  //得到当长按时按的位置的图标在元件列表中的index
  int getLongPressIconIndex(LongPressStartDetails detail) {
    List<double> scrollBound = widget.toolBarUtil.scrollBound;
    double keyPressDx = detail.globalPosition.dx -
        24 -
        16 -
        24 -
        20; //得到点击处在本组件中的距离：点击处 - 左留白 - 内边距 - 图标 - 图标到本体距离
    double currentScrollPosition = widget.toolBarUtil.getScrollPosition!();
    double spwanedPressDx = keyPressDx + currentScrollPosition; //
    int iconIndex =
        getKeyPressDxInScrollBoundIndex(spwanedPressDx, scrollBound); //
    return iconIndex;
  }

  //得到拖拽时拖拽到的位置的图标在元件列表中的index; //如果得到的不是留白区域则index+1得到留白区域的index
  int getMovingIconIndex(double x) {
    List<double> scrollBound = widget.toolBarUtil.scrollBound;
    double keyPressDx =
        x - 24 - 16 - 24 - 20; //得到点击处在本组件中的距离：点击处 - 左留白 - 内边距 - 图标 - 图标到本体距离
    double currentScrollPosition = widget.toolBarUtil.getScrollPosition!();
    double spwanedPressDx = keyPressDx + currentScrollPosition; //
    int iconIndex =
        getKeyPressDxInScrollBoundIndex(spwanedPressDx, scrollBound);
    if (!widget.toolBarUtil.getIsSpace![iconIndex]!()) {
      //如果得到的不是留白区域则index+1得到留白区域的index
      iconIndex = iconIndex + 1;
    }
    return iconIndex;
  }

  //根据icon在滚动条中的边界的列表计算出 dx在第几个index中
  int getKeyPressDxInScrollBoundIndex(double dx, List<double> iconsBound) {
    int iconIndex = 0;
    for (int i = 1; i <= iconsBound.length - 4; i++) {
      if (dx >= iconsBound[i] && dx < iconsBound[i + 2]) {
        iconIndex = i;
        return iconIndex;
      }
      if (dx < iconsBound[3]) {
        iconIndex = 2;
        return iconIndex;
      }
      if (dx >= iconsBound[iconsBound.length - 3]) {
        iconIndex = iconsBound.length - 3;
        return iconIndex;
      }
    }
    return iconIndex;
  }

  void rebuildIconListId() {
    for (int index = 0;
        index <
            widget.viewModel.wardrobes.length +
                widget.viewModel.wardrobes.length +
                1 +
                1;
        index++) {
      if (index <= 1) {
        //-------占位----------
        widget.toolBarUtil.setIconIdInState[index]!(-1);
      } else if (index > 1 &&
          index <
              (widget.viewModel.wardrobes.length +
                  widget.viewModel.wardrobes.length +
                  1)) {
        if (index % 2 == 0) {
          //此时为留白处

          widget.toolBarUtil.setIconIdInState[index]!(
              widget.viewModel.wardrobes[index ~/ 2 - 1].wardrobeId!);
        } else {
          widget.toolBarUtil.setIconIdInState[index]!(-1);
        }
      } else if (index >=
          (widget.viewModel.wardrobes.length +
              widget.viewModel.wardrobes.length +
              1)) {
        //-------占位----------
        widget.toolBarUtil
            .setIconIdInState[index]!(widget.viewModel.wardrobes.length - 1);
      }
    }
  }

  //把图标全部变成黑色
  void setIconAllMid() {
    for (int i = 0; i < widget.toolBarUtil.getIconListCount!(); i++) {
      widget.toolBarUtil.refreshIsMid[i](true);
    }
  }

  //把图标全部置灰
  void setIconAllGrey() {
    for (int i = 0; i < widget.toolBarUtil.getIconListCount!(); i++) {
      widget.toolBarUtil.refreshIsMid[i](false);
    }
  }

  //判断是否icon拉伸动画是否执行，执行的话等待执行完成
  Future<void> delayIconAnimated() async {
    int t = 0;
    while (t == 0) {
      for (int i = 0; i < widget.toolBarUtil.getIconListCount!(); i++) {
        if (widget.toolBarUtil.getIconMovInStatus[i]!() ||
            widget.toolBarUtil.getIconMovOutStatus[i]!()) {
          Future.delayed(const Duration(microseconds: 3));
        } else {
          t = 1;
        }
      }
    }
  }
}
