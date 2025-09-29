
import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_image.dart';

class CustomNoLesson extends StatelessWidget {
  const CustomNoLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            AppImage.noLesson,
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
        ),
      ],
    );
  }
}
