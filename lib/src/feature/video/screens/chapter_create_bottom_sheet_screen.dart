import 'package:co_learning_mobile_app/src/common/widgets/app_text_field_with_title.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_button.dart';
import 'package:co_learning_mobile_app/src/common/widgets/custom_toasty.dart';
import 'package:co_learning_mobile_app/src/common/widgets/text_field_widget.dart';
import 'package:co_learning_mobile_app/src/common/widgets/time_input_widget.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:flutter/material.dart';
import '../../../common/constants/app_theme.dart';
import '../../../common/constants/common_imports.dart';
import '../../../common/utility/app_label.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/app_scroll_view.dart';
import '../../../common/widgets/good_improvment_tab_widget.dart';
import '../../../common/widgets/time_input_widget.dart';
import '../services/chapter_create_bottom_sheet_screen_service.dart';

class CreateChapterBottomSheet extends StatefulWidget {
  final String videoId;
  final Duration totalDuration;
  final Duration userPosition;
  final ValueChanged<List<ChapterEntity>> chapterList;
  const CreateChapterBottomSheet({
    super.key,
    required this.videoId,
    required this.totalDuration,
    required this.userPosition,
    required this.chapterList,
  });

  @override
  _ExamInstructionBottomSheetState createState() =>
      _ExamInstructionBottomSheetState();
}

class _ExamInstructionBottomSheetState extends State<CreateChapterBottomSheet>
    with AppTheme, CreateChapterBottomSheetScreenServices {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.s32),
                topRight: Radius.circular(size.s32),
              ),
            ),
            child: AppScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Title
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.s16, vertical: size.s10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label(e: "Create chapters", b: "បង្កើតជំពូក"),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: clr.textColorBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: size.textSmall,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close))
                      ],
                    ),
                  ),
                  Divider(
                    color: clr.dividerColorGray,
                  ),
                  SizedBox(
                    height: size.s12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.s16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label(e: "Chapter Title", b: "ចំណងជើងជំពូក"),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.textXXSmall,
                              color: clr.greyVideoTitle),
                        ),
                        size.s8.kHeight,
                        TextField(
                          controller: titleController,
                          cursorRadius: const Radius.circular(100),onChanged: (v){
                            setState(() {

                            });
                        },
                          decoration: InputDecoration(
                            hintText: label(
                                e: "Enter Chapter Title",
                                b: "បញ្ចូលចំណងជើងជំពូក"),
                            hintStyle: TextStyle(
                              color: clr.lightGray,
                              fontSize: size.textXSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyPoppins,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: clr.greyBorder, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: clr.greyBorder, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: clr.greyBorder, width: 1)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size.s10, horizontal: size.s20),
                          ),
                        ),
                        size.s12.kHeight,
                        TimeInputScreen(
                          onTimeChanged: (value) {
                            setState(() {
                              videoDuration = value;
                            });
                          },
                          initialTime: widget.userPosition,
                          totalDuration: widget.totalDuration,
                        ),
                        size.s16.kHeight,

                        ///Post button
                        ActionButton<List<ChapterEntity>>(
                           title: "Save",
                           radius: size.s8,
                           textColor: clr.whiteColor,
                           enabled:titleController.text.isNotEmpty ?true:false ,
                           buttonColor: titleController.text.isNotEmpty?clr.appPrimaryColor:clr.disableButtonGray ,
                           tapAction: () => doCrateChapter(titleController.text,widget.videoId,videoDuration!),
                           onSuccess: (success) {
                             if(mounted){
                               widget.chapterList.call(success);
                               Navigator.pop(context);
                             }
                           }),

                        SizedBox(
                          height: 65,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
Toasty.of(context).showSuccess(message);  }

  @override
  void showWarning(String message) {
    Toasty.of(context).showWarning(message);   }
}
