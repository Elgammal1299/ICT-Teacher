import 'package:flutter/material.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';

class CustomHomeBody extends StatelessWidget {
  const CustomHomeBody({super.key, required this.termModel});
  final TermModel termModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _HomeFeatureCard(
            title: 'الدروس',
            color: Colors.blue.shade400,
            icon: Icons.menu_book,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.lessonItemPageRoute,
                arguments: termModel,
              );
            },
          ),
          _HomeFeatureCard(
            title: 'المراجعات',
            color: Colors.green.shade400,
            icon: Icons.assignment_turned_in,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.revisionItemPageRoute,
                arguments: termModel,
              );
            },
          ),
          _HomeFeatureCard(
            title: 'الاختبارات الشهرية',
            color: Colors.orange.shade400,
            icon: Icons.calendar_month,
            onTap: () {},
          ),
          _HomeFeatureCard(
            title: 'الاختبارات الاسبوعية',
            color: Colors.purple.shade400,
            icon: Icons.calendar_view_week,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _HomeFeatureCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final Function()? onTap;

  const _HomeFeatureCard({
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
