/// Api Constants
class ApiConstants {
  /// base url of the api
  static const String baseUrl = "http://10.0.2.2:8000/api/";
  static const String register = "auth/register/";
  static const String login = "auth/token/";
  static const String refreshToken = "auth/token/refresh/";
  static const String logout = "auth/logout/";
  static const String user = "accounts/me/";
  static const String grades = "grades/";
  static const String gradeId = "grades/{id}/";
  static const String regions = "regions/";
  static const String regionId = "regions/{id}/";
  static const String contents = "contents/";
  static const String contentId = "contents/{id}/";
  static const String quizzes = "quizzes/";
}