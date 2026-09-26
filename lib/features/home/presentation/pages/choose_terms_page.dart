import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ChooseTermsPage extends StatefulWidget {
  const ChooseTermsPage({super.key});

  @override
  State<ChooseTermsPage> createState() => _ChooseTermsPageState();
}

class _ChooseTermsPageState extends State<ChooseTermsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  void _fetchInitialData() {
    final termsCubit = context.read<TermsCubit>();
    if (termsCubit.state is TermsInitial) {
      termsCubit.getTram();
    }
    final userCubit = context.read<UserDataCubit>();
    if (userCubit.state is UserDataInitial) {
      userCubit.userData();
    }
  }

  Future<void> _refreshData() async {
    await Future.wait([
      context.read<UserDataCubit>().userData(),
      context.read<TermsCubit>().getTram(),
    ]);
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            const Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8.w),
            const Text('تسجيل الخروج'),
          ],
        ),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج من التطبيق؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await UserSession.logout();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginRoute,
        (route) => false,
      );
    }
  }

  Future<void> _openWhatsAppSupport() async {
    const supportUrl =
        'https://wa.me/201038340374?text=%D9%85%D8%B1%D8%AD%D8%A8%D8%A7%D9%8B%D8%8C%20%D9%84%D8%A7%20%D8%AA%D9%88%D8%AC%D8%AF%20%D9%85%D8%B1%D8%A7%D8%AD%D9%84%20%D8%AF%D8%B1%D8%A7%D8%B3%D9%8A%D8%A9%20%D9%85%D8%AA%D8%A7%D8%AD%D8%A9%20%D9%81%D9%8A%20%D8%AD%D8%B3%D8%A7%D8%A8%D9%8A%20%D8%B9%D9%84%D9%89%20ICT%20Gate';
    await launchUrlString(
      supportUrl,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          // Left ellipse (extends to top edge under notch)
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              AppImage.ellipse,
              colorFilter: isDark
                  ? ColorFilter.mode(
                      AppColors.black.withValues(alpha: 0.5),
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          ),

          // Right ellipse
          Positioned(
            top: 200.h,
            right: 0,
            child: SvgPicture.asset(
              AppImage.ellipse2,
              colorFilter: isDark
                  ? ColorFilter.mode(
                      AppColors.black.withValues(alpha: 0.5),
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Action Bar (Menu, Support, Logout) - positioned under the notch
                _buildTopBar(context),

                // Main Scrollable Area with Pull-To-Refresh
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    color: AppColors.primary,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 12.h),
                          Image.asset(
                            AppImage.logo2,
                            width: 140.w,
                            height: 140.h,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'بوابتك إلى تعلم تكنولوجيا والمعلومات وصناعة المستقبل...\nنتمنى لك رحلة تعليمية ممتعة ومثمرة.',
                            style: theme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),

                          // Terms and User Data Content
                          _buildContent(context),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          // Drawer Menu Button
          Builder(
            builder: (ctx) => IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                elevation: 2,
                shadowColor: Colors.black.withValues(alpha: 0.1),
              ),
              icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
              tooltip: 'القائمة الجانبية',
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          const Spacer(),
          
          // Support Page Button
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).cardColor,
              elevation: 2,
              shadowColor: Colors.black.withValues(alpha: 0.1),
            ),
            icon: const Icon(Icons.headset_mic_outlined, color: AppColors.primary),
            tooltip: 'الدعم والتواصل',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.supportPageRoute);
            },
          ),
          SizedBox(width: 8.w),
          // Logout Button
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).cardColor,
              elevation: 2,
              shadowColor: Colors.black.withValues(alpha: 0.1),
            ),
            icon: const Icon(Icons.logout_rounded, color: Colors.red),
            tooltip: 'تسجيل الخروج',
            onPressed: () => _showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocListener<UserDataCubit, UserDataState>(
      listener: (context, state) {
        if (state is UserDataSuccess) {
          final termsState = context.read<TermsCubit>().state;
          if (termsState is TermsInitial || termsState is TermsError) {
            context.read<TermsCubit>().getTram();
          }
        }
      },
      child: BlocBuilder<TermsCubit, TermsState>(
        builder: (context, termsState) {
          final userState = context.watch<UserDataCubit>().state;

          // 1. Loading State
          if (termsState is TermsLoading ||
              (userState is UserDataLoading && termsState is! TermsSuccess)) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            );
          }

          // 2. Error State
          if (termsState is TermsError) {
            return _buildErrorWidget(
              context: context,
              errorMessage: termsState.errMessage,
            );
          }

          if (userState is UserDataError && termsState is! TermsSuccess) {
            return _buildErrorWidget(
              context: context,
              errorMessage: userState.message,
            );
          }

          // 3. Success State
          if (termsState is TermsSuccess) {
            List<TermModel> activeTerms =
                termsState.data.where((term) => term.isActive).toList();

            String registeredGrade = '';
            String studentName = '';
            bool isTeacher = false;

            if (userState is UserDataSuccess) {
              registeredGrade = userState.response.gradeName.trim();
              studentName = userState.response.fullName.trim();
              isTeacher =
                  userState.response.role.trim().toLowerCase() == 'teacher';

              if (!isTeacher && registeredGrade.isNotEmpty) {
                activeTerms = activeTerms
                    .where(
                      (term) =>
                          term.gradeName.trim().toLowerCase() ==
                          registeredGrade.toLowerCase(),
                    )
                    .toList();
              }
            }

            if (activeTerms.isEmpty) {
              return _buildEmptyTermsWidget(
                context: context,
                registeredGrade: registeredGrade,
                isTeacher: isTeacher,
              );
            }

            return Column(
              children: [
                if (studentName.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isTeacher
                                ? Icons.person_pin
                                : Icons.school_outlined,
                            size: 18.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'مرحباً، $studentName${registeredGrade.isNotEmpty ? ' ($registeredGrade)' : ''}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activeTerms.length,
                  itemBuilder: (context, index) {
                    final term = activeTerms[index];
                    return _buildTermCard(
                      context: context,
                      term: term,
                      index: index,
                      totalTerms: activeTerms.length,
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTermCard({
    required BuildContext context,
    required TermModel term,
    required int index,
    required int totalTerms,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            // AppRoutes.navBarScreenRoute,
            AppRoutes.homeRoute,
            arguments: term,
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            shape: BoxShape.rectangle,
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.08),
                blurRadius: 8.r,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                // Icon Circle
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Icon(
                      _getTermIcon(index),
                      color: Colors.white,
                      size: 32.sp,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        term.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'الصف: ${term.gradeName}',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getTermIcon(int index) {
    final icons = [
      Icons.school,
      Icons.book,
      Icons.groups,
      Icons.star,
      Icons.lightbulb,
    ];
    return icons[index % icons.length];
  }

  Widget _buildEmptyTermsWidget({
    required BuildContext context,
    String registeredGrade = '',
    bool isTeacher = false,
  }) {
    final theme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.school_rounded,
              size: 44.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'لا توجد مراحل دراسية متاحة حالياً',
            style: theme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          if (registeredGrade.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.amber.shade400),
                ),
                child: Text(
                  'الصف الدراسي لحسابك: $registeredGrade',
                  style: theme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Text(
            isTeacher
                ? 'لا توجد فصول دراسية مفعلة حالياً في النظام.\nيرجى التواصل مع الإدارة لتفعيل المناهج أو إعادة المحاولة.'
                : 'لم يتم العثور على فصول دراسية مفعلة مخصصة لصفك الدراسي في الوقت الحالي.\nيرجى التواصل مع الإدارة للتحقق من تفعيل صفك أو إعادة المحاولة.',
            style: theme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),

          // 1. Refresh Button
          CustomElevatedButton(
            text: 'إعادة المحاولة (تحديث)',
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            backgroundColor: AppColors.primary,
            width: double.infinity,
            onPressed: _refreshData,
          ),
          SizedBox(height: 12.h),

          // 2. WhatsApp Support Button
          CustomElevatedButton(
            text: 'تواصل مع الدعم الفني (واتساب)',
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
            backgroundColor: const Color(0xFF25D366),
            width: double.infinity,
            onPressed: _openWhatsAppSupport,
          ),
          SizedBox(height: 12.h),

          // 3. Logout Button
          CustomElevatedButton(
            text: 'تسجيل الخروج من الحساب',
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            backgroundColor: Colors.red.shade700,
            width: double.infinity,
            onPressed: () => _showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget({
    required BuildContext context,
    required String errorMessage,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.error.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 40.sp,
              color: AppColors.error,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'حدث خطأ في تحميل البيانات',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: 'إعادة المحاولة',
                  icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
                  backgroundColor: AppColors.primary,
                  onPressed: _refreshData,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomElevatedButton(
                  text: 'تسجيل الخروج',
                  icon: const Icon(Icons.logout, color: Colors.white, size: 18),
                  backgroundColor: Colors.red.shade700,
                  onPressed: () => _showLogoutDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTermsWidget extends StatelessWidget {
  const CustomTermsWidget({super.key, required this.termsText, this.onTap});

  final String termsText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          padding: EdgeInsets.all(12.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Text(
                termsText,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: AppColors.primary),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
