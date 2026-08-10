import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonIntroductionCard extends StatelessWidget {
  const LessonIntroductionCard({
    super.key,
    required this.introduction,
  });

  final String introduction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).hintColor,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "مقدمة الدرس",
            style: Theme.of(context).textTheme.titleLarge
          ),


          Text(
            "نبذة سريعة عن الدرس",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            introduction,
            style: Theme.of(context).textTheme.titleMedium
          ),
        ],
      ),
    );
  }
}