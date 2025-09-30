import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/tram_grade_cubit/tram_grade_cubit.dart';
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
          child: Column(
            children: [
              const SizedBox(height: 16),
              SvgPicture.asset(AppImage.splashImage, width: 200, height: 200),

              const SizedBox(height: 16),

              Text(
                'اهلا بك في تطبيق ICD Teacher',
                style: theme.titleLarge!.copyWith(
                  color: AppColors.primary,
                  fontSize: 28,
                ),
              ),
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
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TermsError) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is TermsSuccess) {
                      final term = state.data[0];
                      return CustomTermsWidget(
                        termsText: state.data[0].name,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.navBarScreenRoute,
                            arguments: term,
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
