import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/strings.dart';
import '../constants/app_theme.dart';

class AppTextFieldWithTitle extends StatefulWidget {
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
  final String title;
  final bool? isRequired;

  const AppTextFieldWithTitle(
      {super.key,
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
      this.isLowerCase,
      required this.title,
      this.isRequired = false});

  @override
  State<AppTextFieldWithTitle> createState() => _AppTextFieldWithTitleState();
}

class _AppTextFieldWithTitleState extends State<AppTextFieldWithTitle>
    with AppTheme {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.s16,
                  color: clr.textColorBlack,
                  fontFamily: StringData.fontFamilyRoboto),
            ),
            size.s4.kWidth,
            if (widget.isRequired!)
              Text(
                "*",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.s16,
                    color: Colors.red,
                    fontFamily: StringData.fontFamilyRoboto),
              ),
          ],
        ),
        size.s8.kHeight,
        TextFormField(
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
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: clr.greyColor,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: clr.textFieldStrokeColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: size.s12),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: clr.appPrimaryColor, width: 1),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.s8,
                    ),
                    child: SvgPicture.asset(
                      widget.prefixIcon,
                      height: size.s20,
                      width: size.s20,
                      color: clr.appPrimaryColor,
                    ))
                : const Offstage(),
          ),
          style: TextStyle(
            color: clr.textFieldTextColor,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w400,
            fontFamily: StringData.fontFamilyPoppins,
          ),
        ),
      ],
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
