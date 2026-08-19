import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشروط والأحكام'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'الاستخدام المقبول',
              'منصة ICT Gate مخصصة للاستخدام التعليمي الشخصي للطلاب والمعلمين. يُحظر مشاركة بيانات الحساب مع مستخدمين آخرين أو إعادة توزيع المحتوى والملفات التعليمية بدون إذن مسبق.',
            ),
            _buildSection(
              context,
              'الملكية الفكرية',
              'جميع الدروس والفيديوهات والملفات والاختبارات المتاحة على المنصة هي ملكية فكرية حصرية لمنصة ICT Gate ومحمية بموجب قوانين حقوق النشر.',
            ),
            _buildSection(
              context,
              'مسؤوليات الحساب',
              'يتحمل المستخدم مسؤولية الحفاظ على سرية كلمة المرور الخاصة بحسابه، وإبلاغ الدعم الفني فوراً في حال الاشتباه بأي دخول غير مصرح به.',
            ),
            _buildSection(
              context,
              'التعديلات على الشروط',
              'تحتفظ إدارة المنصة بالحق في تحديث هذه الشروط والأحكام عند الحاجة، ويتم إخطار المستخدمين بأي تغييرات جوهرية.',
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
