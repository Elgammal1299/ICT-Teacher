import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/features/prefile/ui/view/widget/custom_account_list_tile.dart';

class CustomAppInformationSection extends StatelessWidget {
  const CustomAppInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.background),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.aboutUsScreenRoute);
            },

            child: CustomAccountListTile(title: 'من نحن'),
          ),
          Divider(
            color: AppColors.colorUnSelected,
            height: 1.h,
            endIndent: 14.w,
            indent: 14.w,
          ),
          InkWell(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   AppRoutes.termsAndConditionsScreenRoute,
              // );
            },

            child: CustomAccountListTile(title: 'الشروط والاحكام'),
          ),
          Divider(
            color: AppColors.colorUnSelected,
            height: 1.h,
            endIndent: 14.w,
            indent: 14.w,
          ),
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.privacyPolicyScreenRoute);
            },

            child: CustomAccountListTile(title: 'سياسة الخصوصية'),
          ),
          Divider(
            color: AppColors.colorUnSelected,
            height: 1.h,
            endIndent: 14.w,
            indent: 14.w,
          ),
          InkWell(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   AppRoutes.shippingAndReturnPolicyScreenRoute,
              // );
            },

            child: CustomAccountListTile(title: 'سياسة الشحن والاسترجاع'),
          ),
        ],
      ),
    );
  }
}
