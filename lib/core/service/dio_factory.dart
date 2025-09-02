// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
// import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// /// This is the Dio factory class that handles all the Dio configurations.
// class DioFactory {
//   /// private constructor as I don't want to allow creating an instance of this class
//   DioFactory._();

//   static Dio? dio;
//   static const String baseUrl = ''; // ApiConstants.baseUrl;

//   static Future<Dio> getDio() async {
//     if (dio == null) {
//       dio = Dio(BaseOptions(baseUrl: baseUrl, followRedirects: true));
//       addDioInterceptor();
//     }
//     return dio!;
//   }

//   static Future<void> addDioHeaders() async {
//     final String? token = await SharedPrefHelper.getSecuredString(
//       SharedPreferencesKeys.accessToken,
//     );

//     dio?.options.headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${token ?? ''}',
//     };
//   }

//   static void addDioInterceptor() {
//     dio?.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final String? token = await SharedPrefHelper.getSecuredString(
//             SharedPreferencesKeys.accessToken,
//           );
//           log("Token: $token");
//           if (token != null && token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//             log("Token added to headers");
//           }
//           return handler.next(options);
//         },
//         onError: (DioException e, handler) async {
//           if (e.response?.statusCode == 401) {
//             log("Unauthorized error: Token might be expired.");

//             final refreshToken = await SharedPrefHelper.getSecuredString(
//               SharedPreferencesKeys.refreshToken,
//             );

//             if (refreshToken != null && refreshToken.isNotEmpty) {
//               try {
//                 // نعمل refresh request
//                 final refreshResponse = await dio!.post(
//                   "$baseUrl$refreshToken  ", // endpoint بتاعك
//                   data: {"refresh": refreshToken},
//                 );

//                 final newAccess = refreshResponse.data['access'];
//                 final newRefresh = refreshResponse.data['refresh'];

//                 if (newAccess != null && newRefresh != null) {
//                   // خزّن التوكن الجديد
//                   await SharedPrefHelper.setSecuredString(
//                     SharedPreferencesKeys.accessToken,
//                     newAccess,
//                   );
//                   await SharedPrefHelper.setSecuredString(
//                     SharedPreferencesKeys.refreshToken,
//                     newRefresh,
//                   );

//                   // عدّل الهيدر في الريكويست القديم
//                   e.requestOptions.headers['Authorization'] =
//                       'Bearer $newAccess';

//                   // جرّب تعيد نفس الريكويست
//                   final retryResponse = await dio!.fetch(e.requestOptions);
//                   return handler.resolve(retryResponse);
//                 }
//               } catch (refreshError) {
//                 log("Refresh token failed: $refreshError");
//                 // هنا ممكن تعمله logout
//               }
//             }
//           }

//           if (e.response?.statusCode == 403) {
//             log(
//               "Forbidden error: You don't have permission to access this resource.",
//             );
//           }
//           if (e.response?.statusCode == 500) {
//             log("Server error: Something went wrong on the server.");
//           }
//           if (e.response?.statusCode == 404) {
//             log("Not found error: The requested resource was not found.");
//           }
//           if (e.response?.statusCode == 400) {
//             log("Bad request error: The request was invalid.");
//           }
//           return handler.next(e);
//         },
//       ),
//     );

//     dio?.interceptors.add(
//       PrettyDioLogger(
//         request: true,
//         requestBody: true,
//         requestHeader: false,
//         responseBody: true,
//         responseHeader: true,
//         error: true,
//       ),
//     );
//   }

//   // static void addDioInterceptor() {
//   //   dio?.interceptors.add(
//   //     InterceptorsWrapper(
//   //       onRequest: (options, handler) async {
//   //         final String? token = await SharedPrefHelper.getSecuredString(
//   //           SharedPreferencesKeys.accessToken,
//   //         );
//   //         log("Token: $token");
//   //         if (token != null && token.isNotEmpty) {
//   //           options.headers['Authorization'] = 'Bearer $token';
//   //           log("Token added to headers");
//   //         }
//   //         return handler.next(options);
//   //       },
//   //       onError: (DioException e, handler) {
//   //         if (e.response?.statusCode == 401) {
//   //           log("Unauthorized error: Token might be expired.");
//   //         }
//   //         if (e.response?.statusCode == 403) {
//   //           log(
//   //             "Forbidden error: You don't have permission to access this resource.",
//   //           );
//   //         }
//   //         if (e.response?.statusCode == 500) {
//   //           log("Server error: Something went wrong on the server.");
//   //         }
//   //         if (e.response?.statusCode == 404) {
//   //           log("Not found error: The requested resource was not found.");
//   //         }
//   //         if (e.response?.statusCode == 400) {
//   //           log("Bad request error: The request was invalid.");
//   //         }
//   //         return handler.next(e);
//   //       },
//   //     ),
//   //   );
//   //   dio?.interceptors.add(
//   //     PrettyDioLogger(
//   //       request: true,
//   //       requestBody: true,
//   //       requestHeader: false,
//   //       responseBody: true,
//   //       responseHeader: true,
//   //       error: true,
//   //     ),
//   //   );
//   // }
// }
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/service/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// This is the Dio factory class that handles all the Dio configurations.
class DioFactory {
  DioFactory._();

  static Dio? dio;
  // static const String baseUrl = "http://10.0.2.2:8000"; // أو 127.0.0.1 لو سيرفر محلي

  static Future<Dio> getDio() async {
    if (dio == null) {
      dio = Dio(
        BaseOptions(baseUrl: ApiConstants.baseUrl, followRedirects: true),
      );
      addDioInterceptor();
    }
    return dio!;
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getSecuredString(
            SharedPreferencesKeys.accessToken,
          );
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            log("🔴 Unauthorized → Trying to refresh token...");

            final refreshToken = await SharedPrefHelper.getSecuredString(
              SharedPreferencesKeys.refreshToken,
            );

            if (refreshToken != null && refreshToken.isNotEmpty) {
              try {
                // 🔄 محاولة عمل refresh
                final refreshResponse = await dio!.post(
                  "${ApiConstants.baseUrl}${ApiConstants.refreshToken}",
                  data: {"refresh": refreshToken},
                );

                final newAccess = refreshResponse.data['access'];
                final newRefresh = refreshResponse.data['refresh'];

                if (newAccess != null && newRefresh != null) {
                  // ✅ تحديث التوكنات
                  await SharedPrefHelper.setSecuredString(
                    SharedPreferencesKeys.accessToken,
                    newAccess,
                  );
                  await SharedPrefHelper.setSecuredString(
                    SharedPreferencesKeys.refreshToken,
                    newRefresh,
                  );

                  // تعديل الهيدر للريكويست القديم
                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newAccess';

                  // إعادة المحاولة
                  final retryResponse = await dio!.fetch(e.requestOptions);
                  return handler.resolve(retryResponse);
                }
              } catch (refreshError) {
                log("⚠️ Refresh failed: $refreshError");
                await _handleLogout();
              }
            } else {
              await _handleLogout();
            }
          }

          return handler.next(e);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: false,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  /// 🔐 لو الريفريش فشل → logout
  static Future<void> _handleLogout() async {
    try {
      await dio?.post("${ApiConstants.baseUrl}${ApiConstants.logout}");
    } catch (_) {
      log("⚠️ Logout request failed, but continuing...");
    }

    // امسح البيانات من الـ storage
    await SharedPrefHelper.clearAllData();

    // رجع المستخدم لشاشة اللوجين
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.loginRoute,
      (route) => false,
    );
  }
}

/// 🌍 هتحتاج تعمل global navigatorKey عشان تقدر تنادي الـ logout من أي مكان
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
