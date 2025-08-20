import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_filed_password.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_switch_auth_mode.dart';

class CustomLoginFormField extends StatefulWidget {
  const CustomLoginFormField({super.key});

  @override
  State<CustomLoginFormField> createState() => _CustomLoginFormFieldState();
}

class _CustomLoginFormFieldState extends State<CustomLoginFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController userCtrl = TextEditingController();

  final ValueNotifier<bool> isPasswordHidden = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextForm(
            controller: userCtrl,
            keyboardType: TextInputType.text,
            hintText: 'ادخل اسم المستخدم',
            prefixIcon: const Icon(Icons.person_outline),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            hintText: 'ادخل البريد الالكتروني',
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: 16),
          CustomFiledPassword(
            hintText: 'ادخل الباسورد',

            isPasswordHidden: isPasswordHidden,
            passwordCtrl: passwordCtrl,
          ),
 
          const SizedBox(height: 32),
          CustomElevatedButton(
            text: 'تسجيل الدخول',
            borderColor: AppColors.primary,
            textStyle: TextStyle(color: AppColors.white, fontSize: 20),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // login logic
              }
            },
          ),
          const SizedBox(height: 8),
          CustomSwitchAuthMode(
            onToggle: () {
              Navigator.pop(context);
            },
            title: 'إنشاء حساب',
          ),
        ],
      ),
    );
  }
}
