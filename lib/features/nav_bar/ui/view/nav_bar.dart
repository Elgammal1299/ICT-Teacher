import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/presentation/pages/home_page.dart';
import 'package:icd_teacher/features/nav_bar/ui/view_model/nav_bar_cubit.dart';
import 'package:icd_teacher/features/prefile/ui/view/profile_screen.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key, required this.termModel});
  final TermModel termModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: [
              HomePage(termModel: termModel),
              ProfilePage(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: AppColors.grey.withOpacity(0.1),
                  blurRadius: 20.r,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              backgroundColor: Colors.white,
              selectedLabelStyle: Theme.of(context).textTheme.titleLarge,
              unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
              currentIndex: state,
              onTap: (value) {
                BlocProvider.of<NavBarCubit>(context).changeTab(value);
              },
              items: [
                _buildBottomNavigationBarItem(
                  'الرئيسية',
                  AppImage.homeIconSelected,
                  AppImage.homeIcon,
                ),

                _buildBottomNavigationBarItem(
                  'الحساب',
                  AppImage.personSelected,
                  AppImage.personIcon,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String title,
    String selectedIcon,
    String unselectedIcon,
  ) {
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: EdgeInsets.all(3.w),
        child: Container(
          margin: EdgeInsets.only(bottom: 5.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.primary,

            borderRadius: BorderRadius.circular(100.r),
          ),
          child: SvgPicture.asset(selectedIcon),
        ),
      ),
      icon: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: SvgPicture.asset(unselectedIcon),
      ),
      label: title,
    );
  }
}
