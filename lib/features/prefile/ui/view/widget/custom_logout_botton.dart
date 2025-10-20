// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:icd_teacher/core/constant/app_color.dart';
// import 'package:icd_teacher/core/constant/app_image.dart';
// import 'package:icd_teacher/core/helper/user_session.dart';
// import 'package:icd_teacher/core/router/app_routes.dart';
// import 'package:icd_teacher/core/widget/custom_elevated_button.dart';

// class CustomLogoutBotton extends StatelessWidget {
//   const CustomLogoutBotton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 24.h),
//       child: CustomElevatedButton(
//         textStyle: Theme.of(context).textTheme.titleMedium,
//         textDirection: TextDirection.rtl,
//         backgroundColor: AppColors.red2,
//         text: 'تسجيل الخروج',

//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context) {
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 130.w,
//                       height: 5.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100.r),
//                         color: AppColors.grey,
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     GestureDetector(
//                       onTap: () async {
//                         await UserSession.logout();
//                         Navigator.pushNamedAndRemoveUntil(
//                           // ignore: use_build_context_synchronously
//                           context,
//                           AppRoutes.loginRoute,
//                           (route) => false,
//                         );
//                       },
//                       child: Text(
//                         'تسجيل الخروج',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.titleLarge!.copyWith(color: AppColors.red),
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     CustomElevatedButton(
//                       text: 'الغاء',
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                     SizedBox(height: 24.h),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//         icon: SvgPicture.asset(AppImage.logoutImage),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';

class CustomLogoutBotton extends StatelessWidget {
  const CustomLogoutBotton({super.key});

  Future<void> _performLogoutWithVerification(BuildContext context) async {
    try {
      log('🔵 Starting logout process...');

      // Step 1: Check tokens before logout
      final accessTokenBefore = await SharedPrefHelper.getSecuredString(
        SharedPreferencesKeys.accessToken,
      );
      final refreshTokenBefore = await SharedPrefHelper.getSecuredString(
        SharedPreferencesKeys.refreshToken,
      );

      log(
        '🔑 Access Token before logout: ${accessTokenBefore.isNotEmpty ? "EXISTS (${accessTokenBefore.substring(0, 20)}...)" : "EMPTY"}',
      );
      log(
        '🔑 Refresh Token before logout: ${refreshTokenBefore.isNotEmpty ? "EXISTS" : "EMPTY"}',
      );

      // Step 2: Perform logout
      log('🔄 Clearing secure storage...');
      await UserSession.logout();

      // Step 3: Verify tokens are cleared
      final accessTokenAfter = await SharedPrefHelper.getSecuredString(
        SharedPreferencesKeys.accessToken,
      );
      final refreshTokenAfter = await SharedPrefHelper.getSecuredString(
        SharedPreferencesKeys.refreshToken,
      );

      log(
        '🔑 Access Token after logout: ${accessTokenAfter.isEmpty ? "CLEARED ✅" : "STILL EXISTS ❌"}',
      );
      log(
        '🔑 Refresh Token after logout: ${refreshTokenAfter.isEmpty ? "CLEARED ✅" : "STILL EXISTS ❌"}',
      );

      // Step 4: Verify isLoggedIn returns false
      final isStillLoggedIn = await UserSession.isLoggedIn();
      log('🎯 isLoggedIn check: ${!isStillLoggedIn ? "FALSE ✅" : "TRUE ❌"}');

      // Step 5: Show result to user
      if (accessTokenAfter.isEmpty &&
          refreshTokenAfter.isEmpty &&
          !isStillLoggedIn) {
        log('✅ Logout successful! All tokens cleared.');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل الخروج بنجاح ✅'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // Step 6: Navigate to login
          await Future.delayed(const Duration(milliseconds: 500));

          if (context.mounted) {
            log('🚀 Navigating to login page...');
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginRoute,
              (route) => false,
            );
            log('✅ Navigation complete');
          }
        }
      } else {
        log('❌ Logout verification FAILED!');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('خطأ في تسجيل الخروج. حاول مرة أخرى'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      log('❌ Error during logout: $e');
      log('Stack trace: $stackTrace');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 130.w,
                height: 5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: AppColors.grey,
                ),
              ),
              SizedBox(height: 24.h),

              // Warning icon
              Icon(Icons.logout_rounded, size: 48, color: AppColors.red),
              SizedBox(height: 16.h),

              // Confirmation text
              Text(
                'هل أنت متأكد من تسجيل الخروج؟',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              Text(
                'سيتم مسح جميع البيانات المحفوظة',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              // Logout button
              CustomElevatedButton(
                backgroundColor: AppColors.red,
                text: 'تسجيل الخروج',
                onPressed: () async {
                  // Close bottom sheet
                  Navigator.pop(bottomSheetContext);

                  // Perform logout with verification
                  await _performLogoutWithVerification(context);
                },
              ),
              SizedBox(height: 12.h),

              // Cancel button
              CustomElevatedButton(
                backgroundColor: Colors.grey.shade200,
                textStyle: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.black),
                text: 'إلغاء',
                onPressed: () {
                  Navigator.pop(bottomSheetContext);
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: CustomElevatedButton(
        textStyle: Theme.of(context).textTheme.titleMedium,
        textDirection: TextDirection.rtl,
        backgroundColor: AppColors.red2,
        text: 'تسجيل الخروج',
        onPressed: () => _showLogoutConfirmation(context),
        icon: SvgPicture.asset(AppImage.logoutImage),
      ),
    );
  }
}
