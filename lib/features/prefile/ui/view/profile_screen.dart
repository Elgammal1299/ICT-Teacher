import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/features/prefile/ui/view/widget/custom_app_information_section.dart';
import 'package:icd_teacher/features/prefile/ui/view/widget/custom_logout_botton.dart';
import 'package:icd_teacher/features/prefile/ui/view/widget/custom_row_social_media.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _year = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(40),
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1D4ED8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Align(
                alignment: AlignmentGeometry.topCenter,
                child: Text(
                  'الاعدادت',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  CustomAppInformationSection(),
                  SizedBox(height: 24.h),
                  _buildSocialMediaSection(),
                  SizedBox(height: 60.h),
                  CustomLogoutBotton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التواصل الاجتماعى',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        CustomRowSocialMedia(),
      ],
    );
  }
}
