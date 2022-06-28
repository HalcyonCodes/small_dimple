import 'package:flutter/material.dart';
import '../../../Config/index.dart';
import './MiddlePickeToolBar/NormalStatuMiddlePicker/normal_middlepicker_toolbar.dart';
import './MiddlePickeToolBar/AddStatuMiddlePicker/add_middlepicker_toolbar.dart';
import './MiddlePickeToolBar/SearchStatuMiddlePicker/search_middlepicker_toolbar.dart';
import '../../../WardrobePage/ViewModel/wardrobe_page_viewmodel.dart';
import '../../../WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../WardrobePage/PageUtil/util_page.dart';

class ToolBar extends StatefulWidget implements PreferredSizeWidget {
  final WardrobePageViewModel viewModel;
  final PageUtil pageUtil;
  final double paddingHeight;
  const ToolBar(
      {Key? key,
      required this.viewModel,
      required this.pageUtil,
      required this.paddingHeight})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> with TickerProviderStateMixin {
  ToolBarUtil? toolBarUtil;
  late AnimationController animationController;

  int _status = 0; //0表示正常状态，1表示搜索状态，2表示添加状态
  int get status => _status;
  void setStatus(int i) {
    _status = i;
  }

  @override
  void initState() {
    super.initState();
    widget.pageUtil.setBoxCount(widget.viewModel.wardrobes.length);
    toolBarUtil = ToolBarUtil(pageUtil: widget.pageUtil);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    toolBarUtil!.setStatusFunction(setStatus);
    toolBarUtil!.setRefreshToolBar(refreshUi);
    toolBarUtil!.pageUtil!
        .setFuncGetIconBoundBase(toolBarUtil!.getIconBoundBase);
    toolBarUtil!.pageUtil!.setIconDecorationsIndexTranslatePage(
        toolBarUtil!.iconDecorationsIndexTranslatePage);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //把toolBarutil里的方法注册到pageUtil里
      toolBarUtil!.pageUtil!
          .setFuncSetScrollPosition(toolBarUtil!.setScrollPosition);
      toolBarUtil!.pageUtil!.setFuncGetStatus(toolBarUtil!.getToolBarStatus);
      //widget.pageUtil.setScrollBound(toolBarUtil.scrollBound);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).padding.top);
    return SizedBox(
      height: widget.paddingHeight + 48,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.top,
            color: KColor.primaryColor,
          ),
          SizedBox(
            height: 48,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 24,
                  color: KColor.primaryColor,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 24 * 2,
                  height: 48,
                  decoration: BoxDecoration(
                    color: KColor.containerColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [KShadow.shadow],
                  ),
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: status == 0
                      ? NormalMiddlePickerToolBar(
                          viewModel: widget.viewModel,
                          toolBarUtil: toolBarUtil!,
                          animationController: animationController)
                      : status == 1
                          ? SearchMiddlePickerToolBar(
                              viewModel: widget.viewModel,
                              toolBarUtil: toolBarUtil!,
                              animationController: animationController,
                            )
                          : AddMiddlePickerToolBar(
                              viewModel: widget.viewModel,
                              toolBarUtil: toolBarUtil!,
                              animationController: animationController,
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void refreshUi() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}
