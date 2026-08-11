import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/core/router/app_routes.dart';

import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/pages/pdf_viewer_page.dart';

import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_content_section.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_introduction_card.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_video_player.dart';

import 'package:icd_teacher/features/revision/ui/view_model/get_content_by_id_cubit/get_content_by_id_cubit.dart';

class LessonPage extends StatelessWidget {
  final LessonsModel lessonsModel;

  const LessonPage({
    super.key,
    required this.lessonsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonsModel.title),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<GetContentByIdCubit, GetContentByIdState>(
        builder: (context, state) {
          if (state is GetContentByIdLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetContentByIdError) {
            return ErrorStateWidget(
              message: state.errMessage,
            );
          }

          if (state is GetContentByIdSuccess) {
            final content = state.contentModel;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  LessonVideoPlayer(
                    videoUrl: content.videoUrl,
                  ),

                  SizedBox(height: 20.h),

                
                  LessonIntroductionCard(
                    introduction:
                        content.intro ?? 'لا يوجد وصف',
                  ),

                  SizedBox(height: 20.h),

                  // =========================
                  // PDF + Quiz
                  // =========================

                  LessonContentSection(
                    onPdfTap: () {
                      if (content.pdf != null &&
                          content.pdf!.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PdfViewerPage(
                              pdfUrl: content.pdf!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'لا يوجد ملف PDF',
                            ),
                          ),
                        );
                      }
                    },
                    onQuizTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.quizPageRoute,
                        arguments: content.quiz,
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}