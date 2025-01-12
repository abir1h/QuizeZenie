import 'package:co_learning_mobile_app/src/common/constants/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_theme.dart';
import 'popup_widget.dart';

class CustomDropDown<T> extends StatefulWidget {
  final Future<List<T>> Function() onLoadData;
  final String Function(T item) onGenerateTitle;
  final void Function(T item) onSelected;
  final String hintText;
  final String? prefix;
  final bool? isTop;
  const CustomDropDown({
    super.key,
    required this.onLoadData,
    required this.onSelected,
    this.hintText = "Select",
    this.prefix,
    this.isTop = false,
    required this.onGenerateTitle,
  });

  @override
  State<CustomDropDown<T>> createState() => CustomDropDownState<T>();

}

class CustomDropDownState<T> extends State<CustomDropDown<T>> with AppTheme {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
  }
  void resetSelection() {
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupWidget(
      child: Container(
        key: GlobalKey(),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s8),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.circular(size.s4),
          border: Border.all(color: clr.textFieldStrokeColor, width: 1.w),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (widget.prefix != null)
                    SvgPicture.asset(
                      widget.prefix!,
                      height: size.s24,
                      width: size.s24,
                    ),
                  size.s4.kWidth,
                  Text(
                    _selectedItem != null
                        ? widget.onGenerateTitle(_selectedItem as T)
                        : widget.hintText,
                    style: TextStyle(
                        color: _selectedItem != null
                            ? clr.textColorBlack
                            : clr.dividerColorGrey,
                        fontSize: size.textXXSmall,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: clr.dividerColorGrey,
              size: 22.sp,
            ),
          ],
        ),
      ),
      popupBuilder: (position, _size, link) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: CompositedTransformFollower(
            link: link,
            offset: widget.isTop!
                ? Offset(
                    0,
                    -MediaQuery.of(context).size.height * 0.27,
                  )
                : Offset(
                    0,
                    0,
                  ),
            child: Container(
              width: _size.width,
              margin: EdgeInsets.only(top: _size.height + 4.w),
              constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height - position.dy - 8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 8.w,
                    offset: Offset(0.0, 2.w),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.w),
                child: FutureBuilder<List<T>>(
                    future: widget.onLoadData(),
                    builder: (context, snapshot) {
                      ///Data state
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.isNotEmpty) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: snapshot.data!
                                    .map(
                                      (m) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              if (mounted) {
                                                setState(() {
                                                  _selectedItem = m;
                                                });
                                              }
                                              widget.onSelected.call(m);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.s16,
                                                  vertical: size.s8),
                                              width: double.infinity,
                                              color: Colors.white,
                                              child: Text(
                                                widget.onGenerateTitle(m),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: clr.textColorBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1.2.w,
                                            width: double.infinity,
                                            color: Colors.grey.withOpacity(.08),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              size.s32.kHeight
                            ],
                          ),
                        );
                      }

                      ///Empty state
                      else if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.isEmpty) {
                        return SizedBox(
                          width: double.maxFinite,
                          height: size.s64,
                          child: const Center(
                            child: Text(
                              "No item found!",
                            ),
                          ),
                        );
                      }

                      ///Loading state
                      else {
                        return SizedBox(
                          width: double.maxFinite,
                          height: size.s64,
                          child: Center(
                            child: SizedBox(
                              height: size.s20,
                              width: size.s20,
                              child: CircularProgressIndicator(
                                color: clr.appPrimaryColor,
                                strokeWidth: 1.6.w,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}
