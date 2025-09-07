import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';

class CustomLogoutBotton extends StatelessWidget {
  const CustomLogoutBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: CustomElevatedButton(
        textStyle: Theme.of(context).textTheme.titleMedium,
        textDirection: TextDirection.rtl,
        backgroundColor: AppColors.red2,
        text: 'تسجيل الخروج',

        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 130.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: () async {
                        await UserSession.logout();
                        Navigator.pushNamedAndRemoveUntil(
                          // ignore: use_build_context_synchronously
                          context,
                          AppRoutes.loginRoute,
                          (route) => false,
                        );
                      },
                      child: Text(
                        'تسجيل الخروج',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(color: AppColors.red),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                      text: 'الغاء',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              );
            },
          );
        },
        icon: SvgPicture.asset(AppImage.logoutImage),
      ),
    );
  }
}
