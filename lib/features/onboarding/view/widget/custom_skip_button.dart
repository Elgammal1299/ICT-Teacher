import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomSkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 16.r, top: 16.h,left: 16.r),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            'Skip',
            style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
