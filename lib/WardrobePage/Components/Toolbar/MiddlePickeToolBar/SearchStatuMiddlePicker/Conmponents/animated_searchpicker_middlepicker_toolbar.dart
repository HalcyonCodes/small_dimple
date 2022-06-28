import 'package:flutter/material.dart';
import './searchpicker_middlepicker_toolbar.dart';

class AnimatedSearchPicker extends StatelessWidget {


  final AnimationController animationController;
  final Animation<double> animation;
  final FocusNode verifyNode;
  const AnimatedSearchPicker({ Key? key, required this.verifyNode, required this.animationController, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return 
              FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      30 * (1.0 - animation.value), 0.0, 0.0),
                  child: SearchPicker(verifyNode: verifyNode,),
                ),
              );
           
        });
  }
}