import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../Config/index.dart';

class SearchPicker extends StatefulWidget {
  final FocusNode verifyNode;
  const SearchPicker({Key? key, required this.verifyNode}) : super(key: key);

  @override
  _SearchPickerState createState() => _SearchPickerState();
}

class _SearchPickerState extends State<SearchPicker> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 24,
      color: KColor.containerColor,
      padding: EdgeInsets.zero,
      child: 
        TextField(
        focusNode: widget.verifyNode,
        controller: controller,
        maxLines: 1,
        style: KFont.toolBarSearchStyle,
        autofocus: false, //自动对焦
        cursorColor: Colors.black, //光标颜色
        cursorWidth: 2,
        cursorHeight: 24,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(200),
        ],
        maxLength: null,
        onChanged: (text){},
        onSubmitted: (text) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: KString.toolBarSearchInitString,
          contentPadding: EdgeInsets.zero,
          hintStyle: KFont.toolBarSearchInitStyle,
          isDense: true,
          hintMaxLines: 1,
        ),
        
      ),
    );
  }
}
