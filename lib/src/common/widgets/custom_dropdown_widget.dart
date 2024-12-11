import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';
import 'popup_widget.dart';

class CustomDropDown<T> extends StatefulWidget {
  final Future<List<T>> Function() onLoadData;
  final String Function(T item) onGenerateTitle;
  final void Function(T item) onSelected;
  final String hintText;
  const CustomDropDown({
    super.key,
    required this.onLoadData,
    required this.onSelected,
    this.hintText = "Select",
    required this.onGenerateTitle,
  });

  @override
  State<CustomDropDown<T>> createState() =>
      _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>>
    with AppTheme {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
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
              child: Text(
                _selectedItem != null
                    ? widget.onGenerateTitle(_selectedItem as T)
                    : widget.hintText,
                style: TextStyle(
                  color: _selectedItem != null
                      ? clr.textColorBlack
                      : clr.dividerColorGrey,
                  fontSize: size.textXXSmall,
                  fontWeight: FontWeight.w500
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.filter_list_outlined,
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
