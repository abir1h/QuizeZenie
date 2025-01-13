import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class GoodImprovementSectionTab extends StatefulWidget {
  final Widget Function(BuildContext context, int index) builder;
  const GoodImprovementSectionTab(
      {super.key, required this.builder,});

  @override
  _GoodImprovementSectionTabState createState() => _GoodImprovementSectionTabState();
}

class _GoodImprovementSectionTabState extends State<GoodImprovementSectionTab> with AppTheme {
  final Map<int, String> _options = {
    0: "Good",
    1: "Improvement",
  };
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: clr.whiteColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _options.entries
                .map((e) => Expanded(
              child: GestureDetector(
                onTap: () => onTabChange(e.key),
                child: Container(

                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(size.s4),
                    color:e.key == _selectedIndex
                        ? (e.key == 0
                        ? clr.improveText
                        : clr.appPrimaryColor) // Selected background
                        : clr.greyBorder,   
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.s8, vertical: size.s10),
                  child: Center(
                    child: Text(
                      "${e.value}",
                      style: TextStyle(
                        color: e.key == _selectedIndex
                            ? clr.whiteColor
                            : clr.blackColor,
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
            widget.builder(context, _selectedIndex)
        ],
      ),
    );
  }

  onTabChange(int key) {
    if (mounted && _selectedIndex != key) {
      setState(() {
        _selectedIndex = key;
      });
    }
  }
}