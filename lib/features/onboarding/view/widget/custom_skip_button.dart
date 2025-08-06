import 'package:flutter/material.dart';

class CustomSkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomSkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            'Skip',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ),
      ),
    );
  }
}
