import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants/app_theme.dart';

class VideoSectionTabWidget extends StatefulWidget {
  final Widget Function(BuildContext context, int index) builder;
  final void Function(MapEntry<int, String>) onTabChange;
  const VideoSectionTabWidget(
      {super.key, required this.builder, required this.onTabChange});

  @override
  _VideoSectionTabWidgetState createState() => _VideoSectionTabWidgetState();
}

class _VideoSectionTabWidgetState extends State<VideoSectionTabWidget>
    with AppTheme {
  final Map<int, String> _options = {0: "All", 1: "Draft", 2: 'Published'};
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        size.s20.kHeight,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.s16),
          child: Container(width: 1.sw,

            decoration: BoxDecoration(
                border: Border.all(color: clr.appPrimaryColor),
                borderRadius: BorderRadius.circular(size.s8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _options.entries
                  .map((e) => Expanded(
                    child: GestureDetector(
                          onTap: () => onTabChange(e.key),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.s10, vertical: size.s8),
                            decoration: BoxDecoration(
                                borderRadius: _selectedIndex == 1
                                    ? null:_selectedIndex == 0
                                    ?BorderRadius.only(topLeft: Radius.circular(size.s8),bottomLeft:Radius.circular(size.s8) ):_selectedIndex == 2
                                    ?BorderRadius.only(topRight: Radius.circular(size.s8),bottomRight:Radius.circular(size.s8) )
                                    : BorderRadius.circular(size.s8),
                                color: e.key == _selectedIndex
                                    ? clr.appPrimaryColor
                                    : null),
                            child: Center(
                              child: Text(
                                "${e.value}",
                                style: TextStyle(
                                  color: e.key == _selectedIndex
                                      ? clr.whiteColor
                                      : clr.inactiveGray,
                                  fontSize: size.textXSmall,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                  ))
                  .toList(),
            ),
          ),
        ),
        widget.builder(context, _selectedIndex)
      ],
    );
  }

  onTabChange(int key) {
    if (mounted && _selectedIndex != key) {
      setState(() {
        _selectedIndex = key;
      });
      widget.onTabChange(
          _options.entries.firstWhere((m) => m.key == _selectedIndex));
    }
  }
}
