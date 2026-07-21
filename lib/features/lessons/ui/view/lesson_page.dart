import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/home/presentation/pages/pdf_viewer_page.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          widget.lessonsModel.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: BlocBuilder<GetContentByIdCubit, GetContentByIdState>(
        builder: (context, state) {
          if (state is GetContentByIdLoading) {
            return Center(child: CircularProgressIndicator());
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
                params: YoutubePlayerParams(showFullscreenButton: true),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: _ytController == null
                        ? Container(
                            height: 200.h,
                            color: Colors.grey[200],
                            child: Center(
                              child: Text("رابط الفيديو غير صالح"),
                            ),
                          )
                        : YoutubePlayer(
                            controller: _ytController!,
                            aspectRatio: 16 / 9,
                          ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "مقدمة الدرس",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    content.intro ?? "لا يوجد وصف",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 20.h),
                  // PDF button
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.r),
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
                            SnackBar(content: Text("لا يوجد ملف PDF")),
                          );
                        }
                      },

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ملخص الدرس',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.red,
                                    size: 28.sp,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "الملخص الكامل للدرس",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "اضغط للمشاهدة",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.indigo,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 10.h),
                      Text(
                        'تنبيه',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      Text(
                        'يمكنك الاختبار عدة مرات ولكن يتم اخذ الدرجة من الاختبار الاول، تأكد من مراجعة الدرس جيداً قبل البدء بالاختبار.',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                      ),
                    ],
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
