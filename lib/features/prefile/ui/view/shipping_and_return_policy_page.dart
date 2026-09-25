import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class ShippingAndReturnPolicyPage extends StatelessWidget {
  const ShippingAndReturnPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'مقدمة',
              'نحن في منصة ICT Gate نلتزم بحماية خصوصية بيانات مستخدمينا من الطلاب وأولياء الأمور والمعلمين. توضح هذه السياسة كيفية جمع البيانات واستخدامها وحمايتها.',
            ),
            _buildSection(
              context,
              'البيانات التي نجمعها',
              '• بيانات الحساب: الاسم، اسم المستخدم، رقم الهاتف، والمرحلة الدراسية.\n• بيانات الأداء التعليمي: نتائج الاختبارات والواجبات والمقررات التي يتابعها الطالب.',
            ),
            _buildSection(
              context,
              'كيفية استخدام البيانات',
              '• تقديم وتخصيص المحتوى التعليمي والدروس والاختبارات.\n• متابعة تقدم الطالب وتحسين التجربة التعليمية داخل التطبيق.\n• تقديم الدعم الفني والإجابة على الاستفسارات.',
            ),
            _buildSection(
              context,
              'حماية البيانات',
              'نطبق أعلى معايير الأمان التقنية والتشفير لحماية البيانات الشخصية من الوصول غير المصرح به، ولا نقوم ببيع أو مشاركة بيانات المستخدمين مع أي أطراف ثالثة لأغراض إعلانية.',
            ),
            _buildSection(
              context,
              'حقوق المستخدم وحذف الحساب',
              'يحق للمستخدم طلب تعديل بياناته أو حذف حسابه وجميع بياناته المرتبطة به في أي وقت من خلال التواصل مع الدعم الفني.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
