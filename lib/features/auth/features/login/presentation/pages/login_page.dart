import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/widget/custom_clip_path.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_login_form_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: SpeedDial(
             
              animatedIcon: AnimatedIcons.menu_close,
              icon: Icons.info_outline,
              backgroundColor:AppColors.primary,
              foregroundColor: Colors.white,
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
                  
                  child: const Icon(Icons.telegram,color: Colors.blue,),
               
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
        body: Column(
          children: [
            const CustomClipPath(title: "تسجيل الدخول"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: CustomLoginFormField(),
            ),
          ],
        ),
      ),
    );
  }
}
