import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';

class ChooseTermsPage extends StatelessWidget {
  const ChooseTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                SvgPicture.asset(AppImage.splashImage, width: 200, height: 200),

                // const SizedBox(height: 16),

                // Text(
                //   'اهلا بك في تطبيق ICD Teacher',
                //   style: theme.titleLarge!.copyWith(
                //     color: AppColors.primary,
                //     fontSize: 28,
                //   ),
                // ),
                const SizedBox(height: 16),
                Text('احمد سيف يرحب بكم ', style: theme.titleLarge),
                const SizedBox(height: 32),

                BlocListener<UserDataCubit, UserDataState>(
                  listener: (context, state) {
                    if (state is UserDataSuccess) {
                      context.read<TermsCubit>().getTram();
                    }
                  },
                  child: BlocBuilder<TermsCubit, TermsState>(
                    builder: (context, state) {
                      if (state is TermsLoading) {
                        return SizedBox(
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      } else if (state is TermsError) {
                        return _buildErrorWidget(
                          context: context,
                          errorMessage: state.errMessage,
                        );
                      } else if (state is TermsSuccess) {
                        // Filter active terms and restrict to the logged-in user's grade when available
                        final userState = context.watch<UserDataCubit>().state;
                        List<TermModel> activeTerms = state.data
                            .where((term) => term.isActive)
                            .toList();

                        if (userState is UserDataSuccess) {
                          activeTerms = activeTerms
                              .where(
                                (term) =>
                                    term.gradeName ==
                                    userState.response.gradeName,
                              )
                              .toList();
                        }

                        if (activeTerms.isEmpty) {
                          return _buildEmptyTermsWidget(context);
                        }

                        return ListView.builder(
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
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermCard({
    required BuildContext context,
    required TermModel term,
    required int index,
    required int totalTerms,
  }) {
    final colors = [
      const Color(0xFF4CAF50), // Green
      const Color(0xFF2196F3), // Blue
      const Color(0xFFFF9800), // Orange
      const Color(0xFF9C27B0), // Purple
      const Color(0xFFF44336), // Red
    ];

    final cardColor = colors[index % colors.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.navBarScreenRoute,
            arguments: term,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cardColor.withOpacity(0.8), cardColor],
            ),
            boxShadow: [
              BoxShadow(
                color: cardColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Icon Circle
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Icon(
                      _getTermIcon(index),
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        term.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'الصف: ${term.gradeName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
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

  Widget _buildEmptyTermsWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.school_rounded,
                size: 40,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'لا توجد مراحل دراسية متاحة',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'يرجى التواصل مع الإدارة\nللتحقق من توفر المراحل الدراسية',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 32),
            // CustomElevatedButton(
            //   text: 'العودة',
            //   width: 150,
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget({
    required BuildContext context,
    required String errorMessage,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.error.withOpacity(0.1),
              ),
              child: Icon(
                Icons.error_rounded,
                size: 80,
                color: AppColors.error.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'حدث خطأ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                errorMessage,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  text: 'إعادة محاولة',
                  width: 140,
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    context.read<TermsCubit>().getTram();
                  },
                ),
                const SizedBox(width: 12),
                CustomElevatedButton(
                  text: 'العودة',
                  width: 140,
                  backgroundColor: AppColors.grey,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
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
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8.0),
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
              Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
