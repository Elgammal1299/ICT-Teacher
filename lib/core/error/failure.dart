import 'package:dio/dio.dart';

/// Base Failure Class
abstract class Failure {
  final String errMessage;
  final Map<String, List<String>>? validationErrors;
  const Failure(this.errMessage, {this.validationErrors});
}

/// Server Failure Class for handling Dio Errors
class ServerFailure extends Failure {
  ServerFailure(super.errMessage, {super.validationErrors});

  /// Factory constructor to generate failure from DioException
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with the server.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with the server.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with the server.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to the server was cancelled.');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') == true) {
          return ServerFailure('No Internet Connection.');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Oops! There was an error, Please try again.');
    }
  }

  /// Factory constructor to handle server response errors
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 429) {
      if (response is Map<String, dynamic>) {
        // لو الاستجابة عبارة عن validation errors
        final Map<String, List<String>> validationErrors = {};
        response.forEach((key, value) {
          if (value is List) {
            validationErrors[key] = value.map((e) => e.toString()).toList();
          }
        });

        if (validationErrors.isNotEmpty) {
          // جهز رسالة مجمعة من كل الأخطاء
          final combinedErrors = validationErrors.entries
              .map((entry) => '${entry.key}: ${entry.value.join(", ")}')
              .join("\n");
          return ServerFailure(
            combinedErrors,
            validationErrors: validationErrors,
          );
        }

        // fallback
        if (response.containsKey('error')) {
          return ServerFailure(response['error']);
        } else if (response.containsKey('message')) {
          return ServerFailure(response['message']);
        }
      }
      return ServerFailure('Bad request error: The request was invalid.');
    } else if (statusCode == 422) {
      if (response is Map<String, dynamic>) {
        final errorsRaw = response['errors'];

        if (errorsRaw != null && errorsRaw is Map<String, dynamic>) {
          final Map<String, List<String>> validationErrors = {};
          errorsRaw.forEach((key, value) {
            if (value is List) {
              validationErrors[key] = value.map((e) => e.toString()).toList();
            }
          });

          if (validationErrors.isNotEmpty) {
            final combinedErrors = validationErrors.entries
                .map((entry) => '${entry.key}: ${entry.value.join(", ")}')
                .join("\n");
            return ServerFailure(
              combinedErrors,
              validationErrors: validationErrors,
            );
          }

          return ServerFailure(response['message'] ?? 'Validation Error');
        }

        return ServerFailure(
          response['message'] ?? 'Unprocessable Content Error',
        );
      }

      return ServerFailure('Invalid error response format');
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure(
        'Oops! There was an Error, Please try again =========.',
      );
    }
  }
}
