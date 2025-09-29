import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/custom_home_body.dart';

class HomePage extends StatelessWidget {
  final TermModel termModel;
  const HomePage({super.key, required this.termModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1D4ED8),
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
          SizedBox(height: 40),
          Expanded(
            child: CustomHomeBody(termModel: termModel,),
         
          ),
        ],
      ),
    );
  }
}

// class CustomHomeBodyItem extends StatelessWidget {
//   const CustomHomeBodyItem({super.key, required this.title, this.onTap});
//   final String title;
//   final Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(16),
//         height: 150,
//         decoration: BoxDecoration(
//           color: Colors.lightBlue,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 16, color: AppColors.grey),
//                 ),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: AppColors.background,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               left: 0,
//               top: -40,
//               child: Image.asset(AppImage.bookPng, width: 120, height: 120),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
