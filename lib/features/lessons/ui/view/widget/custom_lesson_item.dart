import 'package:flutter/material.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class CustomLessonItem extends StatelessWidget {
  const CustomLessonItem({
    super.key,
    required this.lessonsModel,
    required this.index,
  });

  final LessonsModel lessonsModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.lessonPageRoute,
          arguments: lessonsModel,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: SizedBox(
          height: 85,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              /// المستطيل الأزرق
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: const Color(0xff4A90E2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    right: 75, // مساحة الدائرة
                    // left: 10,
                  ),
                  child: Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: Text(
                      lessonsModel.title,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri',
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),

              /// الدائرة
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xff4A90E2), width: 4),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: const Color(0xff4A90E2),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
