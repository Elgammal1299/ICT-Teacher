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
        Expanded(
          child: Text(
            
            'هل لديك حساب بالفعل؟',
            style:                 Theme.of(context).textTheme.titleLarge,
          
          ),
        ),
        TextButton(
          
          
          onPressed: () {
            onToggle();
          },
          child: Text(
            title,
            style:  Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.primary
            ),
          ),
        ),
      ],
    );
  }
}
