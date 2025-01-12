import 'package:co_learning_mobile_app/src/common/widgets/app_text_field_with_title.dart';
import 'package:co_learning_mobile_app/src/common/widgets/text_field_widget.dart';
import 'package:co_learning_mobile_app/src/feature/bookmark/models/chapter.dart';
import 'package:flutter/material.dart';
import '../../../common/constants/app_theme.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/app_scroll_view.dart';
import '../../../common/widgets/good_improvment_tab_widget.dart';
import '../services/chapter_create_bottom_sheet_screen_service.dart';

class CreateChapterBottomSheet extends StatefulWidget {
  final String videoId;
  const CreateChapterBottomSheet({
    super.key, required this.videoId,
  });

  @override
  _ExamInstructionBottomSheetState createState() =>
      _ExamInstructionBottomSheetState();
}

class _ExamInstructionBottomSheetState extends State<CreateChapterBottomSheet>
    with AppTheme,CreateChapterBottomSheetScreenServices {

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
            padding: EdgeInsets.only(
                left: size.s24, right: size.s24, bottom: size.s24),
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
                children: [
                  ///Title
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: size.s8, top: size.s8),
                        padding: EdgeInsets.symmetric(
                            vertical: size.s8, horizontal: size.s24),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: clr.blackColor.withOpacity(.4),
                            ),
                          ),
                        ),
                        child: Text(
                          'Create Chapters',
                          style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textXLarge,
                          ),
                        ),
                      ),
                      Icon(Icons.close),
                    ],
                  ),
                  SizedBox(
                    height: size.s24,
                  ),
                  AppTextFieldWithTitle(
                    hintText: "bhvfdhj",
                    controller: TextEditingController(),
                    title: "Chapter Title",
                  ),

                  ///Post button
                  ActionButton<List<ChapterEntity>>(
                    title: "jgsd",
                    radius: size.s8,
                    textColor: clr.whiteColor,
                    tapAction: () => doCrateChapter("Title 1",widget.videoId,10),
                    onSuccess: (success) {

                    }),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
