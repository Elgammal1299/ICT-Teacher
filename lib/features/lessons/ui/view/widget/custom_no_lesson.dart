import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/app_image.dart';

class CustomNoItem extends StatelessWidget {
  const CustomNoItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset(
                AppImage.noItem,
                height: 150,
              
            ),
            SizedBox(height: 16,),
            Text(
              title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'Amiri'),
            ),
          ],
        ),
      ),
    );
  }
}
