import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('من نحن', style: TextStyle(fontFamily: 'Amiri')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'يقف خلف ICT Gate فريق تعليمي يجمع بين الخبرة الأكاديمية والرؤية الحديثة في تعليم التكنولوجيا.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: 'Amiri',
                    fontSize: 20.sp,
                  ),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Amiri',
                              fontSize: 18.sp,
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18.sp,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Amiri',
            ),
          ),
        ],
      ),
    );
  }
}