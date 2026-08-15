import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      'تسجيل الدخول وإنشاء الحساب.',
      'استعادة كلمة المرور.',
      'حل المشكلات التقنية داخل التطبيق.',
      'الاستفسار عن الاشتراكات والخدمات.',
      'الإبلاغ عن أي خطأ في المحتوى.',
    ];
    Future<void> openLink(String url) async {
      final uri = Uri.parse(url);

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الدعم والتواصل',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(
            //   child: CircleAvatar(
            //     radius: 45.r,
            //     backgroundColor:
            //         Theme.of(context).primaryColor.withOpacity(.1),
            //     child: Icon(
            //       Icons.support_agent_rounded,
            //       size: 50.r,
            //       color: Theme.of(context).primaryColor,
            //     ),
            //   ),
            // ),

            // SizedBox(height: 24.h),

            // Center(
            //   child: Text(
            //     'الدعم والتواصل',
            //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            //           fontWeight: FontWeight.bold,
            //         ),
            //   ),
            // ),

            // SizedBox(height: 20.h),
            _SectionCard(
              icon: Icons.info_outline_rounded,
              title: 'كيف يمكننا مساعدتك؟',
              child: Text(
                'نسعد دائمًا بخدمتكم والإجابة عن جميع استفساراتكم المتعلقة بمنصة ICT Gate.\n'
                'إذا واجهت أي مشكلة تقنية، أو كان لديك استفسار حول المحتوى التعليمي، أو واجهت صعوبة في استخدام التطبيق، فلا تتردد في التواصل معنا، وسنعمل على مساعدتك في أسرع وقت ممكن.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'Cairo',
            fontSize: 18.sp
                ),
              ),
            ),

            SizedBox(height: 18.h),

            _SectionCard(
              icon: Icons.check_circle_outline_rounded,
              title: 'يمكننا مساعدتك في',
              child: Column(
                children: services
                    .map(
                      (item) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
                              size: 20.r,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      fontFamily: 'IBMPlexSansArabic',
                                      fontSize: 18.sp,
                                      
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              'وسائل التواصل',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'IBMPlexSansArabic',
                fontSize: 18.sp,
              ),
            ),

            SizedBox(height: 12.h),

            _ContactTile(
              icon: Icons.email_outlined,
              title: 'البريد الإلكتروني',
              value: 'salm64187@gmail.com',
              onTap: () {
                openLink('mailto:salm64187@gmail.com');
              },
            ),

            _ContactTile(
              icon: Icons.phone_android_rounded,
              title: 'رقم الهاتف / واتساب',
              value: '01038340374',
              onTap: () {
                openLink('https://wa.me/201038340374');
              },
            ),

            _ContactTile(
              icon: Icons.facebook_rounded,
              title: 'Facebook',
              value: 'ICT Gate',
              onTap: () {
                openLink('https://www.facebook.com/ICTGate');
              },
            ),

            _ContactTile(
              icon: Icons.music_note_rounded,
              title: 'TikTok',
              value: '@ictgate',
              onTap: () {
                openLink('https://www.tiktok.com/@ictgate');
              },
            ),

            _ContactTile(
              icon: Icons.ondemand_video_rounded,
              title: 'YouTube',
              value: 'ICT Gate',
              onTap: () {
                openLink('https://www.youtube.com/@ictgate-academy');
              },
            ),

            _ContactTile(
              icon: Icons.camera_alt_outlined,
              title: 'Instagram',
              value: '@ictgate',
              onTap: () {
                openLink('https://www.instagram.com/ictgate/');
              },
            ),

            _ContactTile(
              icon: Icons.telegram_rounded,
              title: 'Telegram',
              value: '@ICTGatee',
              onTap: () {
                openLink('https://t.me/ICTGatee');
              },
            ),

            SizedBox(height: 24.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Icon(Icons.favorite_rounded, color: Colors.red, size: 34.r),
                  SizedBox(height: 10.h),
                  Text(
                    'نسعى دائمًا لتقديم أفضل تجربة تعليمية، ونرحب بجميع ملاحظاتكم واقتراحاتكم لتطوير منصة ICT Gate.',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(fontFamily: 'IBMPlexSansArabic'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              SizedBox(width: 10.w),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IBMPlexSansArabic',
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color:Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title,style: Theme.of(context).textTheme.bodyLarge,),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: 'Amiri',
            fontSize: 18.sp,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          
          child: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.primary)),
        onTap: onTap,
      ),
    );
  }
}
