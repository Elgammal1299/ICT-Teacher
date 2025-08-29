import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';

class ChooseTermsPage extends StatelessWidget {
  const ChooseTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 16),
              SvgPicture.asset(AppImage.splashImage, width: 200, height: 200),

              SizedBox(height: 16),

              Text(
                'اهلا بك في تطبيق ICD Teacher',
                style: theme.titleLarge!.copyWith(
                  color: AppColors.primary,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 16),
              Text('احمد سيف يرحيب بكم ', style: theme.titleLarge),
              SizedBox(height: 32),
              CustomTermsWidget(termsText: 'الترم الاول', onTap: () {}),
              CustomTermsWidget(termsText: 'الترم الثاني', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTermsWidget extends StatelessWidget {
  const CustomTermsWidget({
    super.key,
    required this.termsText,
    required this.onTap,
  });
  final String termsText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Text(termsText, style: Theme.of(context).textTheme.titleLarge),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
