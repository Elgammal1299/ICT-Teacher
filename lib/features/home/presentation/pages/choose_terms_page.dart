import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child:isDark ? SvgPicture.asset(AppImage.ellipse,color: AppColors.black.withOpacity(0.5),):SvgPicture.asset(AppImage.ellipse),
            ),
        
            /// الصورة اليمين
            Positioned(
              top: 200.h,
              right: 0,
              child:isDark ? SvgPicture.asset(AppImage.ellipse2,color: AppColors.black.withOpacity(0.5),):SvgPicture.asset(AppImage.ellipse2),
              
            ),
            Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
        
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 130.h, width: double.infinity),
                  Image.asset(AppImage.logo2, width: 200.w, height: 200.h),
                  SizedBox(height: 16.h),
                  Text(
                    'بوابتك إلى تعلم تكنولوجيا والمعلومات وصناعة المستقبل...\nنتمني لك رحلة تعليمية ممتعة ومثمرة.',
                    style: theme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
              
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
                            child: Center(
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
                          final userState = context
                              .watch<UserDataCubit>()
                              .state;
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
                            physics: NeverScrollableScrollPhysics(),
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
              
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            color:Theme.of(context).cardColor,
       
          boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 6.r,
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
                  decoration: BoxDecoration(
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
                        style:Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'الصف: ${term.gradeName}',
                                               style:Theme.of(context).textTheme.titleMedium,

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
                    size: 20.sp,
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

  Widget _buildEmptyTermsWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(40.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.school_rounded,
                size: 40.sp,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'لا توجد مراحل دراسية متاحة',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'يرجى التواصل مع الإدارة\nللتحقق من توفر المراحل الدراسية',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 32.h),
            // CustomElevatedButton(
            //   text: 'العودة',
            //   width: 150.w,
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
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.error.withOpacity(0.1),
              ),
              child: Icon(
                Icons.error_rounded,
                size: 30.sp,
                color: AppColors.error.withOpacity(0.7),
              ),
            ),
            Text(
              'حدث خطأ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                errorMessage,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  text: 'إعادة محاولة',
                  width: 140.w,
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    context.read<TermsCubit>().getTram();
                  },
                ),
                SizedBox(width: 12.w),
                CustomElevatedButton(
                  text: 'العودة',
                  width: 140.w,
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
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
