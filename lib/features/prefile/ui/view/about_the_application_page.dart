import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutTheApplicationPage extends StatelessWidget {
  const AboutTheApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('عن التطبيق'), centerTitle: true),
      body: Column(children: []),
    );
  }
}