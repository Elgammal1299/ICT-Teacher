
import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';

class CustomTermsItem extends StatelessWidget {
  const CustomTermsItem({
    super.key,
    required this.termsText,
    required this.isActive,
    this.onTap,
  });

  final String termsText;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isActive ? Colors.grey.shade200 : Colors.grey.shade300,
            border: Border.all(
              color: isActive ? AppColors.primary : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Text(
                termsText,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isActive ? AppColors.primary : Colors.grey,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isActive ? AppColors.primary : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
