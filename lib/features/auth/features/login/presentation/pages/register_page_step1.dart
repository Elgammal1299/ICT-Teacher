import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_clip_path.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/registration_form_data.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_switch_auth_mode.dart';

/// First step of registration - Personal Information
/// Collects: username, first name, middle name, last name
class RegisterPageStep1 extends StatefulWidget {
  const RegisterPageStep1({super.key});

  @override
  State<RegisterPageStep1> createState() => _RegisterPageStep1State();
}

class _RegisterPageStep1State extends State<RegisterPageStep1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // Check username before proceeding to step 2
      context.read<RegisterCubit>().checkUsername(
        _usernameController.text.trim(),
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
              const CustomClipPath(title: "انشاء حساب - المعلومات الشخصية"),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Step indicator
                      _buildStepIndicator(),
                      SizedBox(height: 24.h),

                      // Username field
                      CustomTextForm(
                        keyboardType: TextInputType.text,
                        controller: _usernameController,
                        hintText: 'ادخل اسم المستخدم',
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال اسم المستخدم';
                          }
                          if (value.trim().length < 3) {
                            return 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      // First name field
                      CustomTextForm(
                        keyboardType: TextInputType.text,
                        controller: _firstNameController,
                        hintText: 'ادخل الاسم الأول',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال الاسم الأول';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Middle name field
                      CustomTextForm(
                        keyboardType: TextInputType.text,
                        controller: _middleNameController,
                        hintText: 'ادخل الاسم الثاني',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال الاسم الثاني';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Last name field
                      CustomTextForm(
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        hintText: 'ادخل الاسم الأخير',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال الاسم الأخير';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32.h),

                      // Next button
                      BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is CheckUsernameSuccess) {
                            // Create form data with personal info
                            final formData = RegistrationFormData(
                              username: _usernameController.text.trim(),
                              firstName: _firstNameController.text.trim(),
                              middleName: _middleNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                            );

                            // Navigate to step 2 with the form data
                            Navigator.pushNamed(
                              context,
                              AppRoutes.registerStep2Route,
                              arguments: formData,
                            );
                          } else if (state is CheckUsernameError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is CheckUsernameLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return CustomElevatedButton(
                            text: 'التالي',
                            borderColor: AppColors.primary,
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            onPressed: _onNextPressed,
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Switch to login
                      CustomSwitchAuthMode(
                        onToggle: () {
                          Navigator.pushNamed(context, AppRoutes.loginRoute);
                        },
                        title: 'تسجيل الدخول',
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

  /// Build step indicator widget showing current progress (Step 1 of 2)
  Widget _buildStepIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepDot(isActive: true, stepNumber: '1'),
          Expanded(
            child: _buildStepLine(isActive: false),
          ),
          _buildStepDot(isActive: false, stepNumber: '2'),
        ],
      ),
    );
  }

  /// Build a single step dot with number
  Widget _buildStepDot({required bool isActive, required String stepNumber}) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          stepNumber,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Build connecting line between steps
  Widget _buildStepLine({required bool isActive}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      height: 2.h,
      color: isActive ? AppColors.primary : Colors.grey[300],
    );
  }
}
