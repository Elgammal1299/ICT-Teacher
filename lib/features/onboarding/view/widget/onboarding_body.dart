import 'package:flutter/material.dart';
import 'package:icd_teacher/features/onboarding/data/model/onboarding_model.dart';

class OnboardingBody extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isShort = constraints.maxHeight < 600;
        final double iconSize = isShort ? 56 : 80;
        final double outerPadding = 24.0;
        final double iconPadding = isShort ? 24.0 : 32.0;
        final double gapLarge = isShort ? 24.0 : 48.0;
        final double gapSmall = isShort ? 12.0 : 24.0;

        return SingleChildScrollView(
          padding: EdgeInsets.all(outerPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - (outerPadding * 2),
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: isShort
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(iconPadding),
                    decoration: BoxDecoration(
                      color: data.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(data.icon, size: iconSize, color: data.color),
                  ),

                  SizedBox(height: gapLarge),

                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: data.color,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: gapSmall),

                  Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
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
