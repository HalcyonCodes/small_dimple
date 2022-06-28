import 'package:flutter/material.dart';

//import 'package:small_dimple/WardrobePage/Components/Body/Util/util_body.dart';
import '../../Body/Util/util_body.dart';

import '../ChequerList/list_chequer_body_wardrobe_page.dart';
import '../../../ViewModel/wardrobe_page_viewmodel.dart';
import '../Chequer/dragcontroller_body_wardrobe_page.dart';

class ChequerListPage extends StatefulWidget {
  final WardrobePageViewModel viewModel;
  final AnimationController animationController;
  final BodyUtil bodyUtil;
  const ChequerListPage(
      {Key? key,
      //required this.pageController,
      required this.animationController,
      required this.bodyUtil,
      required this.viewModel})
      : super(key: key);

  @override
  State<ChequerListPage> createState() => _ChequerListPageState();
}

class _ChequerListPageState extends State<ChequerListPage>
    with TickerProviderStateMixin {
  PageController? pageController;

  AnimationController? chequerMoveAnimationController;
  Animation<double>? chequerMoveAnimation;

  void setPageControllerValue(double i) {
    pageController!.jumpTo(i);
  }

  void setPageControllerPage(int i) {
    pageController!.jumpToPage(i);
  }

  List<Widget> boxs = [];

  DragController? dragController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    dragController = DragController(bodyUtil: widget.bodyUtil);

    chequerMoveAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    chequerMoveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: chequerMoveAnimationController!,
            curve: const Interval(0, 1.0, curve: Curves.easeOut)));
    //buildBoxs();
    widget.bodyUtil.setFuncSetPageControllerValue(setPageControllerValue);
    widget.bodyUtil.setFuncSetPageControllerPage(setPageControllerPage);
    widget.bodyUtil.setFuncReFreshBox(refreshUi);
    widget.bodyUtil.setRefreshListInBox([]);
    widget.bodyUtil.setFuncReturnPageAndLockPageWhenPageIsScrolling(
        returnPageAndLockPageWhenPageIsScrolling);
    widget.bodyUtil.setFuncUnLockPageScroll(unLockPageScroll);
    widget.bodyUtil.setPageController(pageController);
    widget.bodyUtil.setFuncPageScroll(setCanScrollRefresh);
    widget.bodyUtil.setBoxListScrollControllers([]);
    widget.bodyUtil.setStartChequerMoveAnimation(chequerMoveAnimationStart);
    widget.bodyUtil.setStopChequerMoveAnimation(chequerMoveAnimationStop);
    widget.bodyUtil.setResetChequerMoveAnimation(chequerMoveAnimationReset);
    widget.bodyUtil
        .setChequerMovAnimationController(chequerMoveAnimationController!);

    //--
    widget.bodyUtil.pageUtil
        .setFuncSetPageControllerValue(widget.bodyUtil.setPageControllerValue);
    widget.bodyUtil.pageUtil
        .setFuncSetPageControllerPage(widget.bodyUtil.setPageControllerPage);
    widget.bodyUtil.pageUtil.setFuncRefreshBox(widget.bodyUtil.refreshBox!);
    widget.bodyUtil.pageUtil.setFuncReturnPageAndLockPageWhenPageIsScrolling(
        widget.bodyUtil.returnPageAndLockPageWhenPageIsScrolling);
    widget.bodyUtil.pageUtil
        .setFuncUnLockPageScroll(widget.bodyUtil.unLockPageScroll);
    widget.bodyUtil.pageUtil.setFuncPageValueTranslateScrollValue(
        widget.bodyUtil.pageValueTranslateScrollValue);
    widget.bodyUtil.pageUtil.setPageController(widget.bodyUtil.pageController);
    //--

    WidgetsBinding.instance.addPostFrameCallback((e) {
      WidgetsBinding.instance.addPostFrameCallback((e) {
        double scrollPosition = 0;
        pageController!.addListener(() {
          widget.bodyUtil.pageUtil.setSpwanedScrollCharacter(1);
          scrollPosition = widget.bodyUtil.pageValueTranslateScrollValue(
              pageController!, MediaQuery.of(context).size.width);
          if (widget.bodyUtil.pageUtil.getStatus!() == 0 &&
              widget.bodyUtil.pageUtil.spwanedScrollCharacter == 1) {
            widget.bodyUtil.pageUtil.setScrollPosition!(scrollPosition);
          }
        });
      });
    });
  }

  void refreshUi() {
    if (mounted) {
      // WidgetsBinding.instance!.addPostFrameCallback((e){
      setState(() {});
      // });
    }
  }

  Future<void> chequerMoveAnimationStart() async {
    //widget.chequerMoveAnimationController!.forward();
    await chequerMoveAnimationController!.forward();
  }

  void chequerMoveAnimationReset() {
    chequerMoveAnimationController!.reset();
  }

  void chequerMoveAnimationStop() {
    chequerMoveAnimationController!.stop();
  }

  void buildBoxs() {
    //print('buildbox');
    widget.viewModel.sortWardrobes();
    boxs = List.generate(widget.viewModel.wardrobes.length, (index) {
      return ChequerList(
          //pageController: widget.pageController,
          chequerMoveAnimationController: chequerMoveAnimationController!,
          chequerMoveAnimation: chequerMoveAnimation!,
          dragController: dragController!,
          boxIndex: index,
          boxId: widget.viewModel.wardrobes[index].wardrobeId!,
          animationController: widget.animationController,
          bodyUtil: widget.bodyUtil,
          viewModel: widget.viewModel);
    });
  }

  bool _canScroll = true;
  bool get canScroll => _canScroll;
  void setCanScroll(bool i) {
    _canScroll = i;
  }

  void setCanScrollRefresh(bool i) {
    setCanScroll(i);
    refreshUi();
  }

  void returnPageAndLockPageWhenPageIsScrolling() {
    double math = pageController!.page! - pageController!.page!.toInt();
    if (math == 0) {
    } else {
      setCanScroll(false);
      int currentPage = pageController!.page!.toInt();
      widget.bodyUtil.pageUtil.setSpwanedScrollCharacter(1);
      pageController!.jumpToPage(currentPage);
      double scrollPosition = widget.bodyUtil.pageValueTranslateScrollValue(
          pageController!, MediaQuery.of(context).size.width);
      widget.bodyUtil.pageUtil.setScrollPosition!(scrollPosition);
      refreshUi();
    }
  }

  void unLockPageScroll() {
    setCanScroll(true);
    refreshUi();
  }

  @override
  Widget build(BuildContext context) {
    buildBoxs();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification) {
            widget.bodyUtil.pageUtil
                .setSpwanedScrollCharacter(0); //解锁上方toolBar不让它执行scrollEnd方法
          }
          return false;
        },
        child: PageView(
          physics:
              canScroll == true ? null : const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: true,
          //allowImplicitScrolling: true,
          controller: pageController,
          children: boxs,
        ),
      ),
    );
  }
}
