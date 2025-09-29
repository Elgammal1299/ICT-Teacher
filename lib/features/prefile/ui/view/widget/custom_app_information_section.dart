import 'package:flutter/material.dart';
import 'package:icd_teacher/features/prefile/ui/view/widget/custom_account_list_tile.dart';

class CustomAppInformationSection extends StatelessWidget {
  const CustomAppInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, AppRoutes.aboutUsScreenRoute);
          },

          child: CustomAccountListTile(title: 'من نحن'),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   AppRoutes.termsAndConditionsScreenRoute,
            // );
          },

          child: CustomAccountListTile(title: 'الشروط والاحكام'),
        ),
        SizedBox(height: 10),

        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, AppRoutes.privacyPolicyScreenRoute);
          },

          child: CustomAccountListTile(title: 'سياسة الخصوصية'),
        ),
        SizedBox(height: 10),

        InkWell(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   AppRoutes.shippingAndReturnPolicyScreenRoute,
            // );
          },

          child: CustomAccountListTile(title: 'عن التطبيق'),
        ),
      ],
    );
  }
}
