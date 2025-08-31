import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/core/widget/custom_text_form.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/grade_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_body.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/grades_cubit/grades_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/regions_cubit/regions_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_filed_password.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_switch_auth_mode.dart';

class CustomRegesterFormField extends StatefulWidget {
  const CustomRegesterFormField({super.key});

  @override
  State<CustomRegesterFormField> createState() =>
      _CustomRegesterFormFieldState();
}

class _CustomRegesterFormFieldState extends State<CustomRegesterFormField> {
  List<GradeModel> grades = [];

  List<RegionModel> regions = []; // هتملى من API
  final ValueNotifier<GradeModel?> selectedGrade = ValueNotifier(null);
  final ValueNotifier<RegionModel?> selectedRegion = ValueNotifier(null);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final ValueNotifier<bool> isPasswordHidden = ValueNotifier(true);
  final ValueNotifier<bool> isPasswordHidden2 = ValueNotifier(true);

  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fristNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _perantPhoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<GradesCubit>().grades();
    context.read<RegionsCubit>().regions();
    // وهتعمل نفس الكلام مع RegionsCubit لو عندك واحد
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _userNameController,
            hintText: 'ادخل الاسم',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _fristNameController,
            hintText: 'ادخل الاسم الاول',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _middleNameController,
            hintText: 'ادخل الاسم الثاني',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            keyboardType: TextInputType.text,
            controller: _lastNameController,
            hintText: 'ادخل الاسم الاخير',
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
            controller: _perantPhoneController,
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
          const SizedBox(height: 16),
          CustomFiledPassword(
            hintText: 'تأكيد الباسورد',
            isPasswordHidden: isPasswordHidden2,
            passwordCtrl: _passwordController2,
          ),

          const SizedBox(height: 16),

          // Dropdown للـ Region
          BlocBuilder<RegionsCubit, RegionsState>(
            builder: (context, state) {
              if (state is RegionsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RegionsSuccess) {
                final regions = state.response;

                return CustomDropdown<RegionModel>(
                  hintText: 'اختر المرحلة الدراسية',
                  prefixIcon: const Icon(Icons.school),
                  items: regions,
                  selectedValue: selectedRegion,
                  getLabel: (g) => g.name,
                  validator: (value) =>
                      value == null ? 'اختر المرحلة الدراسية' : null,
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
          BlocBuilder<GradesCubit, GradesState>(
            builder: (context, state) {
              if (state is GradesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GradesSuccess) {
                final grades = state.response;

                return CustomDropdown<GradeModel>(
                  hintText: 'اختر المرحلة الدراسية',
                  prefixIcon: const Icon(Icons.school),
                  items: grades,
                  selectedValue: selectedGrade,
                  getLabel: (g) => g.name,
                  validator: (value) =>
                      value == null ? 'اختر المرحلة الدراسية' : null,
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
          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم التسجيل بنجاح 🎉')),
                );
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              } else if (state is RegisterError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const CircularProgressIndicator();
              }

              return CustomElevatedButton(
                text: 'انشاء حساب',
                borderColor: AppColors.primary,
                textStyle: TextStyle(color: AppColors.white, fontSize: 20),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<RegisterCubit>().register(
                      RegisterBody(
                        username: _userNameController.text,
                        firstName: _fristNameController.text,
                        middleName: _middleNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,

                        parentPhone: _perantPhoneController.text,
                        phone: _phoneController.text,

                        password1: _passwordController.text,
                        password2: _passwordController2.text,
                        grade: selectedGrade.value!.id,
                        region: selectedRegion.value!.id,
                      ),
                    );
                  }
                },
              );
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

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final List<T> items;
  final ValueNotifier<T?> selectedValue;
  final String Function(T) getLabel;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.selectedValue,
    required this.getLabel,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T?>(
      valueListenable: selectedValue,
      builder: (context, value, _) {
        return DropdownButtonFormField<T>(
          initialValue: value,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<T>(value: e, child: Text(getLabel(e))),
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
