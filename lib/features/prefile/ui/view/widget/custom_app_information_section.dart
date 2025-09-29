import 'package:flutter/material.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/prefile/ui/view/widget/custom_account_list_tile.dart';

class CustomAppInformationSection extends StatelessWidget {
  const CustomAppInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.aboutUsPageRoute);
          },

          child: CustomAccountListTile(title: 'من نحن'),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.termsAndConditionsPageRoute,
            );
          },

          child: CustomAccountListTile(title: 'الشروط والاحكام'),
        ),
        SizedBox(height: 10),

        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.shippingAndReturnPolicyPageRoute);
          },

          child: CustomAccountListTile(title: 'سياسة الخصوصية'),
        ),
        SizedBox(height: 10),

        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.aboutTheApplicationPageRoute,
            );
          },

          child: CustomAccountListTile(title: 'عن التطبيق'),
        ),
      ],
    );
  }
}
