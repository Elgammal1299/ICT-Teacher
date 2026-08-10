import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonPdfCard extends StatelessWidget {
  const LessonPdfCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
      borderRadius: BorderRadius.circular(15.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.r),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملخص الدرس',
              style:Theme.of(context).textTheme.titleLarge
            ),
            SizedBox(height: 10.h),
            Text(
              'يمكنك مراجهة أهم النقاط قبل الاختبار',
              style:Theme.of(context).textTheme.titleSmall
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(.3),
                ),
                borderRadius: BorderRadius.circular(15.r),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(.1),
                //     blurRadius: 8.r,
                //     offset: Offset(0, 2.h),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الملخص الكامل للدرس",
                          style: Theme.of(context).textTheme.titleLarge
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "اضغط للمشاهدة",
                          style: Theme.of(context).textTheme.titleSmall
                        ),
                      ],
                    ),
                  ),
                   Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}