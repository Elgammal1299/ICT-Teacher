// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:icd_teacher/core/constant/app_color.dart';
// import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
// import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
// import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
// import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
// import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/answers_questions_cubit/answers_submit_cubit.dart';
// import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_result_page.dart';

// class QuizPage extends StatefulWidget {
//   final QuizModel quiz;

//   const QuizPage({super.key, required this.quiz});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   int questionIndex = 0;
//   int myTotalScore = 0;
//   int answerChosen = -1;

//   /// نخزن id السؤال -> id الإجابة المختارة
//   final Map<String, String> userAnswers = {};

//   @override
//   Widget build(BuildContext context) {
//     final questions = widget.quiz.questions ?? [];

//     return BlocConsumer<AnswersSubmitCubit, AnswersSubmitState>(
//       listener: (context, state) {
//         if (state is AnswersSubmitSuccess) {
//           // final serverScore = state.contentModel.score;
//           // final maxScore = questions.length;
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) =>
//                   QuizResultPage(result: state.contentModel,),
//             ),
//           );
//         } else if (state is AnswersSubmitError) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text("خطأ: ${state.errMessage}")));
//         }
//       },
//       builder: (context, state) {
//         if (state is AnswersSubmitLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (questions.isEmpty) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: AppColors.primary, 
//        foregroundColor: Colors.white,
//               centerTitle: true, ),
//             body: CustomNoItem(
//                 title: 'لا يوجد اختبارات حتي الان ',
              
//               ),
//           );
//         }

//         final currentQuestion = questions[questionIndex];
//         final choices = currentQuestion.choices ?? [];

//         return Scaffold(

//           appBar: AppBar(
//             centerTitle: true,
//             title: Text(widget.quiz.title ?? 'Quiz'),),
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.all(16.0.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   // السؤال
//                   Text(
//                     (currentQuestion.body ?? '').replaceAll(r'$', '\n'),
//                     style: Theme.of(
//                       context,
//                     ).textTheme.headlineSmall!.copyWith(color: Colors.black,fontFamily: 'IBMPlexSansArabic',height: 1.5),
//                   ),
//                   SizedBox(height: 20.h),

//                   // الإجابات
//                   Column(
//                     children: List.generate(choices.length, (index) {
//                       final choice = choices[index];
//                       return Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8.h),
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               answerChosen = index;
//                             });
//                           },
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black12),
//                               borderRadius: BorderRadius.circular(8.0.r),
//                               color: answerChosen == index
//                                   ? Colors.green
//                                   : Colors.white,
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(16.0.w),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.circle_outlined,
//                                     size: 20.r,
//                                     color: answerChosen == index
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                   SizedBox(width: 16.0.w),
//                                   Text(
//                                     (choice.body ?? '').replaceAll(r'$', '\n'),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium!
//                                         .copyWith(
//                                           color: answerChosen == index
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),

//                   const Spacer(),

//                   // زر Next / Finish
//                   CustomElevatedButton(
//                     text: questionIndex + 1 < questions.length
//                         ? 'التالى'
//                         : 'انهاء',
//                     onPressed: () {
//                       if (answerChosen == -1) return;

//                       // حفظ إجابة المستخدم
//                       userAnswers[currentQuestion.id ?? ""] =
//                           choices[answerChosen].id ?? "";

//                       setState(() {
//                         myTotalScore += 10;
//                       });

//                       if (questionIndex + 1 < questions.length) {
//                         setState(() {
//                           questionIndex += 1;
//                           answerChosen = -1;
//                         });
//                       } else {
//                         // تجهيز body للإرسال
//                         final body = AnswersRequestModel(
//                           answers: userAnswers.values.toList(),
//                         );

//                         // إرسال الإجابات
//                         context.read<AnswersSubmitCubit>().getSubmit(
//                           widget.quiz.id ?? "",
//                           body,
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/widget/custom_elevated_button.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/answers_questions_cubit/answers_submit_cubit.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  final QuizModel quiz;

  const QuizPage({
    super.key,
    required this.quiz,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int myTotalScore = 0;
  int answerChosen = -1;

  /// نخزن id السؤال -> id الإجابة المختارة
  final Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    final questions = widget.quiz.questions ?? [];

    return BlocConsumer<AnswersSubmitCubit, AnswersSubmitState>(
      listener: (context, state) {
        if (state is AnswersSubmitSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => QuizResultPage(
                result: state.contentModel,
              ),
            ),
          );
        } else if (state is AnswersSubmitError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "خطأ: ${state.errMessage}",
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AnswersSubmitLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (questions.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            body: const CustomNoItem(
              title: 'لا يوجد اختبارات حتي الان',
            ),
          );
        }

        final currentQuestion = questions[questionIndex];
        final choices = currentQuestion.choices ?? [];

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.quiz.title ?? 'Quiz',
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =========================
                  // السؤال + الإجابات
                  // Scrollable Area
                  // =========================
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // السؤال
                          // Text(
                          //   (currentQuestion.body ?? '')
                          //       .replaceAll(r'$', '\n'),
                          //   style: Theme.of(context).textTheme.titleLarge,
                          // ),
                          Container(
                              padding: EdgeInsets.all(16.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Text(
                                (currentQuestion.body ?? '').replaceAll(
                                  r'$',
                                  '\n',
                                ),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),

                          SizedBox(height: 20.h),

                          // الإجابات
                          Column(
                              children: List.generate(
                                (currentQuestion.choices ?? []).length,
                                (index) {
                                  final choice =
                                      currentQuestion.choices![index];

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          answerChosen = index;
                                        });
                                      },
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black12,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          color: answerChosen == index
                                              ? Colors.green
                                              : Theme.of(context).cardColor,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.w),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.circle_outlined,
                                                size: 20.r,
                                                color: answerChosen == index
                                                    ? Colors.black
                                                    : Theme.of(
                                                        context,
                                                      ).primaryColor,
                                              ),

                                              SizedBox(width: 16.w),

                                              Expanded(
                                                child: Text(
                                                  (choice.body ?? '')
                                                      .replaceAll(r'$', '\n'),
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.titleMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // =========================
                  // زر Next / Finish
                  // ثابت أسفل الشاشة
                  // =========================
                  CustomElevatedButton(
                    text: questionIndex + 1 < questions.length
                        ? 'التالى'
                        : 'انهاء',
                    onPressed: () {
                      if (answerChosen == -1) {
                        return;
                      }

                      // حفظ إجابة المستخدم
                      userAnswers[currentQuestion.id ?? ""] =
                          choices[answerChosen].id ?? "";

                      myTotalScore += 10;

                      if (questionIndex + 1 < questions.length) {
                        setState(() {
                          questionIndex++;
                          answerChosen = -1;
                        });
                      } else {
                        // تجهيز body للإرسال
                        final body = AnswersRequestModel(
                          answers: userAnswers.values.toList(),
                        );

                        // إرسال الإجابات
                        context.read<AnswersSubmitCubit>().getSubmit(
                              widget.quiz.id ?? "",
                              body,
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
