import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/presentation/pages/pdf_viewer_page.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_content_section.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_introduction_card.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_video_player.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/revision/ui/view_model/get_content_by_id_cubit/get_content_by_id_cubit.dart';

class RevisionPage extends StatelessWidget {
  final LessonsModel lessonsModel;
  const RevisionPage({super.key, required this.lessonsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text(
          lessonsModel.title,
        ),

      ),
      body: BlocBuilder<GetContentByIdCubit, GetContentByIdState>(
        builder: (context, state) {
          if (state is GetContentByIdLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetContentByIdError) {
            return ErrorStateWidget(message: state.errMessage);
          } else if (state is GetContentByIdSuccess) {
            final content = state.contentModel;
          

           

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   LessonVideoPlayer(
                    videoUrl: content.videoUrl,
                  ),
                  const SizedBox(height: 20),
                  LessonIntroductionCard(
                    introduction: content.intro ?? "لا يوجد وصف",
                  ),
                  SizedBox(height: 20.h),

                  // PDF button
                  LessonContentSection(
                    onPdfTap: () {
                      if (content.pdf != null && content.pdf!.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PdfViewerPage(pdfUrl: content.pdf!),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("لا يوجد ملف PDF")),
                        );
                      }
                    },
                    onQuizTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.quizPageRoute,
                        arguments: state.contentModel.quiz,
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

/*

const Text(
                    "مقدمة الدرس",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    content.intro ?? "لا يوجد وصف",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  // PDF button
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        if (content.pdf != null && content.pdf!.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PdfViewerPage(pdfUrl: content.pdf!),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("لا يوجد ملف PDF")),
                          );
                        }
                      },

                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "ملف PDF",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "اضغط للتحميل",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.download_rounded,
                              color: Colors.indigo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'الذهاب الى الاختبار',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.quizPageRoute,
                        arguments: state.contentModel.quiz,
                      );
                    },
                  ),
 */