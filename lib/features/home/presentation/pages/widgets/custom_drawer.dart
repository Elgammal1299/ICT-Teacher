import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final String year = DateTime.now().year.toString();
  String version = '';
  @override
  void initState() {
    super.initState();
    // _loadAppVersion();
  }

  // Future<void> _loadAppVersion() async {
  //   final info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     version = info.version;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).primaryColor, // Use the primary color from AppColors
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Image.asset(AppImage.logo,height: 100,color: Theme.of(context).hintColor),
                 SizedBox(height: 12),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Text(
                      'ICT Gate',
                      style: Theme.of(context).textTheme.titleLarge
                    ),
                  ),
                  
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Theme Switcher
           BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDark = state is ThemeChanged ? state.isDark : false;

                return SwitchListTile(
                  title:  Text('الوضع الليلي',style: Theme.of(context).textTheme.titleLarge),
                  secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                  value: isDark,
                  onChanged: (_) => context.read<ThemeCubit>().changeTheme(),
                );
              },
            ),

            // 🔹 Drawer Items
            _DrawerItem(
              icon: Icons.person,
              title: 'البيانات الشخصية',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  AppRoutes.profilePageRoute,
                );
              },
            ),
            _DrawerItem(
              icon: Icons.download,
              title: 'من نحن',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.aboutUsPageRoute);
              },
            ),
            _DrawerItem(
              icon: Icons.info,
              title: 'عن المنصة',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.aboutPlatformPageRoute);
              },
            ),
            _DrawerItem(
              icon: Icons.person,
              title: 'الدعم والتواصل',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.supportPageRoute);
              },
            ),
            _DrawerItem(
              icon: Icons.share,
              title: 'مشاركة التطبيق',
              onTap: () {
                Navigator.pop(context);
                 Share.share(
                  '📚 جرّب تطبيق ICT Gate التعليمي!\n\n'
                  'منصة متخصصة في تعليم تكنولوجيا المعلومات والاتصالات والكمبيوتر والبرمجة والذكاء الاصطناعي لطلاب المدارس، من خلال شرح مبسط واختبارات تفاعلية ومراجعات شاملة.\n\n'
                  'حمّل تطبيق ICT Gate الآن وابدأ التعلم! ✨',
                );
              },
            ),

            const Spacer(),

const SizedBox(height: 4),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: CustomElevatedButton(
backgroundColor: Colors.red,
      text: 'تسجيل الخروج',
      icon: Icon(Icons.logout, color: Colors.white),
      onPressed: () {
        Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
      },
    ),
  ),
const SizedBox(height: 4),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12.0),
                  //     child: Text(
                  //       'نسخة $version',
                  //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //         color: Theme.of(context).primaryColorDark,
                  //         fontSize: 20.sp,
                  //         fontFamily: 'Amiri',),
                  //     ),
                  //   ),
                  // ),
            // 🔹 Footer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  ' جميع الحقوق محفوظة © $year',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
color: Theme.of(context).cardColor,
      child: ListTile(

        contentPadding: EdgeInsets.all(0),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon,color: Colors.white,),),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        onTap: onTap,
      ),
    );
  }
}
