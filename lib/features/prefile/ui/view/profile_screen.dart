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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildHeader('كزائر'),
              // CustomBottonNotLogin(),
              SizedBox(height: 30.h),
              CustomAppInformationSection(),
              SizedBox(height: 24.h),
              _buildSocialMediaSection(),
              SizedBox(height: 20.h),
              CustomLogoutBotton(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: SafeArea(child: Text('data')),
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

  Widget _buildFooter() {
    return Column(
      children: [
        SizedBox(height: 24),
        Text('الاصدار : 1.01', style: Theme.of(context).textTheme.titleMedium),
        Text(
          'جميع الحقوق محفوظة لتطبيق  ICD Teacher ©$_year',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
