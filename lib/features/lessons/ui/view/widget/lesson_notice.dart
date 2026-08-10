import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class LessonNotice extends StatelessWidget {
  const LessonNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.accent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
            Icons.warning_amber_rounded,
            color: AppColors.accentDark,
            size: 30.sp,
          ),
          SizedBox(width: 8.w),
              Text(
                'تـنـبـيـه',
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.textPrimary
                )
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'يمكنك الاختبار عدة مرات ولكن يتم أخذ الدرجة من الاختبار الأول، تأكد من مراجعة الدرس جيداً قبل البدء بالاختبار.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.textTertiary
            )
          ),
        ],
      ),
    );
  }
}