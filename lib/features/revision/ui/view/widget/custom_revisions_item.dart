import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';

class CustomRevisionsItem extends StatelessWidget {
  const CustomRevisionsItem({super.key, required this.lessonsModel, required this.index});
  final LessonsModel lessonsModel;
  final int index;


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.lessonPageRoute,
          arguments: lessonsModel,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:12, vertical: 4),
        child: Container(
          padding: const EdgeInsets.symmetric( vertical: 8,horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12),
        
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(lessonsModel.title, style: const TextStyle(  fontWeight: FontWeight.bold),),
            trailing: Container(
               padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
              child: const Icon(Icons.arrow_forward_ios_rounded)),
          ),
        ),
      ),
    );
  }
}
