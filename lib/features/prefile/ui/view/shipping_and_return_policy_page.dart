import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class ShippingAndReturnPolicyPage extends StatelessWidget {
  const ShippingAndReturnPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, 
       foregroundColor: Colors.white,
        title: Text('سياسة الخصوصية', style: TextStyle(fontFamily: 'IBMPlexSansArabic')), centerTitle: true),
      body: Column(children: []),
    );
  }
}
