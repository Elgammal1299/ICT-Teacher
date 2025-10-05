import 'package:flutter/material.dart';

class CustomNoItem extends StatelessWidget {
  const CustomNoItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.info_outline_rounded, size: 100),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
