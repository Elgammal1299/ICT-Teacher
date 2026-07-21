import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_clip_path.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/grade_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/registration_form_data.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/grades_cubit/grades_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/regions_cubit/regions_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_filed_password.dart';

/// Second step of registration - Contact Information & Credentials
/// Collects: email, phone numbers, passwords, grade, region
class RegisterPageStep2 extends StatefulWidget {
  final RegistrationFormData formData;

  const RegisterPageStep2({
    super.key,
    required this.formData,
  });

  @override
  State<RegisterPageStep2> createState() => _RegisterPageStep2State();
}

class _RegisterPageStep2State extends State<RegisterPageStep2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _parentPhoneController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final ValueNotifier<bool> isPasswordHidden = ValueNotifier(true);
  final ValueNotifier<bool> isConfirmPasswordHidden = ValueNotifier(true);
  final ValueNotifier<GradeModel?> selectedGrade = ValueNotifier(null);
  final ValueNotifier<RegionModel?> selectedRegion = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _parentPhoneController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    // Load grades and regions
    context.read<GradesCubit>().grades();
    context.read<RegionsCubit>().regions();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _parentPhoneController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    isPasswordHidden.dispose();
    isConfirmPasswordHidden.dispose();
    selectedGrade.dispose();
    selectedRegion.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // Combine data from both steps
      final completeData = widget.formData.copyWith(
        email: _emailController.text.trim(),
        parentPhone: _parentPhoneController.text.trim(),
        phone: _phoneController.text.trim(),
        password1: _passwordController.text,
        password2: _confirmPasswordController.text,
        gradeId: selectedGrade.value?.id.toString(),
        regionId: selectedRegion.value?.id.toString(),
      );

      // Submit registration
      context.read<RegisterCubit>().register(
            RegisterBody(
              username: completeData.username!,
              firstName: completeData.firstName!,
              middleName: completeData.middleName!,
              lastName: completeData.lastName!,
              email: completeData.email!,
              parentPhone: completeData.parentPhone!,
              phone: completeData.phone ?? '',
              password1: completeData.password1!,
              password2: completeData.password2!,
              grade: completeData.gradeId!,
              region: completeData.regionId!,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomClipPath(title: "انشاء حساب - معلومات التواصل"),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Step indicator
                      _buildStepIndicator(),
                      const SizedBox(height: 24),

                      // Email field
                      CustomTextForm(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'ادخل البريد الإلكتروني',
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'يرجى إدخال بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Parent phone field
                      CustomTextForm(
                        controller: _parentPhoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'ادخل رقم هاتف ولي الأمر',
                        prefixIcon: const Icon(Icons.phone),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال رقم هاتف ولي الأمر';
                          }
                          if (value.trim().length < 10) {
                            return 'رقم الهاتف يجب أن يكون 10 أرقام على الأقل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Student phone field (optional)
                      CustomTextForm(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'ادخل رقم هاتف الطالب (اختياري)',
                        prefixIcon: const Icon(Icons.phone_android),
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      CustomFiledPassword(
                        hintText: 'ادخل كلمة المرور',
                        isPasswordHidden: isPasswordHidden,
                        passwordCtrl: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          if (value.length < 8) {
                            return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Confirm password field
                      CustomFiledPassword(
                        hintText: 'تأكيد كلمة المرور',
                        isPasswordHidden: isConfirmPasswordHidden,
                        passwordCtrl: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى تأكيد كلمة المرور';
                          }
                          if (value != _passwordController.text) {
                            return 'كلمات المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Region dropdown
                      BlocBuilder<RegionsCubit, RegionsState>(
                        builder: (context, state) {
                          if (state is RegionsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is RegionsSuccess) {
                            final regions = state.response;
                            return _buildCustomDropdown<RegionModel>(
                              hintText: 'اختر المنطقة',
                              prefixIcon: const Icon(Icons.location_on),
                              items: regions,
                              selectedValue: selectedRegion,
                              getLabel: (r) => r.name,
                              validator: (value) =>
                                  value == null ? 'يرجى اختيار المنطقة' : null,
                            );
                          } else if (state is RegionsError) {
                            return Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 16),

                      // Grade dropdown
                      BlocBuilder<GradesCubit, GradesState>(
                        builder: (context, state) {
                          if (state is GradesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GradesSuccess) {
                            final grades = state.response;
                            return _buildCustomDropdown<GradeModel>(
                              hintText: 'اختر المرحلة الدراسية',
                              prefixIcon: const Icon(Icons.school),
                              items: grades,
                              selectedValue: selectedGrade,
                              getLabel: (g) => g.name,
                              validator: (value) => value == null
                                  ? 'يرجى اختيار المرحلة الدراسية'
                                  : null,
                            );
                          } else if (state is GradesError) {
                            return Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 32),

                      // Register button with loading state
                      BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم التسجيل بنجاح 🎉'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.loginRoute,
                              (route) => false,
                            );
                          } else if (state is RegisterError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return CustomElevatedButton(
                            text: 'إنشاء حساب',
                            borderColor: AppColors.primary,
                            textStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                            ),
                            onPressed: _onRegisterPressed,
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Back button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              'رجوع',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build step indicator widget showing current progress (Step 2 of 2)
  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepDot(isActive: true, stepNumber: '1'),
          Expanded(
            child: _buildStepLine(isActive: true),
          ),
          _buildStepDot(isActive: true, stepNumber: '2'),
        ],
      ),
    );
  }

  /// Build a single step dot with number
  Widget _buildStepDot({required bool isActive, required String stepNumber}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          stepNumber,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Build connecting line between steps
  Widget _buildStepLine({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 2,
      color: isActive ? AppColors.primary : Colors.grey[300],
    );
  }

  /// Build custom dropdown widget
  Widget _buildCustomDropdown<T>({
    required String hintText,
    required Icon prefixIcon,
    required List<T> items,
    required ValueNotifier<T?> selectedValue,
    required String Function(T) getLabel,
    String? Function(T?)? validator,
  }) {
    return ValueListenableBuilder<T?>(
      valueListenable: selectedValue,
      builder: (context, currentValue, _) {
        return DropdownButtonFormField<T>(
          isExpanded: true,
          initialValue: currentValue,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  
                  value: item,
                  child: Text(getLabel(item)),
                ),
              )
              .toList(),
          onChanged: (val) {
            selectedValue.value = val;
          },
          validator: validator,
        );
      },
    );
  }
}
