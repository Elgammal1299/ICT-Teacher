import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/helper/auth_clip.dart';

class CustomClipPath extends StatelessWidget {
  const CustomClipPath({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TsClip1(),
      child: Container(
        padding: const EdgeInsets.only(bottom: 38),
        alignment: Alignment.center,
        width: double.infinity,
        height: 150,
        color: AppColors.primary,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
