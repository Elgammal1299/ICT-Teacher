import 'package:flutter/material.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/register_page_step1.dart';

/// Main registration page - redirects to step 1 of the registration flow
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simply redirect to the first step of registration
    return const RegisterPageStep1();
  }
}
