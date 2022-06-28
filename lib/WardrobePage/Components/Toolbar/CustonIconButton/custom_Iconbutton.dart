import 'package:flutter/material.dart';
//import 'package:small_dimple/config/index.dart';
import '../../../../Config/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final bool? isEnable;
  //final void Function()? onClick;
  final String iconPath;
  final Color? color;

  const CustomIconButton(
      {Key? key, required this.iconPath, this.color, this.isEnable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: KColor.containerColor,
      width: 24,
      height: 24,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.cover,
        height: 24,
        width: 24,
        color: color == null
            ? KColor.greyColor
            : isEnable == false || isEnable == null
                ? color!.withOpacity(0.4)
                : color,
      ),
    );
  }
}
