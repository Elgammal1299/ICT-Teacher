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
        return ServerFailure('انتهت مهلة الاتصال بالسيرفر، تحقق من الإنترنت.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('انتهت مهلة إرسال البيانات، حاول مرة أخرى.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('انتهت مهلة استقبال البيانات، حاول مرة أخرى.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('تم إلغاء الطلب.');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') == true) {
          return ServerFailure('لا يوجد اتصال بالإنترنت.');
        }
        return ServerFailure('حدث خطأ غير متوقع، حاول مرة أخرى!');
      default:
        return ServerFailure('حدث خطأ، يرجى المحاولة مجدداً.');
    }
  }

  /// Factory constructor to handle server response errors
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {

    if (statusCode == 401) {
      // خطأ تسجيل الدخول - اسم المستخدم أو كلمة المرور غلط
      if (response is Map<String, dynamic>) {
        if (response.containsKey('detail')) {
          return ServerFailure('اسم المستخدم أو كلمة المرور غير صحيحة.');
        }
        if (response.containsKey('error')) {
          return ServerFailure(response['error']);
        }
        if (response.containsKey('message')) {
          return ServerFailure(response['message']);
        }
      }
      return ServerFailure('اسم المستخدم أو كلمة المرور غير صحيحة.');
    } else if (statusCode == 400 ||
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
              .map((entry) => entry.value.join(", "))
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
        } else if (response.containsKey('detail')) {
          return ServerFailure(response['detail']);
        }
      }
      return ServerFailure('البيانات المدخلة غير صحيحة، تحقق منها وحاول مرة أخرى.');
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

          return ServerFailure(response['message'] ?? 'خطأ في التحقق من البيانات');
        }

        return ServerFailure(
          response['message'] ?? 'خطأ في معالجة البيانات، حاول مرة أخرى.',
        );
      }

      return ServerFailure('تنسيق الاستجابة غير صحيح');
    } else if (statusCode == 404) {
      return ServerFailure('الصفحة المطلوبة غير موجودة، حاول مرة أخرى لاحقاً!');
    } else if (statusCode == 500) {
      return ServerFailure('خطأ في السيرفر، يرجى المحاولة لاحقاً.');
    } else {
      return ServerFailure(
        'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.',
      );
    }
  }
}
