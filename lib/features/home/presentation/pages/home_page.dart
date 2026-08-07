import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/custom_home_body.dart';
import 'package:icd_teacher/features/home/presentation/pages/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.termModel});
  final TermModel termModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary, 
       foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        // shadowColor: Colors.black.withOpacity(0.5),
        
        title: Text(' ICT Gate', style: TextStyle(fontFamily: 'Amiri')),
        
      ),
      body: Column(
        children: [
          BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataSuccess) {
                return state.response.role == 'Teacher'
                    ? Padding(
                        padding: EdgeInsets.all(16.w),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.accountsStudentsPageRoute,
                            );
                          },
                          child: Container(
                            height: 170.h,
                            decoration: BoxDecoration(
                              color: Colors.indigo,

                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.2),
                                  blurRadius: 8.r,
                                  offset: Offset(0, 4.h),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_view_week,
                                    size: 40.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    'الطلاب المسجلين ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          Expanded(child: CustomHomeBody(termModel: termModel)),
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
