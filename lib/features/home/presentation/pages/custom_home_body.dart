import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/code_exercise.dart';
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
          supTitle: 'مراجعات شاملة لكل الدروس',
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
          supTitle: 'اختبارات شهرية لتقييم مستواك',
          subColor:isDark?const Color(0xFF064E3B): Color(0xffECFDF5),
        ),
        const SizedBox(height: 18),
        _HomeFeatureCard(
          color:isDark? const Color(0xFF422006): const Color(0xffFEF3C7),
          title: 'تجربة JavaScript',
          image: AppImage.code,
          onTap: () {
           Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NativeCodePlaygroundScreen(
                    exercise: CodeExercise(
                      title: 'تجربة JavaScript',
                      initialCode: '''
console.log("Hello ICT Gate");
''',
                    ),
                  ),
                ),
              );
          },
          supTitle: 'محرر اكواد JavaScript',
          subColor:isDark ?Color(0xFF064E3B): Color(0xffECFDF5),
        ),
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

      child: SizedBox(
        height: 150.h,
        child: Stack(
          clipBehavior: Clip.antiAlias,

          children: [
            Container(
              padding: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style:Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      supTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: subColor,
                      child: Icon(Icons.arrow_back_rounded, size: 22),
                    ),
                  ],
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
            // Positioned(
            //   left: -60,
            //   top: -30,
            //   child: Container(
            //     width: 220,
            //     height: 220,
            //     decoration: BoxDecoration(
            //       color: Colors.blue.withOpacity(0.1),
            //       shape: BoxShape.circle,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
