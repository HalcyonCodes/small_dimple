import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:small_dimple/Config/index.dart';
import '../../../../Config/index.dart';
import '../Util/util_body.dart';

class FloatChequer extends StatefulWidget {
  final double width;
  final int itemId;
  final String path;
  final BodyUtil bodyUtil;
  const FloatChequer(
      {Key? key,
      required this.width,
      required this.itemId,
      required this.path,
      required this.bodyUtil})
      : super(key: key);

  @override
  State<FloatChequer> createState() => _FloatChequerState();
}

class _FloatChequerState extends State<FloatChequer> {
  double _x = 0;
  double _y = 0;

  double get x => _x;
  double get y => _y;

  void setPosition(double x, double y) {
    _x = x;
    _y = y;
    refreshUi();
  }

  void refreshUi() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.bodyUtil.setFuncSetFloatChequerPosition(setPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: x,
      left: y,
      child: Stack(
        children: [
          Positioned(
              top: -4,
              left: -4,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 26,
                    height: 26,
                    child: SvgPicture.asset(
                      'assets/icons/systems/错误.svg',
                      fit: BoxFit.cover,
                      color: KColor.primaryColor,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    alignment: Alignment.center,
                  ))),
          Container(
            width: widget.width,
            height: widget.width,
            decoration: BoxDecoration(
                color: KColor.containerColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [KShadow.shadow]),
            alignment: Alignment.center,
            child: Container(
              width: widget.width - 4,
              height: widget.width - 4,
              decoration: BoxDecoration(
                border: Border.all(color: KColor.backgroundColor, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.network(
                widget.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
