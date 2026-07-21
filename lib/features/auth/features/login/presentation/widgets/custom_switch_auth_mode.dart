import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class CustomSwitchAuthMode extends StatelessWidget {
  const CustomSwitchAuthMode({
    super.key,
    required this.onToggle,
    required this.title,
  });
  final void Function() onToggle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'هل لديك حساب بالفعل؟',
          style: TextStyle(
            fontSize: 20.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontFamily: 'Amiri'
          ),
        ),
        TextButton(
          onPressed: () {
            onToggle();
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri'
            ),
          ),
        ),
      ],
    );
  }
}
