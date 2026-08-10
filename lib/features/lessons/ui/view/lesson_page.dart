import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/presentation/pages/pdf_viewer_page.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_content_section.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/lesson_introduction_card.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/revision/ui/view_model/get_content_by_id_cubit/get_content_by_id_cubit.dart';

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
      appBar: AppBar(
        title: Text(
          widget.lessonsModel.title,
        ),

        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<GetContentByIdCubit, GetContentByIdState>(
        builder: (context, state) {
          if (state is GetContentByIdLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetContentByIdError) {
            return ErrorStateWidget(message: state.errMessage);
          } else if (state is GetContentByIdSuccess) {
            final content = state.contentModel;
            final videoId = YoutubePlayerController.convertUrlToId(
              content.videoUrl ?? '',
            );

            if (videoId != null && videoId.isNotEmpty) {
              _ytController ??= YoutubePlayerController.fromVideoId(
                videoId: videoId,
                autoPlay: false,
                params: YoutubePlayerParams(showFullscreenButton: true),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: _ytController == null
                          ? Container(
                              height: 200.h,
                              color: Theme.of(context).hintColor,
                              child: Center(child: Text("رابط الفيديو غير صالح")),
                            )
                          : YoutubePlayer(
                              controller: _ytController!,
                              aspectRatio: 16 / 9,
                            ),
                    ),
                  ),
                  SizedBox(height: 20.h),
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
          return SizedBox();
        },
      ),
    );
  }
}
