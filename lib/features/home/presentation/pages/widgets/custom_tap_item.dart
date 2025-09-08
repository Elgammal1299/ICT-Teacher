import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/tap_view_model.dart';

class CustomTapItem extends StatelessWidget {
  final TapViewModel item;
  final bool isSelected;
  final Color selectedColor;
  final String counter;
  const CustomTapItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : AppColors.colorUnSelected,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        textAlign: TextAlign.center,
        item.title,
        style: isSelected
            ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
      ),
    );
  }
}
