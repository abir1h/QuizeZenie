import 'package:co_learning_mobile_app/src/common/constants/common_imports.dart';
import 'package:co_learning_mobile_app/src/common/models/page_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../feature/bookmark/models/folder_entity.dart';
import '../../feature/video/gateways/video_recorded_screen_gateway.dart';
import '../constants/app_theme.dart';
import '../models/action_result.dart';
import '../utility/app_label.dart';

class FilterBottomsheet extends StatefulWidget {
  final BuildContext context;
  final ServiceState serviceState;
  const FilterBottomsheet(
      {super.key, required this.context, required this.serviceState});

  @override
  FilterBottomsheetState createState() => FilterBottomsheetState();
}

class FilterBottomsheetState extends State<FilterBottomsheet>
    with AppTheme, Language {
  @override
  void initState() {
    super.initState();
  }

  Future<List<FolderEntity>> getFolderListEntityList() async {
    return VideoRecordedScreenGateway.getFolderList().then((value) {
      if (value.status == Status.success) {
        return value.data!;
      } else {
        return [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            color: clr.whiteColor,
          ),
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.s16, vertical: size.s12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label(e: "Filter Search", b: "តម្រងស្វែងរក"),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size.textSmall,
                          color: clr.textColorBlack,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () =>
                            Navigator.pop(context, widget.serviceState),
                        child: Icon(Icons.clear)),
                  ],
                ),
              ),
              Divider(height: size.s2, color: clr.greyBorder),
              size.s12.kHeight,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.s16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            label(
                                e: "Filter by activity:",
                                b: "ត្រងតាមសកម្មភាព៖"),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.textSmall,
                              color: clr.textColorBlack,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.serviceState.mostRecent = false;
                              widget.serviceState.mostViewed = false;
                              widget.serviceState.mostFeedbacks = false;
                            });
                          },
                          child: Text(
                            label(e: "Reset all", b: "កំណត់ឡើងវិញទាំងអស់។"),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.textXXSmall,
                              color: clr.disableButtonGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    size.s12.kHeight,
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(label(e: "Most Recent", b: "ថ្មីៗបំផុត។")),
                      value: widget.serviceState.mostRecent,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.serviceState.mostRecent = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // Position of the checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(label(e: "Most Viewed", b: "មើលច្រើនបំផុត។")),
                      value: widget.serviceState.mostViewed,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.serviceState.mostViewed = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // Position of the checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(label(e: "Most Feedbacks", b: "មតិភាគច្រើន")),
                      value: widget.serviceState.mostFeedbacks,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.serviceState.mostFeedbacks = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // Position of the checkbox
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
