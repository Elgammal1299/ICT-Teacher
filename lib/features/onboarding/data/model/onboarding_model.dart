import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

final List<OnboardingModel> onboardingModelList = [
  OnboardingModel(
    title: 'Welcome to Teacher ICT',
    description:
        'A comprehensive educational platform designed to enhance teaching and learning experiences through technology.',
    icon: Icons.school,
    color: const Color(0xFF4CAF50),
  ),
  OnboardingModel(
    title: 'Create & Manage Lessons',
    description:
        'Easily create engaging lessons with multimedia content, track student progress, and organize your curriculum.',
    icon: Icons.library_books,
    color: const Color(0xFF2196F3),
  ),
  OnboardingModel(
    title: 'Interactive Assessments',
    description:
        'Design quizzes and assessments to evaluate student understanding and provide instant feedback.',
    icon: Icons.quiz,
    color: const Color(0xFFFF9800),
  ),
  OnboardingModel(
    title: 'Student Progress Tracking',
    description:
        'Monitor individual student performance, identify learning gaps, and celebrate achievements.',
    icon: Icons.analytics,
    color: const Color(0xFF9C27B0),
  ),
  OnboardingModel(
    title: 'Get Started',
    description:
        'Join thousands of educators who are transforming their classrooms with Teacher ICT.',
    icon: Icons.rocket_launch,
    color: const Color(0xFFE91E63),
  ),
];
