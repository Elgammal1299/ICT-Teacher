import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';

import 'lesson_notice.dart';
import 'lesson_pdf_card.dart';

class LessonContentSection extends StatelessWidget {
  const LessonContentSection({
    super.key,
    required this.onPdfTap,
    required this.onQuizTap,
  });

  final VoidCallback onPdfTap;
  final VoidCallback onQuizTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),

      child: Column(
        children: [
          LessonPdfCard(
            onTap: onPdfTap,
          ),
      
          SizedBox(height: 20.h),
      
          CustomElevatedButton(
            text: 'الذهاب الى الاختبار',
            onPressed: onQuizTap,
          ),
      
          SizedBox(height: 16.h),
      
          const LessonNotice(),
        ],
      ),
    );
  }
}