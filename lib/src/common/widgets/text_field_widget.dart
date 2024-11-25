import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/strings.dart';
import '../constants/app_theme.dart';

class AppTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String prefixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;
  final VoidCallback? onTaped;
  final FormFieldValidator<String>? validator;
  final bool? isLowerCase;
  final Color? iconColor;
  final Color? fillColor;
  final bool? outlined;
  final double? prefixIconHorizontalPadding;
  final double? prefixIconVerticalPadding;

  const AppTextField({
    super.key,
    this.readOnly = false,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon = "",
    this.keyboardType = TextInputType.text,
    this.autoMaxLine = false,
    this.validator,
    this.onTaped,
    this.isLowerCase, this.iconColor, this.fillColor, this.outlined=false, this.prefixIconHorizontalPadding, this.prefixIconVerticalPadding,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with AppTheme {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = widget.focusNode ?? FocusNode();

    return TextFormField(
      onTap: widget.onTaped,
      readOnly: widget.readOnly,
      controller: widget.controller,
      cursorRadius: const Radius.circular(100),
      cursorColor: clr.appPrimaryColor,
      cursorWidth: 1.0,
      autocorrect: false,
      maxLines: widget.autoMaxLine ? null : 1,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,
      inputFormatters: widget.isLowerCase == true
          ? [LowerCaseTextFormatter()]
          : [], // Use conditional logic here
      decoration: InputDecoration(
        border: widget.outlined==true?InputBorder.none:UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: clr.greyColor,
          ),
        ),
        filled: true,
        fillColor:widget.fillColor?? Colors.white,
        enabledBorder:widget.outlined==true?InputBorder.none: UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: clr.greyColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: size.s12),
        focusedBorder: widget.outlined==true?InputBorder.none:UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: clr.textFieldStrokeColor,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: clr.placeHolderTextColorGray,
          fontSize: size.textXSmall,
          fontWeight: FontWeight.w400,
          fontFamily: StringData.fontFamilyPoppins,
        ),
        suffixIcon: widget.obscureText == true
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: clr.placeHolderTextColorGray,
                ),
                onPressed: _toggleObscureText,
              )
            : null,
        prefixIcon: widget.prefixIcon.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal:widget.prefixIconHorizontalPadding??size.s20,vertical: widget.prefixIconVerticalPadding??0),
                child: SvgPicture.asset(widget.prefixIcon,color: widget.iconColor,))
            : const Offstage(),
      ),
      style: TextStyle(
        color: clr.textFieldTextColor,
        fontSize: size.textXSmall,
        fontWeight: FontWeight.w400,
        fontFamily: StringData.fontFamilyPoppins,
      ),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
