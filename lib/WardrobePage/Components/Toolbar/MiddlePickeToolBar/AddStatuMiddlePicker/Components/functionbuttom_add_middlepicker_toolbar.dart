import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
import '../../../../../../Config/index.dart';
import '../../../CustonIconButton/custom_iconbutton.dart';

class FunctionButtom extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  const FunctionButtom(
      {Key? key, required this.animationController, required this.animation})
      : super(key: key);

  @override
  _FunctionButtomState createState() => _FunctionButtomState();
}

class _FunctionButtomState extends State<FunctionButtom> {
  List<Widget> functionButtoms = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionButtoms = [
      InkWell(
        onTap: () {},
        child: const SizedBox(
          width: 48,
          height: 48,
          child: CustomIconButton(
            iconPath: 'assets/icons/systems/照相机.svg',
            isEnable: true,
            color: Colors.black,
            // onClick: (){},
          ),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      InkWell(
        onTap: () {},
        child: const SizedBox(
          width: 48,
          height: 48,
          child: CustomIconButton(
            iconPath: 'assets/icons/systems/图片.svg',
            isEnable: true,
            color: Colors.black,
            // onClick: (){},
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              FadeTransition(
                opacity: widget.animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        30 * (1.0 - widget.animation.value), 0.0, 0.0),
                    child: Container(
                      color: KColor.containerColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: functionButtoms,
                        ),
                      ),
                    )),
              ),
            ],
          );
        });
  }
}
