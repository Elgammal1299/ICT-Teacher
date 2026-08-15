import 'package:dio/dio.dart';

/// Custom exception for token refresh failures
class TokenRefreshException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  TokenRefreshException(
    this.message, {
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() =>
      'TokenRefreshException: $message (Status: $statusCode)';
}

/// Custom exception for authentication failures
class AuthenticationException implements Exception {
  final String message;
  final int? statusCode;

  AuthenticationException(this.message, {this.statusCode});

  @override
  String toString() => 'AuthenticationException: $message (Status: $statusCode)';
}

/// Custom exception for network errors
class NetworkException implements Exception {
  final String message;
  final DioException? originalException;

  NetworkException(this.message, {this.originalException});

  @override
  String toString() => 'NetworkException: $message';
}

/// Utility class to parse Dio exceptions into user-friendly error messages
class DioExceptionHandler {
  static String getMessage(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout. Please check your internet connection.';

    case DioExceptionType.sendTimeout:
      return 'Send timeout. Please try again.';

    case DioExceptionType.receiveTimeout:
      return 'Receive timeout. The server took too long to respond.';

    case DioExceptionType.transformTimeout:
      return 'Transform timeout. Please try again.';

    case DioExceptionType.badResponse:
      return _handleStatusCode(error.response?.statusCode);

    case DioExceptionType.cancel:
      return 'Request was cancelled.';

    case DioExceptionType.connectionError:
      return 'Connection error. Please check your internet connection.';

    case DioExceptionType.badCertificate:
      return 'Invalid SSL certificate.';

    case DioExceptionType.unknown:
      return 'An unexpected error occurred. Please try again.';
  }
}

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An error occurred (Status: $statusCode).';
    }
  }
}
