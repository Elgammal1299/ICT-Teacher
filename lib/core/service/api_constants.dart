/// Api Constants
class ApiConstants {
  /// base url of the api
  static const String baseUrl = "http://localhost:8001/api/";
  static const String register = "auth/register/";
  static const String login = "auth/token/";
  static const String refreshToken = "auth/token/refresh/";
  static const String logout = "auth/logout/";
  static const String user = "me/";
  static const String grades = "grades/";
  static const String gradeId = "grades/{id}/";
  static const String regions = "regions/";
  static const String regionId = "regions/{id}/";
  static const String contents = "contents/";
  static const String contentId = "contents/{id}/";
  static const String quizzes = "quizzes/";
  static const String quizzesId = "quizzes/{id}/";
  static const String submit = "quizzes/{id}/submit/";
  static const String accounts = "accounts/";
  static const String accountsId = "accounts/{id}/";
  static const String terms = "terms/";
  static const String termsId = "terms/{id}/";
  static const String contact = "contact/";
  static const String termsByGrade = "grades/{grade_id}/terms/";
  static const String termLessons = "terms/{term_id}/lessons/";
  static const String termRevisions = "terms/{term_id}/revisions/";
  static const String termAssessments = "terms/{term_id}/assessments/";
  static const String termExams = "terms/{term_id}/exams/";
  static const String quizSubmissions = "quizzes/{quiz_id}/submissions/";
  static const String contentQuiz = "contents/{content_id}/quiz/";
}
