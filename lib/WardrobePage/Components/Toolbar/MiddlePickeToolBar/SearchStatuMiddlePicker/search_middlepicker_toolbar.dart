import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/CustonIconButton/animated_custom_iconbutton.dart';
//import 'package:small_dimple/WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../../Config/index.dart';
import '../../../Toolbar/CustonIconButton/animated_custom_iconbutton.dart';
//import '../../../Toolbar/ToolbarUtil/util_toolbar.dart';
import '../../../../../WardrobePage/Components/Toolbar/ToolbarUtil/util_toolbar.dart';
import './Conmponents/animated_searchpicker_middlepicker_toolbar.dart';
import '../../../../ViewModel/wardrobe_page_viewmodel.dart';



class SearchMiddlePickerToolBar extends StatefulWidget {

   SearchMiddlePickerToolBar({Key? key,required this.animationController, required this.toolBarUtil, required this.viewModel}) : super(key: key);
  final AnimationController animationController;
  final ToolBarUtil toolBarUtil;
  final WardrobePageViewModel viewModel;
  final FocusNode verifyNode = FocusNode();


  @override
  State<SearchMiddlePickerToolBar> createState() => _SearchMiddlePickerToolBarState();
}

class _SearchMiddlePickerToolBarState extends State<SearchMiddlePickerToolBar> {

  @override
  void initState() {
  super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(!widget.animationController.isCompleted){
        //widget.animationController.reset();
        await widget.animationController.forward();
      }
    });
  }


 



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 24 * 2 - 16 * 2,
      height: 30,
      color: KColor.containerColor,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCustomIconButton(
            animationController: widget.animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: const Interval((1 / 3) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/放大镜.svg',
            isEnable: false,
            color: Colors.black,
            onClick: () {},
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: AnimatedSearchPicker(
              animationController: widget.animationController,
              verifyNode: widget.verifyNode,
              animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: const Interval((1 / 3) * 1, 1.0,
                          curve: Curves.fastOutSlowIn))),
            ),
          ),

          //Expanded(child: SizedBox(),),
          const SizedBox(
            width: 16,
          ),
          AnimatedCustomIconButton(
            animationController: widget.animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: const Interval((1 / 3) * 2, 1.0,
                        curve: Curves.fastOutSlowIn))),
            iconPath: 'assets/icons/systems/向左.svg',
            isEnable: true,
            color: Colors.black,
            onClick: () {
                widget.verifyNode.unfocus();
                widget.animationController.reverse().then((value) {
                widget.toolBarUtil.setStatus!(0);
                widget.toolBarUtil.setToolBarStatus(0);
                widget.toolBarUtil.refreshToolBar!();
              });
            },
          )
        ],
      ),
    );
  }
}