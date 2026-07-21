import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_image.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Image.asset(AppImage.logo,height: 100,),
                 SizedBox(height: 12),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Text(
                      'ICT Gate',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri'
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Theme Switcher
           

            // 🔹 Drawer Items
            _DrawerItem(
              icon: Icons.person,
              title: 'البيانات الشخصية',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  AppRoutes.homeRoute,
                );
              },
            ),
            _DrawerItem(
              icon: Icons.download,
              title: 'التنزيلات',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.homeRoute);
              },
            ),
            _DrawerItem(
              icon: Icons.info,
              title: 'عن المنصة',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.homeRoute);
              },
            ),
            _DrawerItem(
              icon: Icons.person,
              title: 'عن المطور',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.homeRoute);
              },
            ),
            _DrawerItem(
              icon: Icons.share,
              title: 'مشاركة التطبيق',
              onTap: () {
                Navigator.pop(context);
                 Share.share(
                  'اكتشف تطبيق وَارْتَقِ - رفيقك اليومي للقرآن والأذكار! 🌙📖\n\n'
                  '🔹 استمع إلى القرآن الكريم بجودة عالية\n'
                  '🔹 تصفح الأذكار والأدعية اليومية\n'
                  '🔹 احصل على مواقيت الصلاة واتجاه القبلة\n'
                  '🔹 واجهة سهلة الاستخدام وتصميم جذاب\n\n'
                  'حمّل التطبيق الآن وارتقِ بتجربتك الروحية! 🙏✨\n\n'
                  'رابط التحميل: https://example.com/download',
    );
              },
            ),

            const Spacer(),
// const SizedBox(height: 4),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Text(
//                         'نسخة $version',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Theme.of(context).primaryColorDark,
//                           fontSize: 20.sp,
//                           fontFamily: 'Amiri',),
//                       ),
//                     ),
//                   ),
            // 🔹 Footer
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 12),
            //   child: Center(
            //     child: Text(
            //       ' جميع الحقوق محفوظة © $year',
            //       style: Theme.of(context).textTheme.bodySmall,
            //     ),
            //   ),
            // ),
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
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20.sp, fontFamily: 'Amiri',)),
      onTap: onTap,
    );
  }
}
