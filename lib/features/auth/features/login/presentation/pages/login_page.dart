import 'package:flutter/material.dart';
import 'package:icd_teacher/core/widget/custom_clip_path.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/custom_login_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomClipPath(title: "تسجيل الدخول"),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: CustomLoginFormField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
