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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _HomeFeatureCard(
          title: 'الدروس النظرية',
          // color: const Color(0xffEFF6FF),
          color:isDark ?const Color(0xFF172554) :Colors.blue.withOpacity(0.1),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.lessonItemPageRoute,
              arguments: termModel,
            );
          },
          image: AppImage.lessonItem,
          supTitle: 'تصفح الدروس والمحتوي التعليمي',
          subColor:isDark ?const Color(0xFF064E3B): Color(0xffECFDF5),
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          title: 'العملي ومنصة Qureo',
          color:isDark?const Color(0xFF14532D): const Color(0xffBBF7D0),
          image: AppImage.quizWeekly,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.revisionItemPageRoute,
              arguments: termModel,
            );
          },
          supTitle: 'عملى ومراجعات شاملة',
          subColor: isDark?const Color(0xFF064E3B):Color(0xffECFDF5),
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          image: AppImage.quizeImage,
          color:isDark?const Color(0xFF431407): const Color(0xffFED7AA),

          title: 'التقييمات الأسبوعية',
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.quizWeeklyPageRoute,
              arguments: termModel,
            );
          },
          supTitle: 'تقييم اسبوعي لمراجعة مستواك',
          subColor:isDark?Color(0xFF064E3B): Color(0xffECFDF5),
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          color:isDark?const Color(0xFF1E1B4B): const Color(0xffEEF2FF),
          title: 'الاختبارات الشهرية',
          image: AppImage.revisionItem,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.quizMonthlyPageRoute,
              arguments: termModel,
            );
          },
          supTitle: 'اختبارات شهرية واختبارات الترم',
          subColor:isDark?const Color(0xFF064E3B): Color(0xffECFDF5),
        ),
        const SizedBox(height: 18),
        const SizedBox(height: 18),
        const SizedBox(height: 18),
        
      ],
    );
  }
}

class _HomeFeatureCard extends StatelessWidget {
  final String title;
  final String supTitle;
  final Color color;
  final Color subColor;
  final VoidCallback? onTap;
  final String image;

  const _HomeFeatureCard({
    required this.title,
    required this.color,
    required this.onTap,
    required this.image,
    required this.supTitle,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),

      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            /// المحتوى
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      supTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),

                    const SizedBox(height: 8),

                    CircleAvatar(
                      radius: 20,
                      backgroundColor: subColor,
                      child:  Icon(
                        Icons.arrow_back_rounded,
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.30,
                height: double.infinity,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
