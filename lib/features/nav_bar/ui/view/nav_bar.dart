import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/features/home/presentation/pages/home_page.dart';
import 'package:icd_teacher/features/nav_bar/ui/view_model/nav_bar_cubit.dart';
import 'package:icd_teacher/features/prefile/ui/view/profile_screen.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: [HomePage(), ProfilePage()],
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
                  blurRadius: 20,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 12,
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
        padding: const EdgeInsets.all(3),
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,

            borderRadius: BorderRadius.circular(100),
          ),
          child: SvgPicture.asset(selectedIcon),
        ),
      ),
      icon: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SvgPicture.asset(unselectedIcon),
      ),
      label: title,
    );
  }
}
