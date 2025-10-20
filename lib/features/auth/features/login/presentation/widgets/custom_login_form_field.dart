import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_body.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_filed_password.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_switch_auth_mode.dart';

class CustomLoginFormField extends StatefulWidget {
  const CustomLoginFormField({super.key});

  @override
  State<CustomLoginFormField> createState() => _CustomLoginFormFieldState();
}

class _CustomLoginFormFieldState extends State<CustomLoginFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController passwordCtrl;
  late TextEditingController userCtrl;

  final ValueNotifier<bool> isPasswordHidden = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    passwordCtrl = TextEditingController();
    userCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    passwordCtrl.dispose();
    userCtrl.dispose();
    isPasswordHidden.dispose();
  }

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
          CustomFiledPassword(
            hintText: 'ادخل الباسورد',
            isPasswordHidden: isPasswordHidden,
            passwordCtrl: passwordCtrl,
          ),

          const SizedBox(height: 32),

          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تسجيل الدخول ✅")),
                );
                // Navigator.pushReplacementNamed(
                //   context,
                //   AppRoutes.chooseTermsRoute,
                // );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.chooseTermsRoute,
                  (route) => false,
                );
              } else if (state is LoginError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const CircularProgressIndicator();
              }

              return CustomElevatedButton(
                text: 'تسجيل الدخول',
                borderColor: AppColors.primary,
                textStyle: TextStyle(color: AppColors.white, fontSize: 20),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<LoginCubit>().login(
                      LoginBody(
                        username: userCtrl.text,
                        password: passwordCtrl.text,
                      ),
                    );
                  }
                },
              );
            },
          ),

          CustomSwitchAuthMode(
            onToggle: () {
              Navigator.pushNamed(context, AppRoutes.registerRoute);
            },
            title: 'إنشاء حساب',
          ),
        ],
      ),
    );
  }
}
