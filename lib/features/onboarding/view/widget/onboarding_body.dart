import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/features/onboarding/data/model/onboarding_model.dart';

class OnboardingBody extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isShort = constraints.maxHeight < 600;
        final double outerPadding = 24.0;
        final double gapSmall = isShort ? 12.0 : 24.0;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - (outerPadding * 2),
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  CircleAvatar(
                    radius: 100.r,
                    child: ClipOval(
                      child: Image.asset(
                        data.imagePath,
                        width: 200.w,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // SizedBox(height: gapLarge),
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: data.color,
                      fontFamily: 'Amiri',
                      fontSize: 24.sp,
                    ),
                  ),

                  SizedBox(height: gapSmall),

                  Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      // color: Colors.grey[600],
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
