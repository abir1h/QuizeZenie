import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/common_imports.dart';

class TextFieldWidget extends StatefulWidget with AppTheme {
  final TextEditingController controller;
  final String hintText;
  final bool multiline;
  final TextInputType keyboardType;
  final String? prefixIcon;
  final bool obscure;
  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.multiline = false,
      this.keyboardType = TextInputType.text,
        this.prefixIcon,
      this.obscure = false})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> with AppTheme {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: 0),
      decoration: BoxDecoration(
        color: clr.whiteColor,
        border: Border.all(
          color: clr.greyColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(size.s12),
      ),
      child: TextField(
        controller: widget.controller,
        minLines: widget.multiline ? 5 : 1,
        maxLines: widget.multiline ? null : 1,
        keyboardType:
            widget.multiline ? TextInputType.multiline : widget.keyboardType,
        obscureText: _obscureText,
        style: TextStyle(
          color: clr.blackColor,
          fontSize: size.textSmall,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: clr.textBlackLight,
            fontSize: size.textSmall,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: size.s4, vertical: size.s12),

          suffixIcon: widget.obscure
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: clr.appPrimaryColor,
                  ),
                )
              : const Offstage(),
        ),
      ),
    );
  }
}
