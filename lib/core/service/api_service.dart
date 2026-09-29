import 'package:dio/dio.dart';
import 'package:icd_teacher/core/service/api_constants.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_id_model.dart';
import 'package:icd_teacher/features/accounts_students/data/model/accounts_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_response.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_response.dart';
import 'package:icd_teacher/features/home/data/models/answers_questions_model.dart';
import 'package:icd_teacher/features/home/data/models/answers_request_model.dart';
import 'package:icd_teacher/features/home/data/models/content_model.dart';
import 'package:icd_teacher/features/home/data/models/quiz_model.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';
import 'package:icd_teacher/features/home/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

/// This is the API service class that handles all the API calls.
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    ParseErrorLogger? errorLogger,
    String? baseUrl,
  }) = _ApiService;

  // =================== Auth ===================

  /// service for register
  @POST(ApiConstants.register)
  Future<RegisterResponse> register(@Body() RegisterBody body);

  /// service for login
  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginBody body);

  /// service for logout
  @POST(ApiConstants.logout)
  Future<LoginResponse> logout();

  /// service for refresh
  @POST(ApiConstants.refreshToken)
  Future<LoginResponse> refresh(@Body() Map<String, dynamic> body);

  /// service for User Profile
  @GET(ApiConstants.user)
  Future<UserModel> user();

  /// service for grades
  @GET(ApiConstants.grades)
  Future<dynamic> grades();

  /// service for gradesId
  @GET(ApiConstants.gradeId)
  Future<TramGradeModel> gradeId(@Path("id") String id);

  /// service for grades
  @GET(ApiConstants.regions)
  Future<dynamic> regions();

  /// service for gradesId
  @GET(ApiConstants.regionId)
  Future<RegionModel> regionId(@Path("id") String id);

  /// service for contents/lessons by term
  @GET(ApiConstants.termLessons)
  Future<dynamic> getLessons(
    @Path("term_id") String termId,
  );

  /// service for Revisions by term
  @GET(ApiConstants.termRevisions)
  Future<dynamic> getRevisions(
    @Path("term_id") String termId,
  );

  /// service for content by id
  @GET(ApiConstants.contentId)
  Future<ContentModel> getContentById(@Path("id") String id);

  /// service for term assessments (weekly)
  @GET(ApiConstants.termAssessments)
  Future<dynamic> getAssessments(
    @Path("term_id") String termId,
  );

  /// service for term exams (monthly)
  @GET(ApiConstants.termExams)
  Future<dynamic> getExams(
    @Path("term_id") String termId,
  );

  /// service for quiz by id
  @GET(ApiConstants.quizzesId)
  Future<QuizModel> getQuizById(@Path("id") String id);

  /// service for quiz submission
  @POST(ApiConstants.quizSubmissions)
  Future<AnswersQuestionsModel> getSubmit(
    @Path("quiz_id") String quizId,
    @Body() AnswersRequestModel body,
  );
  /// service for accounts
  @GET(ApiConstants.accounts)
  Future<List<AccountsModel>> accounts();

  /// service for accounts Id
  @GET(ApiConstants.accountsId)
  Future<AccountsIdModel> accountsId(@Path("id") String id);
  /// service for terms
  @GET(ApiConstants.terms)
  Future<List<TermModel>> terms();

  /// service for terms by grade
  @GET(ApiConstants.termsByGrade)
  Future<dynamic> termsByGrade(@Path("grade_id") String gradeId);

  /// service for terms Id
  @GET(ApiConstants.termsId)
  Future<TermModel> termsId(@Path("id") String id);

  /// service for quiz by content id
  @GET(ApiConstants.contentQuiz)
  Future<QuizModel> getQuizForContent(@Path("content_id") String contentId);

  /// service for contact
  @GET(ApiConstants.contact)
  Future<dynamic> getContact();
}
