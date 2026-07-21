import 'package:flutter/material.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';

class CustomFiledPassword extends StatelessWidget {
  const CustomFiledPassword({
    super.key,
    required this.isPasswordHidden,
    required this.passwordCtrl,
    required this.hintText,
    this.validator,
  });

  final ValueNotifier<bool> isPasswordHidden;
  final TextEditingController passwordCtrl;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPasswordHidden,
      builder: (context, hidden, child) {
        return CustomTextForm(
          prefixIcon: IconButton(
            icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              isPasswordHidden.value = !hidden;
            },
          ),
          hintText: hintText,
          isObscureText: hidden,
          keyboardType: TextInputType.visiblePassword,
          controller: passwordCtrl,
          validator: validator,
        );
      },
    );
  }
}
