import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class AboutPlatformPage extends StatelessWidget {
  const AboutPlatformPage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      'شرح مبسط بأسلوب حديث.',
      'فيديوهات تعليمية عالية الجودة.',
      'اختبارات إلكترونية مع تصحيح فوري.',
      'مراجعات شاملة لكل وحدة دراسية.',
      'متابعة مستمرة لتقدم الطالب.',
      'ملفات وملخصات تساعد على المذاكرة.',
      'محتوى متوافق مع المناهج الدراسية.',
      'تطوير مستمر للمحتوى والخدمات التعليمية.',
    ];

    return Scaffold(
      appBar: AppBar(
      
        title: const Text('عن منصة ICT Gate',),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Logo
           
            /// About
            _SectionCard(
              icon: Icons.info_outline_rounded,
              title: 'نبذة عن المنصة',
              child: Text(
                'ICT Gate هي منصة تعليمية مصرية متخصصة في تدريس تكنولوجيا المعلومات والاتصالات، والكمبيوتر، والبرمجة، والذكاء الاصطناعي لطلاب المرحلة الابتدائية والإعدادية والثانوية، وفقًا للمناهج الدراسية المعتمدة.\n'
                'تهدف المنصة إلى تقديم تجربة تعليمية متكاملة تجمع بين الشرح المبسط، والتطبيق العملي، والاختبارات التفاعلية، بما يساعد الطلاب على الفهم الحقيقي للمحتوى الدراسي وتنمية مهاراتهم التقنية.',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ),

            SizedBox(height: 8.h),

            /// Vision
            _SectionCard(
              icon: Icons.visibility_rounded,
              title: 'رؤيتنا',
              child: Text(
                'أن نكون المنصة التعليمية الرائدة في تعليم التكنولوجيا والبرمجة والذكاء الاصطناعي لطلاب المدارس، من خلال محتوى احترافي يواكب التطور الرقمي ويسهم في إعداد جيل قادر على الإبداع والابتكار.',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ),

            SizedBox(height: 8.h),

            /// Mission
            _SectionCard(
              icon: Icons.rocket_launch_rounded,
              title: 'رسالتنا',
              child: Text(
                'تقديم تعليم رقمي عالي الجودة يعتمد على الفهم والتطبيق، ويجعل التكنولوجيا أكثر سهولة ومتعة، مع توفير بيئة تعليمية آمنة وتفاعلية تدعم الطلاب في تحقيق أفضل نتائجهم الأكاديمية.',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ),

            SizedBox(height: 18.h),

            /// Features
            _SectionCard(
              icon: Icons.workspace_premium_rounded,
              title: 'ما الذي يميز ICT Gate؟',
              child: Column(
                children: features
                    .map(
                      (feature) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
                              size: 22.r,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                feature,
                                style: Theme.of(context).textTheme.titleMedium
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 25.h),

            /// Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: AppColors.primary,
                    size: 35.r,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'ICT Gate...',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontFamily: 'Cairo',
                        ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'بوابتك إلى تعلم تكنولوجيا والمعلومات وصناعة المستقبل.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),

            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primary,
                ),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            child,
          ],
        ),
      ),
    );
  }
}