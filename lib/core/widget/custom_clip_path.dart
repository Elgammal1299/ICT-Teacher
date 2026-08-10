import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/helper/auth_clip.dart';

class CustomClipPath extends StatelessWidget {
  const CustomClipPath({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TsClip1(),
      child: Container(
        padding: EdgeInsets.only(bottom: 38.h),
        alignment: Alignment.center,
        width: double.infinity,
        height: 150.h,
        color:  Theme.of(context).primaryColor,

        child: Text(
          title,
          style:  Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
