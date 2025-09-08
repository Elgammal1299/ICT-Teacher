import 'package:dio/dio.dart';
import 'package:icd_teacher/core/service/api_constants.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/grade_id.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/grade_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/login_response.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/region_model.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_body.dart';
import 'package:icd_teacher/features/auth/features/login/data/models/register_response.dart';
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
  Future<List<GradeModel>> grades();

  /// service for gradesId
  @GET(ApiConstants.gradeId)
  Future<TramGradeModel> gradeId(@Path("id") String id);

  /// service for grades
  @GET(ApiConstants.regions)
  Future<List<RegionModel>> regions();

  /// service for gradesId
  @GET(ApiConstants.regionId)
  Future<RegionModel> regionId(@Path("id") String id);
}
