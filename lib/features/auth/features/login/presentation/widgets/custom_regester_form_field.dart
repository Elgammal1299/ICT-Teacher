import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_filed_password.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_switch_auth_mode.dart';

class CustomRegesterFormField extends StatefulWidget {
  const CustomRegesterFormField({super.key});

  @override
  State<CustomRegesterFormField> createState() =>
      _CustomRegesterFormFieldState();
}

class _CustomRegesterFormFieldState extends State<CustomRegesterFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> isPasswordHidden = ValueNotifier(true);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _nameController,
            hintText: 'ادخل الاسم الاول',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _nameController,
            hintText: 'ادخل الاسم الثاني',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _nameController,
            hintText: 'ادخل الاسم الثالث',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'ادخل الايميل الاكتروني',
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            hintText: 'ادخل رقم هاتف الاب ',
            prefixIcon: const Icon(Icons.phone),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            hintText: 'ادخل رقم هاتف الطالب ان وجد',
            prefixIcon: const Icon(Icons.phone),
          ),
          const SizedBox(height: 16),
          CustomFiledPassword(
            hintText: 'ادخل الباسورد',

            isPasswordHidden: isPasswordHidden,
            passwordCtrl: _passwordController,
          ),
          const SizedBox(height: 32),

          // الزر أو اللودينج
          CustomElevatedButton(
            text: 'انشاء حساب',
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
              Navigator.pushNamed(context, AppRoutes.loginRoute);
            },
            title: 'تسجيل الدخول',
          ),
        ],
      ),
    );
  }
}
