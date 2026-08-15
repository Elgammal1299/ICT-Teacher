import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_login_form_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              icon: Icons.info_outline,
              backgroundColor:       Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).cardColor,
              spacing: 10,
              overlayOpacity: 0.5,
              children: [
                SpeedDialChild(
                  child: SvgPicture.asset(
                    AppImage.whatsIcon,
                    color: Colors.green,
                    width: 24.w,
                    height: 24.h,
                  ),
                  label: 'تواصل واتساب',
                  onTap: () async {
                    await launchUrlString(
                      'https://wa.me/201038340374?text=${Uri.encodeComponent('مرحبًا، أحتاج إلى المساعدة في منصة ICT Gate.')}',
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.telegram, color: Colors.blue),

                  label: 'تواصل تليجرام',

                  onTap: () async {
                    await launchUrlString(
                      'https://t.me/ICTGatee?text=مرحبًا، أحتاج إلى المساعدة في منصة ICT Gate.',
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // body: Column(
        //   children: [
        //     const CustomClipPath(title: "تسجيل الدخول"),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        //       child: CustomLoginFormField(),
        //     ),
        //   ],
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              /// الخلفية
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250.h,
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(
                          "تسجيل الدخول",
                          style:Theme.of(context).textTheme.titleLarge
                        ),
                        SizedBox(height: 12,),
                        Text(
                          "مرحباً بك مجدداً، يرجى تسجيل الدخول للمتابعة",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),

                  Expanded(child: Container(color:  Theme.of(context).cardColor)),
                ],
              ),

              /// الدائرة العلوية
              Positioned(
                top: 20.h,
                right: 20.w,
                child: Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              

              /// الكارت
              Positioned(
                top: 180.h,
                left: 20.w,
                right: 20.w,
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const CustomLoginFormField(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
