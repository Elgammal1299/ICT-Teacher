import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';

class CustomHomeBody extends StatelessWidget {
  const CustomHomeBody({super.key, required this.termModel});

  final TermModel termModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _HomeFeatureCard(
          title: 'الدروس',
          color: const Color(0xff4A90E2),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.lessonItemPageRoute,
              arguments: termModel,
            );
          },
          image: AppImage.lessonItem,
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          title: 'المراجعات',
          color: const Color(0xff4CAF50),
          image: AppImage.quizWeekly,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.revisionItemPageRoute,
              arguments: termModel,
            );
          },
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          title: 'الاختبارات الشهرية',
          color: const Color(0xffFF9800),
          image: AppImage.revisionItem,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.quizMonthlyPageRoute,
              arguments: termModel,
            );
          },
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          image: AppImage.quizeImage,

          title: 'التقييمات الأسبوعية',
          color: const Color(0xff8E44AD),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.quizWeeklyPageRoute,
              arguments: termModel,
            );
          },
        ),
      ],
    );
  }
}

class _HomeFeatureCard extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onTap;
  final String image;

  const _HomeFeatureCard({
    required this.title,
    required this.color,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: onTap,

      child: SizedBox(
        height: 150.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
               
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      
            /// الصورة
            Positioned(
              left: 0,
              top: 0, // الصورة طالعة فوق الكارد 25px
              child: Container(
                decoration: BoxDecoration(),
                child: Image.asset(
                  image, // الصورة الخاصة بالعنصر
                  height: 150.h, // ارتفاع الصورة
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
