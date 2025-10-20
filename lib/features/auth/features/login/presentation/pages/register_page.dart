import 'package:flutter/material.dart';
import 'package:icd_teacher/core/widget/custom_clip_path.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_regester_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomClipPath(title: "انشاء حساب"),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: CustomRegesterFormField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icd_teacher/core/constant/app_color.dart';
// import 'package:icd_teacher/core/router/app_routes.dart';
// import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
// import 'package:icd_teacher/core/widget/custom_text_form.dart';
// import 'package:icd_teacher/features/auth/features/login/data/models/grade_model.dart';
// import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';
// import 'package:icd_teacher/features/auth/features/login/data/models/register_body.dart';
// import 'package:icd_teacher/features/auth/features/login/presentation/view_model/grades_cubit/grades_cubit.dart';
// import 'package:icd_teacher/features/auth/features/login/presentation/view_model/regions_cubit/regions_cubit.dart';
// import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
// import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_filed_password.dart';
// import 'package:icd_teacher/features/auth/features/login/presentation/widgets/custom_switch_auth_mode.dart';

// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(child: TwoStepRegisterForm()),
//       ),
//     );
//   }
// }

// class TwoStepRegisterForm extends StatefulWidget {
//   const TwoStepRegisterForm({super.key});

//   @override
//   State<TwoStepRegisterForm> createState() => _TwoStepRegisterFormState();
// }

// class _TwoStepRegisterFormState extends State<TwoStepRegisterForm> {
//   int currentStep = 0;

//   // Step 1 Controllers
//   late TextEditingController _userNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _parentPhoneController;

//   // Step 2 Controllers
//   late TextEditingController _firstNameController;
//   late TextEditingController _middleNameController;
//   late TextEditingController _lastNameController;
//   late TextEditingController _passwordController;
//   late TextEditingController _passwordController2;

//   // Form Keys
//   final GlobalKey<FormState> _step1FormKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _step2FormKey = GlobalKey<FormState>();

//   // Dropdowns
//   final ValueNotifier<GradeModel?> selectedGrade = ValueNotifier(null);
//   final ValueNotifier<RegionModel?> selectedRegion = ValueNotifier(null);

//   // Password visibility
//   final ValueNotifier<bool> isPasswordHidden = ValueNotifier(true);
//   final ValueNotifier<bool> isPasswordHidden2 = ValueNotifier(true);

//   @override
//   void initState() {
//     super.initState();
//     _userNameController = TextEditingController();
//     _emailController = TextEditingController();
//     _phoneController = TextEditingController();
//     _parentPhoneController = TextEditingController();
//     _firstNameController = TextEditingController();
//     _middleNameController = TextEditingController();
//     _lastNameController = TextEditingController();
//     _passwordController = TextEditingController();
//     _passwordController2 = TextEditingController();

//     context.read<GradesCubit>().grades();
//     context.read<RegionsCubit>().regions();
//   }

//   @override
//   void dispose() {
//     _userNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _parentPhoneController.dispose();
//     _firstNameController.dispose();
//     _middleNameController.dispose();
//     _lastNameController.dispose();
//     _passwordController.dispose();
//     _passwordController2.dispose();
//     selectedGrade.dispose();
//     selectedRegion.dispose();
//     isPasswordHidden.dispose();
//     isPasswordHidden2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header with step indicator
//         _buildHeader(context),

//         // Step content
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           child: currentStep == 0 ? _buildStep1(context) : _buildStep2(context),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: Color(0xFF1D4ED8),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'إنشاء حساب جديد',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Step indicator
//             Row(
//               children: [
//                 _buildStepIndicator(
//                   number: 1,
//                   isActive: currentStep == 0,
//                   isCompleted: currentStep > 0,
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 2,
//                     color: currentStep > 0 ? Colors.white : Colors.white30,
//                   ),
//                 ),
//                 _buildStepIndicator(
//                   number: 2,
//                   isActive: currentStep == 1,
//                   isCompleted: currentStep > 1,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               currentStep == 0
//                   ? 'الخطوة 1: بيانات الحساب'
//                   : 'الخطوة 2: بيانات شخصية ودراسية',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Colors.white70,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStepIndicator({
//     required int number,
//     required bool isActive,
//     required bool isCompleted,
//   }) {
//     return Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isActive
//             ? Colors.white
//             : isCompleted
//             ? Colors.white
//             : Colors.white30,
//       ),
//       child: Center(
//         child: isCompleted
//             ? const Icon(Icons.check, color: Color(0xFF1D4ED8), size: 24)
//             : Text(
//                 number.toString(),
//                 style: TextStyle(
//                   color: isActive ? Color(0xFF1D4ED8) : Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildStep1(BuildContext context) {
//     return Form(
//       key: _step1FormKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'بيانات حسابك',
//             style: Theme.of(
//               context,
//             ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           CustomTextForm(
//             controller: _userNameController,
//             keyboardType: TextInputType.text,
//             hintText: 'اسم المستخدم (Username)',
//             prefixIcon: const Icon(Icons.person),
//           ),
//           const SizedBox(height: 16),
//           CustomTextForm(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             hintText: 'البريد الإلكتروني',
//             prefixIcon: const Icon(Icons.email_outlined),
//           ),
//           const SizedBox(height: 16),
//           CustomTextForm(
//             controller: _phoneController,
//             keyboardType: TextInputType.phone,
//             hintText: 'رقم الهاتف الخاص بك',
//             prefixIcon: const Icon(Icons.phone),
//           ),
//           const SizedBox(height: 16),
//           CustomTextForm(
//             controller: _parentPhoneController,
//             keyboardType: TextInputType.phone,
//             hintText: 'رقم هاتف ولي الأمر',
//             prefixIcon: const Icon(Icons.phone_in_talk),
//           ),
//           const SizedBox(height: 32),
//           CustomElevatedButton(
//             text: 'التالي',
//             onPressed: () {
//               if (_step1FormKey.currentState?.validate() ?? false) {
//                 setState(() {
//                   currentStep = 1;
//                 });
//               }
//             },
//           ),
//           const SizedBox(height: 12),
//           Center(
//             child: TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, AppRoutes.loginRoute);
//               },
//               child: Text(
//                 'هل لديك حساب؟ تسجيل الدخول',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStep2(BuildContext context) {
//     return Form(
//       key: _step2FormKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'بيانات شخصية ودراسية',
//             style: Theme.of(
//               context,
//             ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           CustomTextForm(
//             controller: _firstNameController,
//             keyboardType: TextInputType.text,
//             hintText: 'الاسم الأول',
//             prefixIcon: const Icon(Icons.person),
//           ),
//           const SizedBox(height: 16),
//           CustomTextForm(
//             controller: _middleNameController,
//             keyboardType: TextInputType.text,
//             hintText: 'الاسم الثاني',
//             prefixIcon: const Icon(Icons.person),
//           ),
//           const SizedBox(height: 16),
//           CustomTextForm(
//             controller: _lastNameController,
//             keyboardType: TextInputType.text,
//             hintText: 'الاسم الأخير',
//             prefixIcon: const Icon(Icons.person),
//           ),
//           const SizedBox(height: 16),
//           CustomFiledPassword(
//             hintText: 'كلمة المرور',
//             isPasswordHidden: isPasswordHidden,
//             passwordCtrl: _passwordController,
//           ),
//           const SizedBox(height: 16),
//           CustomFiledPassword(
//             hintText: 'تأكيد كلمة المرور',
//             isPasswordHidden: isPasswordHidden2,
//             passwordCtrl: _passwordController2,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'البيانات الدراسية',
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           BlocBuilder<RegionsCubit, RegionsState>(
//             builder: (context, state) {
//               if (state is RegionsLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is RegionsSuccess) {
//                 return CustomDropdown<RegionModel>(
//                   hintText: 'اختر المحافظة',
//                   prefixIcon: const Icon(Icons.location_on),
//                   items: state.response,
//                   selectedValue: selectedRegion,
//                   getLabel: (region) => region.name,
//                   validator: (value) => value == null ? 'اختر المحافظة' : null,
//                 );
//               } else if (state is RegionsError) {
//                 return Text(
//                   state.message,
//                   style: const TextStyle(color: Colors.red),
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//           const SizedBox(height: 16),
//           BlocBuilder<GradesCubit, GradesState>(
//             builder: (context, state) {
//               if (state is GradesLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is GradesSuccess) {
//                 return CustomDropdown<GradeModel>(
//                   hintText: 'اختر المرحلة الدراسية',
//                   prefixIcon: const Icon(Icons.school),
//                   items: state.response,
//                   selectedValue: selectedGrade,
//                   getLabel: (grade) => grade.name,
//                   validator: (value) =>
//                       value == null ? 'اختر المرحلة الدراسية' : null,
//                 );
//               } else if (state is GradesError) {
//                 return Text(
//                   state.message,
//                   style: const TextStyle(color: Colors.red),
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//           const SizedBox(height: 32),
//           BlocConsumer<RegisterCubit, RegisterState>(
//             listener: (context, state) {
//               if (state is RegisterSuccess) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('تم التسجيل بنجاح 🎉')),
//                 );
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                   AppRoutes.loginRoute,
//                   (route) => false,
//                 );
//               } else if (state is RegisterError) {
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text(state.message)));
//               }
//             },
//             builder: (context, state) {
//               if (state is RegisterLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               return Column(
//                 children: [
//                   CustomElevatedButton(
//                     text: 'إنشاء الحساب',
//                     backgroundColor: AppColors.primary,
//                     textStyle: const TextStyle(
//                       color: AppColors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     onPressed: () {
//                       if (_step2FormKey.currentState?.validate() ?? false) {
//                         if (selectedGrade.value == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('اختر المرحلة الدراسية'),
//                             ),
//                           );
//                           return;
//                         }
//                         if (selectedRegion.value == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('اختر المحافظة')),
//                           );
//                           return;
//                         }

//                         context.read<RegisterCubit>().register(
//                           RegisterBody(
//                             username: _userNameController.text,
//                             email: _emailController.text,
//                             password1: _passwordController.text,
//                             password2: _passwordController2.text,
//                             firstName: _firstNameController.text,
//                             middleName: _middleNameController.text,
//                             lastName: _lastNameController.text,
//                             phone: _phoneController.text,
//                             parentPhone: _parentPhoneController.text,
//                             grade: selectedGrade.value!.id,
//                             region: selectedRegion.value!.id,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   CustomElevatedButton(
//                     text: 'السابق',
//                     backgroundColor: AppColors.grey,
//                     textStyle: const TextStyle(
//                       color: Colors.black87,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         currentStep = 0;
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

// class CustomDropdown<T> extends StatelessWidget {
//   final String hintText;
//   final Icon prefixIcon;
//   final List<T> items;
//   final ValueNotifier<T?> selectedValue;
//   final String Function(T) getLabel;
//   final String? Function(T?)? validator;

//   const CustomDropdown({
//     super.key,
//     required this.hintText,
//     required this.prefixIcon,
//     required this.items,
//     required this.selectedValue,
//     required this.getLabel,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<T?>(
//       valueListenable: selectedValue,
//       builder: (context, value, _) {
//         return DropdownButtonFormField<T>(
//           initialValue: value,
//           decoration: InputDecoration(
//             hintText: hintText,
//             prefixIcon: prefixIcon,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.secondary),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.primary, width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 12,
//             ),
//           ),
//           items: items
//               .map(
//                 (e) => DropdownMenuItem<T>(value: e, child: Text(getLabel(e))),
//               )
//               .toList(),
//           onChanged: (val) {
//             selectedValue.value = val;
//           },
//           validator: validator,
//         );
//       },
//     );
//   }
// }
