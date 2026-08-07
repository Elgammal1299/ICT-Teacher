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
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(.3),
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "مقدمة الدرس",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri',
            ),
          ),

          SizedBox(height: 5.h),

          Text(
            "نبذة سريعة عن الدرس",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontFamily: 'Amiri',
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            introduction,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}