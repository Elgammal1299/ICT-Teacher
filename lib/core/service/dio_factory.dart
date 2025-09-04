import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/service/api_constants.dart';
import 'package:icd_teacher/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// This is the Dio factory class that handles all the Dio configurations.
class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;
  static const String baseUrl = ApiConstants.baseUrl;
  static bool _isRefreshing = false; // Prevent multiple refresh attempts

  static Future<Dio> getDio() async {
    if (dio == null) {
      dio = Dio(BaseOptions(baseUrl: baseUrl, followRedirects: true));
      addDioInterceptor();
    }
    return dio!;
  }

  static Future<void> addDioHeaders() async {
    final String? token = await SharedPrefHelper.getSecuredString(
      SharedPreferencesKeys.accessToken,
    );

    dio?.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await SharedPrefHelper.getSecuredString(
            SharedPreferencesKeys.accessToken,
          );
          log("Token: $token");
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            log("Token added to headers");
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            log("Unauthorized error: Token might be expired.");

            // Prevent multiple refresh attempts
            if (_isRefreshing) {
              return handler.next(e);
            }

            final refreshToken = await SharedPrefHelper.getSecuredString(
              SharedPreferencesKeys.refreshToken,
            );

            if (refreshToken != null && refreshToken.isNotEmpty) {
              try {
                _isRefreshing = true;
                log("Attempting to refresh token...");
                log("Refresh token: $refreshToken");
                log("Refresh endpoint: $baseUrl${ApiConstants.refreshToken}");

                // Create a new Dio instance for refresh to avoid interceptor conflicts
                final refreshDio = Dio(BaseOptions(baseUrl: baseUrl));

                // Add logging to the refresh Dio instance
                refreshDio.interceptors.add(
                  PrettyDioLogger(
                    request: true,
                    requestBody: true,
                    requestHeader: true,
                    responseBody: true,
                    responseHeader: false,
                    error: true,
                  ),
                );

                final refreshResponse = await refreshDio.post(
                  ApiConstants.refreshToken,
                  data: {"refresh": refreshToken},
                );

                final newAccess = refreshResponse.data['access'];
                final newRefresh = refreshResponse.data['refresh'];

                if (newAccess != null && newRefresh != null) {
                  log("Token refresh successful!");

                  // Store new tokens
                  await SharedPrefHelper.setSecuredString(
                    SharedPreferencesKeys.accessToken,
                    newAccess,
                  );
                  await SharedPrefHelper.setSecuredString(
                    SharedPreferencesKeys.refreshToken,
                    newRefresh,
                  );

                  // Update the original request with new token
                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newAccess';

                  // Retry the original request
                  final retryResponse = await dio!.fetch(e.requestOptions);
                  return handler.resolve(retryResponse);
                } else {
                  log("Refresh response missing tokens");
                  await _handleLogout();
                }
              } catch (refreshError) {
                log("Refresh token failed: $refreshError");

                // Check if the refresh error is due to expired refresh token
                if (refreshError is DioException) {
                  if (refreshError.response?.statusCode == 401 ||
                      refreshError.response?.statusCode == 404) {
                    log("Refresh token is expired or invalid. Logging out...");
                  } else {
                    log(
                      "Refresh failed with status: ${refreshError.response?.statusCode}",
                    );
                  }
                }

                await _handleLogout();
              } finally {
                _isRefreshing = false;
              }
            } else {
              log("No refresh token available");
              await _handleLogout();
            }
          }

          // Handle other error codes
          _logErrorDetails(e);
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

  /// Handle logout by clearing tokens and navigating to login screen
  static Future<void> _handleLogout() async {
    log("Handling logout due to token refresh failure");

    try {
      // Clear all user session data
      await UserSession.logout();

      // Navigate to login screen using global navigator key
      final context = navigatorKey.currentContext;
      if (context != null) {
        log("Navigating to login screen");
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.loginRoute,
          (route) => false, // Remove all previous routes
        );
      } else {
        log("No context available for navigation");
      }
    } catch (e) {
      log("Error during logout: $e");
    }
  }

  /// Log error details based on status code
  static void _logErrorDetails(DioException e) {
    switch (e.response?.statusCode) {
      case 403:
        log(
          "Forbidden error: You don't have permission to access this resource.",
        );
        break;
      case 500:
        log("Server error: Something went wrong on the server.");
        break;
      case 404:
        log("Not found error: The requested resource was not found.");
        break;
      case 400:
        log("Bad request error: The request was invalid.");
        break;
      default:
        log("Error ${e.response?.statusCode}: ${e.message}");
    }
  }
}
