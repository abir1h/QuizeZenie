import 'package:co_learning_mobile_app/src/common/constants/app_theme.dart';
import 'package:co_learning_mobile_app/src/common/utility/app_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/common_imports.dart';

class FeedBackWidget extends StatelessWidget with AppTheme{
  final String title,image;
  final Color bgColor,textColor;
  const FeedBackWidget({super.key, required this.title, required this.image, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
        EdgeInsets.symmetric(vertical: size.s4 + 2),
        decoration: BoxDecoration(
            border: Border.all(color: textColor),color: bgColor,
            borderRadius:
            BorderRadius.circular(size.s4 + 2)),

        child: Column(
          children: [
            SvgPicture.asset(image,color: textColor,),size.s4.kHeight,
            Text(title,style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: size.textXXSmall,color:textColor
            ),)

          ],
        ),
      ),
    );
  }
}
