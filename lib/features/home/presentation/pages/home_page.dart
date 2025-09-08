import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_tap_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🟢 الهيدر بس
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1D4ED8), //AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,

                  child: SvgPicture.asset(AppImage.appLogoFram39),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أهلاً وسهلاً,',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        const SizedBox(height: 7),
                        BlocBuilder<UserDataCubit, UserDataState>(
                          builder: (context, state) {
                            if (state is UserDataLoading) {
                              return Text(
                                '👋 ...',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                              );
                            } else if (state is UserDataSuccess) {
                              return Text(
                                '👋 ${state.response.username}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                              );
                            } else {
                              return Text(
                                '👋 ...',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🟢 باقي الشاشة
          Expanded(
            child: CustomTapView(),
          ),
        ],
      ),
    );
  }
}
