import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, 
       foregroundColor: Colors.white,
        title: Text('الشروط والاحكام', style: TextStyle(fontFamily: 'IBMPlexSansArabic')), centerTitle: true),
      body: Column(children: []),
    );
  }
}
