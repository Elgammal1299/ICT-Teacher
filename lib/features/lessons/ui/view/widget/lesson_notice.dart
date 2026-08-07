import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonNotice extends StatelessWidget {
  const LessonNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.yellow.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.yellow.shade700,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
            Icons.warning_amber_rounded,
            color: Colors.yellow.shade700,
            size: 30.sp,
          ),
          SizedBox(width: 8.w),
              Text(
                'تـنـبـيـه',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'يمكنك الاختبار عدة مرات ولكن يتم أخذ الدرجة من الاختبار الأول، تأكد من مراجعة الدرس جيداً قبل البدء بالاختبار.',
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Amiri',
            ),
          ),
        ],
      ),
    );
  }
}