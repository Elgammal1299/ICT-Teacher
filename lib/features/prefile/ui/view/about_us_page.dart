import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('من نحن')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 100.r,
                child: ClipOval(
                  child: Image.asset(
                    AppImage.ahmedSaif,
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'يقف خلف ICT Gate فريق تعليمي يجمع بين الخبرة الأكاديمية والرؤية الحديثة في تعليم التكنولوجيا.',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            SizedBox(height: 16.h),
            _PersonCard(
              name: 'الأستاذ أحمد سيف',
              title: 'مؤسس منصة ICT Gate',
              description:
                  'معلم البرمجة والذكاء الاصطناعي، يعمل على تقديم المحتوى التعليمي بأسلوب حديث يعتمد على الفهم، والتطبيق العملي، وتنمية مهارات الطلاب لمواكبة التطور التكنولوجي.',
            ),

            SizedBox(height: 16.h),

            _PersonCard(
              name: 'الأستاذ سيف سالم',
              title: 'موجه أول الكمبيوتر وتكنولوجيا المعلومات والاتصالات',
              description:
                  'بمحافظة المنوفية، ويتمتع بخبرة تزيد على 30 عامًا في مجال التعليم والإشراف التربوي، ويساهم في إعداد ومراجعة المحتوى العلمي لضمان دقته وجودته وتوافقه مع المناهج الدراسية.',
            ),

            SizedBox(height: 24.h),

            Card(
              elevation: 0,
              color: AppColors.primary.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'يجمع هذا التعاون بين الخبرة التربوية الطويلة والأساليب التعليمية الحديثة لتقديم تجربة تعليمية موثوقة ومتميزة لجميع الطلاب.',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: 14.sp,
                              color: AppColors.textTertiary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({
    required this.name,
    required this.title,
    required this.description,
  });

  final String name;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          Text(description, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
