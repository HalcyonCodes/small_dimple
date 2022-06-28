import 'package:flutter/material.dart';
import '../../../../Config/config_chequer_position.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Config/index.dart';
import '../Util/util_body.dart';

class AnimatedChequer extends AnimatedWidget {
  final AnimationController animationController;
  final AnimationController buildAnimationController;
  final Animation<double> animation;
  final Animation<double> buildAnimation;
  final bool isSpace;
  final bool isInDrag;
  final String path;
  final Offset startOffset;
  final Offset targetOffset;
  final BodyUtil bodyUtil;
  final int chequerId;
  final int boxId;
  //--
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function()? onLongPress;
  final Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate;
  final Function(LongPressEndDetails)? onLongPressEnd;
  //final Function(DragStartDetails)? onPanStart;
  //final Function(DragUpdateDetails)? onPanUpdate;
  //final Function(DragEndDetails)? onPanEnd;
  //final Function(TapDownDetails)? onTapDown;
  //--
  final Function(DragDownDetails)? onVerticalDragDown;
  final Function(DragStartDetails)? onVerticalDragStart;
  final Function(DragUpdateDetails)? onVerticalDragUpdate;
  final Function(DragEndDetails)? onVerticalDragEnd;
  final Function()? onVerticalDragCancel;
  final Function(DragDownDetails)? onHorizontalDragDown;
  final Function(DragStartDetails)? onHorizontalDragStart;
  final Function(DragUpdateDetails)? onHorizontalDragUpdate;
  final Function(DragEndDetails)? onHorizontalDragEnd;
  final Function()? onHorizontalDragCancel;



  const AnimatedChequer(
      {Key? key,
      required this.animationController,
      required this.buildAnimationController,
      required this.buildAnimation,
      required this.animation,
      required this.isInDrag,
      required this.isSpace,
      required this.path,
      required this.startOffset,
      required this.targetOffset,
      required this.onLongPress,
      required this.onLongPressEnd,
      required this.onLongPressMoveUpdate,
      required this.onLongPressStart,
      required this.bodyUtil,
      required this.chequerId,
      required this.boxId,
      //required this.onPanEnd,
      //required this.onPanStart,
      //required this.onPanUpdate,
      //required this.onTapDown,
      //--
      required this.onVerticalDragDown,
      required this.onVerticalDragCancel,
      required this.onVerticalDragEnd,
      required this.onVerticalDragStart,
      required this.onVerticalDragUpdate,
      required this.onHorizontalDragCancel,
      required this.onHorizontalDragDown,
      required this.onHorizontalDragEnd,
      required this.onHorizontalDragStart,
      required this.onHorizontalDragUpdate,
    
      })
      : super(key: key, listenable: animationController);

    

  @override
  Widget build(BuildContext context) {
    //print('target' + targetOffset.dx.toString());
    //print('current' + currentOffset.dx.toString());
    /*double top = currentOffset.dy +
        (targetOffset.dy - currentOffset.dy) * animation.value;
        //print(targetOffset.dx);
        //print(currentOffset.dy);
    double left = currentOffset.dx +
        (targetOffset.dx - currentOffset.dx) * animation.value;*/
      double top = startOffset.dy +
        (targetOffset.dy - startOffset.dy) * animation.value;
        //print(targetOffset.dx);
        //print(currentOffset.dy);
    double left = startOffset.dx +
        (targetOffset.dx - startOffset.dx) * animation.value;
    bodyUtil.listSetCurrentOffset[boxId][chequerId]!(Offset(left,top));

    return Positioned(
        //Transform(
        top: top,
        left: left,
        //transform: Matrix4.translationValues(left, top, 0.0),
        child: GestureDetector(
          onLongPressStart: onLongPressStart,
          onLongPress: onLongPress,
          onLongPressMoveUpdate: onLongPressMoveUpdate,
          onLongPressEnd: onLongPressEnd,
          //onPanStart: onPanStart,
          //onPanUpdate: onPanUpdate,
          //onPanEnd: onPanEnd,
          //onTapDown: onTapDown,
          onHorizontalDragStart: onHorizontalDragStart,
          onHorizontalDragDown: onHorizontalDragDown,
          onHorizontalDragCancel: onHorizontalDragCancel,
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onHorizontalDragEnd: onHorizontalDragEnd,
          onVerticalDragStart: onVerticalDragStart,
          onVerticalDragDown: onVerticalDragDown,
          onVerticalDragCancel: onVerticalDragCancel,
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: onVerticalDragEnd,

          child:AnimatedBuilder(
              animation: buildAnimationController,
              builder: (context, child) {
                return SizedBox(
                  height: ChequerPosition.boxWidth,
                  width: ChequerPosition.boxWidth,
                  child: FadeTransition(
                    opacity: buildAnimation,
                    child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 30 * (1.0 - buildAnimation.value), 0.0),
                        child: Builder(builder: (context) {
                          return isSpace
                              ? !isInDrag
                                  ? SizedBox(
                                      width: ChequerPosition.boxWidth,
                                      height: ChequerPosition.boxWidth,
                                    )
                                  :
                                  //为空且进入拖动状态，为拖拽时的空位组件
                                  Container(
                                      width: ChequerPosition.boxWidth,
                                      height: ChequerPosition.boxWidth,
                                      decoration: BoxDecoration(
                                        //border: //拖进来后会显示光圈
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: SvgPicture.asset(
                                          'assets/icons/systems/加号.svg',
                                          color: KColor.primaryColor
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    )
                              : Stack(
                                  children: [
                                    
                                    Container(
                                      width: ChequerPosition.boxWidth,
                                      height: ChequerPosition.boxWidth,
                                      decoration: BoxDecoration(
                                          color: KColor.containerColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [KShadow.shadow]),
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: ChequerPosition.boxWidth - 8.0,
                                        height: ChequerPosition.boxWidth - 8.0,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //color: KColor.backgroundColor,
                                          //width: 2.2
                                          // ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        alignment: Alignment.center,
                                        child: Container(
                                          //width: width - 24.0,
                                          //height: width - 24.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Image.network(
                                            path,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    isInDrag
                                        ? Transform(
                                            transform: Matrix4.translationValues(
                                                -4, -4, 0),
                                            //Positioned(
                                            // top: top,
                                            //  left: ,
                                            child: GestureDetector(
                                                onTap: () {
                                                  print('删除物品');
                                                },
                                                child: 
                                                Container(
                                                  width: 26,
                                                  height: 26,
                                                  child: SvgPicture.asset(
                                                    //'assets/icons/systems/放大镜.svg',
                                                    'assets/icons/systems/错误.svg',
                                                    fit: BoxFit.cover,
                                                    color: KColor.primaryColor,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    //color: Colors.black.withOpacity(0.0),
                                                    borderRadius:
                                                        BorderRadius.circular(13),
                                                  ),
                                                  alignment: Alignment.center,
                                                )))
                                        : const SizedBox(),
                                  ],
                                );
                        })),
                  ),
                );
              }),
        ));
  }



 

}
