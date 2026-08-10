import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text('ICT Gate',),
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
