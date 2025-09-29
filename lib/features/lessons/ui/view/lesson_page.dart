import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/presentation/pages/pdf_viewer_page.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/get_content_by_id_cubit/get_content_by_id_cubit.dart';

class LessonPage extends StatefulWidget {
  final LessonsModel lessonsModel;
  const LessonPage({super.key, required this.lessonsModel});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  YoutubePlayerController? _ytController;

  @override
  void dispose() {
    _ytController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          widget.lessonsModel.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: BlocBuilder<GetContentByIdCubit, GetContentByIdState>(
        builder: (context, state) {
          if (state is GetContentByIdLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetContentByIdError) {
            return Center(child: Text("خطأ: ${state.errMessage}"));
          } else if (state is GetContentByIdSuccess) {
            final content = state.contentModel;
            final videoId = YoutubePlayerController.convertUrlToId(
              content.videoUrl ?? '',
            );

            if (videoId != null && videoId.isNotEmpty) {
              _ytController ??= YoutubePlayerController.fromVideoId(
                videoId: videoId,
                autoPlay: false,
                params: const YoutubePlayerParams(showFullscreenButton: true),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _ytController == null
                        ? Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Text("رابط الفيديو غير صالح"),
                            ),
                          )
                        : YoutubePlayer(
                            controller: _ytController!,
                            aspectRatio: 16 / 9,
                          ),
                  ),
                  const SizedBox(height: 20),
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
                      Navigator.pushNamed(context, AppRoutes.quizPageRoute,arguments: state.contentModel.quiz);
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
