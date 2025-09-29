import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';

class CustomAccountListTile extends StatelessWidget {
  final String title;
  final Widget? leading;

  const CustomAccountListTile({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.background),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
        minVerticalPadding: 0,
        minTileHeight: 0,
        minLeadingWidth: 0,
        trailing: SvgPicture.asset(
          AppImage.backIconNotBorser,
          width: 20.w,
          height: 20.h,
        ),
        title: Text(title, style:Theme.of(context).textTheme.titleMedium),
        leading: leading,
      ),
    );
  }
}
