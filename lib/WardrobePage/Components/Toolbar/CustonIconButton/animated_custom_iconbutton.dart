import 'package:flutter/material.dart';
import 'custom_iconbutton.dart';

class AnimatedCustomIconButton extends StatefulWidget {
  final String iconPath;
  final Color? color;
  final bool? isEnable;
  final void Function()? onClick;
  final Animation<double> animation;
  final AnimationController animationController;

  const AnimatedCustomIconButton({
    Key? key,
    required this.iconPath,
    this.color,
    this.isEnable,
    this.onClick,
    required this.animation,
    required this.animationController,
  }) : super(key: key);

  @override
  _AnimatedCustomIconButtonState createState() =>
      _AnimatedCustomIconButtonState();
}

class _AnimatedCustomIconButtonState extends State<AnimatedCustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onInWellClick,
      child: AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: widget.animation,
              child: Transform(
                transform: Matrix4.translationValues(
                    30 * (1.0 - widget.animation.value), 0.0, 0.0),
                child: CustomIconButton(
                  iconPath: widget.iconPath,
                  color: widget.color,
                  isEnable: widget.isEnable,
                ),
              ),
            );
          }),
    );
  }

  void Function()? onInWellClick() {
    widget.onClick == null ? () {} : widget.onClick!();
    return null;
  }
}
