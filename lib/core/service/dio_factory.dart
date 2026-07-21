import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icd_teacher/core/helper/user_session.dart';
import 'package:icd_teacher/core/router/app_routes.dart';
import 'package:icd_teacher/core/service/api_constants.dart';
import 'package:icd_teacher/core/service/dio_config.dart';
import 'package:icd_teacher/core/service/dio_exceptions.dart';
import 'package:icd_teacher/core/service/token_manager.dart';
import 'package:icd_teacher/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Factory class for creating and configuring Dio HTTP client instances.
///
/// This class provides a singleton Dio instance with pre-configured settings including:
/// - Automatic token refresh on 401 errors
/// - Request queuing during token refresh
/// - Proactive token expiration checking
/// - Comprehensive error handling
/// - Request/response logging
///
/// Usage:
/// ```dart
/// final dio = await DioFactory.getDio();
/// final response = await dio.get('/endpoint');
/// ```
class DioFactory {
  /// Private constructor to prevent instantiation
  DioFactory._();

  /// Singleton Dio instance
  static Dio? _dio;

  /// Token manager instance
  static final TokenManager _tokenManager = TokenManager.instance;

  /// Get the configured Dio instance
  ///
  /// Returns a singleton Dio instance with all interceptors configured.
  /// Creates and configures the instance on first call.
  static Future<Dio> getDio() async {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        followRedirects: true,
        connectTimeout: Duration(milliseconds: DioConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: DioConfig.receiveTimeout),
        sendTimeout: Duration(milliseconds: DioConfig.sendTimeout),
        headers: DioConfig.defaultHeaders,
      ));
      _addInterceptors();
    }
    return _dio!;
  }

  /// Reset the Dio instance (useful for testing or logout)
  static void reset() {
    _dio?.close(force: true);
    _dio = null;
    _tokenManager.clearPendingRequests();
  }

  /// Add all required interceptors to the Dio instance
  static void _addInterceptors() {
    // Add authentication and token refresh interceptor
    _dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );

    // Add pretty logger for debugging
    if (DioConfig.enablePrettyLogging) {
      _dio?.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: DioConfig.logRequestBody,
          requestHeader: DioConfig.logRequestHeaders,
          responseBody: DioConfig.logResponseBody,
          responseHeader: DioConfig.logResponseHeaders,
          error: DioConfig.logErrors,
        ),
      );
    }
  }

  /// Request interceptor to add authentication token
  static Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Check if token is expired and refresh if needed (proactive refresh)
      final isExpired = await _tokenManager.isAccessTokenExpired();
      if (isExpired) {
        final refreshToken = await _tokenManager.getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          log('Access token expired, refreshing proactively...');
          try {
            final newToken = await _tokenManager.refreshAccessToken(_dio!);
            options.headers['Authorization'] = 'Bearer $newToken';
            log('Token refreshed proactively before request');
          } catch (e) {
            log('Proactive token refresh failed: $e');
            // Continue with the request, let the error interceptor handle it
          }
        }
      } else {
        // Add current token to request
        final token = await _tokenManager.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }

      return handler.next(options);
    } catch (e) {
      log('Error in request interceptor: $e');
      return handler.next(options);
    }
  }

  /// Error interceptor to handle 401 errors and refresh tokens
  static Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized errors
    if (error.response?.statusCode == 401) {
      log('Received 401 Unauthorized error');

      try {
        // Attempt to refresh the token
        log('Attempting to refresh token due to 401 error...');
        final newAccessToken = await _tokenManager.refreshAccessToken(_dio!);

        // Update the failed request with the new token
        error.requestOptions.headers['Authorization'] =
            'Bearer $newAccessToken';

        // Retry the original request
        log('Retrying original request with new token...');
        final response = await _dio!.fetch(error.requestOptions);
        return handler.resolve(response);
      } on TokenRefreshException catch (e) {
        log('Token refresh failed: $e');
        // Handle logout if refresh fails
        await _handleLogout(showMessage: true);
        return handler.reject(error);
      } catch (e) {
        log('Unexpected error during token refresh: $e');
        await _handleLogout(showMessage: true);
        return handler.reject(error);
      }
    }

    // Handle other errors
    _logErrorDetails(error);
    return handler.next(error);
  }

  /// Handle user logout by clearing session and navigating to login
  static Future<void> _handleLogout({bool showMessage = false}) async {
    log('Handling logout due to authentication failure');

    try {
      // Clear tokens and session
      await UserSession.logout();
      _tokenManager.clearPendingRequests();

      // Get the current context
      final context = navigatorKey.currentContext;
      if (context != null) {
        log('Navigating to login screen');

        // Show session expired dialog if needed
        if (showMessage && context.mounted) {
          await _showSessionExpiredDialog(context);
        }

        // Navigate to login and remove all previous routes
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.loginRoute,
            (route) => false,
          );
        }
      } else {
        log('No context available for navigation');
      }
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  /// Show a dialog informing the user that their session has expired
  static Future<void> _showSessionExpiredDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28.sp),
              SizedBox(width: 8.w),
              Text(
                'انتهت الجلسة',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'لقد انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى للمتابعة.',
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
              ),
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Log detailed error information based on the error type
  static void _logErrorDetails(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = DioExceptionHandler.getMessage(error);

    log('HTTP Error [$statusCode]: $message');

    // Log additional details for specific error types
    switch (statusCode) {
      case 400:
        log('Bad Request - Response: ${error.response?.data}');
        break;
      case 403:
        log('Forbidden - You don\'t have permission to access this resource');
        break;
      case 404:
        log('Not Found - Endpoint: ${error.requestOptions.path}');
        break;
      case 500:
      case 502:
      case 503:
        log('Server Error - Please try again later');
        break;
      default:
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          log('Timeout Error - Check your network connection');
        }
    }
  }
}
