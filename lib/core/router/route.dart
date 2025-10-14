import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/DI/setup_get_it.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/features/accounts_students/ui/view/accounts_students_page.dart';
import 'package:icd_teacher/features/accounts_students/ui/view_model/accounts_cubit/accounts_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/login_page.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/pages/register_page.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/grades_cubit/grades_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/regions_cubit/regions_cubit.dart';
import 'package:icd_teacher/features/auth/features/login/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:icd_teacher/features/prefile/ui/view/about_the_application_page.dart';
import 'package:icd_teacher/features/prefile/ui/view/about_us_page.dart';
import 'package:icd_teacher/features/prefile/ui/view/shipping_and_return_policy_page.dart';
import 'package:icd_teacher/features/prefile/ui/view/terms_and_conditions_page.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/answers_questions_cubit/answers_submit_cubit.dart';
import 'package:icd_teacher/features/revision/ui/view/revision_item_page.dart';
import 'package:icd_teacher/features/revision/ui/view_model/get_content_by_id_cubit/get_content_by_id_cubit.dart';
import 'package:icd_teacher/features/lessons/ui/view/lesson_item_page.dart';
import 'package:icd_teacher/features/lessons/ui/view_model/get_lesson_cubit/get_lesson_cubit.dart';
import 'package:icd_teacher/features/revision/ui/view_model/get_revisions_cubit/get_revisions_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/quiz_cubit/quiz_cubit.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view_model/quizzes_monthly_cubit/quizzes_monthly_cubit.dart';
import 'package:icd_teacher/features/quizzes_weekly/ui/view_model/quizzes_weekly_cubit/quizzes_weekly_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/tram_grade_cubit/tram_grade_cubit.dart';
import 'package:icd_teacher/features/home/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:icd_teacher/features/home/presentation/pages/choose_terms_page.dart';
import 'package:icd_teacher/features/home/presentation/pages/home_page.dart';
import 'package:icd_teacher/features/lessons/ui/view/lesson_page.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_monthly_page.dart';
import 'package:icd_teacher/features/home/presentation/pages/quiz_page.dart';
import 'package:icd_teacher/features/quizzes_monthly/ui/view/quiz_questions_page.dart';
import 'package:icd_teacher/features/quizzes_weekly/ui/view/quiz_weekly_page.dart';
import 'package:icd_teacher/features/revision/ui/view/revision_page.dart';
import 'package:icd_teacher/features/nav_bar/ui/view/nav_bar.dart';
import 'package:icd_teacher/features/nav_bar/ui/view_model/nav_bar_cubit.dart';
import 'package:icd_teacher/features/onboarding/view/onboarding_page.dart';
import 'package:icd_teacher/features/splash_screen/splash_page.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboardingRouter:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutes.splasahRouter:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.lessonPageRoute:
        final args = settings.arguments as LessonsModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<GetContentByIdCubit>()..getContentById(args.id),
            child: LessonPage(lessonsModel: args),
          ),
        );
      case AppRoutes.revisionsPageRoute:
        final args = settings.arguments as LessonsModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<GetContentByIdCubit>()..getContentById(args.id),
            child: RevisionPage(lessonsModel: args),
          ),
        );
      case AppRoutes.homeRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UserDataCubit>()..userData(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<GetLessonCubit>()..getLesson(args.id, "lesson"),
              ),
            ],
            child: HomePage(termModel: args),
          ),
        );
      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginPage(),
          ),
        );
      case AppRoutes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<RegisterCubit>()),
              BlocProvider(create: (context) => getIt<GradesCubit>()),
              BlocProvider(create: (context) => getIt<RegionsCubit>()),
            ],
            child: const RegisterPage(),
          ),
        );
      case AppRoutes.chooseTermsRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UserDataCubit>()..userData(),
              ),
              BlocProvider(create: (context) => getIt<TramGradeCubit>()),
              BlocProvider(create: (context) => getIt<TermsCubit>()),
            ],
            child: const ChooseTermsPage(),
          ),
        );
      case AppRoutes.revisionItemPageRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<GetRevisionsCubit>()..getRevisions(args.id, "revision"),

            child: RevisionItemPage(termModel: args),
          ),
        );
      case AppRoutes.lessonItemPageRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<GetLessonCubit>()..getLesson(args.id, "lesson"),

            child: LessonItemPage(termModel: args),
          ),
        );
      case AppRoutes.navBarScreenRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => NavBarCubit()),
              BlocProvider.value(value: getIt<UserDataCubit>()..userData()),
              BlocProvider(
                create: (context) =>
                    getIt<GetLessonCubit>()..getLesson(args.id, "lesson"),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<GetRevisionsCubit>()
                      ..getRevisions(args.id, "revision"),
              ),
            ],
            child: NavBarScreen(termModel: args),
          ),
        );
      case AppRoutes.quizMonthlyPageRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<QuizzesMonthyCubit>()
                  ..getQuizzesMonthly(args.id, 'monthly_exam'),
            child: const QuizMonthlyPage(),
          ),
        );
      case AppRoutes.quizWeeklyPageRoute:
        final args = settings.arguments as TermModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<QuizzesWeeklyCubit>()
                  ..getQuizzesWeekly(args.id, 'weekly_assessment'),
            child: const QuizWeeklyPage(),
          ),
        );
      case AppRoutes.quizQuestionsPageRoute:
        final args = settings.arguments as LessonsModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<QuizCubit>()..getQuizById(args.id),
              ),
              BlocProvider(create: (context) => getIt<AnswersSubmitCubit>()),
            ],
            child: QuizQuestionsPage(quizModel: args),
          ),
        );
      case AppRoutes.quizPageRoute:
        final quiz = settings.arguments as QuizModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AnswersSubmitCubit>(),
            child: QuizPage(quiz: quiz),
          ),
        );
      case AppRoutes.aboutUsPageRoute:
        return MaterialPageRoute(builder: (_) => AboutUsPage());
      case AppRoutes.termsAndConditionsPageRoute:
        return MaterialPageRoute(builder: (_) => TermsAndConditionsPage());
      case AppRoutes.shippingAndReturnPolicyPageRoute:
        return MaterialPageRoute(builder: (_) => ShippingAndReturnPolicyPage());
      case AppRoutes.aboutTheApplicationPageRoute:
        return MaterialPageRoute(builder: (_) => AboutTheApplicationPage());
      case AppRoutes.accountsStudentsPageRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AccountsCubit>()..getAccounts(),
            child: AccountsStudentsPage(),
          ),
        );
      default:
        return null;
    }
  }
}
