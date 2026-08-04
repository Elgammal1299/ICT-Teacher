import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:icd_teacher/core/constant/shared_preferences_key.dart';
import 'package:icd_teacher/core/helper/shaerd_pref_helper.dart';
import 'package:icd_teacher/core/service/api_constants.dart';
import 'package:icd_teacher/core/service/dio_config.dart';
import 'package:icd_teacher/core/service/dio_exceptions.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Manages authentication tokens including refresh logic
class TokenManager {
  TokenManager._();

  static final TokenManager _instance = TokenManager._();
  static TokenManager get instance => _instance;

  /// Flag to prevent multiple simultaneous refresh attempts
  bool _isRefreshing = false;

  /// Queue to hold pending requests during token refresh
  final List<_PendingRequest> _pendingRequests = [];

  /// Completer for coordinating refresh attempts
  Completer<String>? _refreshCompleter;

  /// Get the current access token
  Future<String?> getAccessToken() async {
    return await SharedPrefHelper.getSecuredString(
      SharedPreferencesKeys.accessToken,
    );
  }

  /// Get the current refresh token
  Future<String?> getRefreshToken() async {
    return await SharedPrefHelper.getSecuredString(
      SharedPreferencesKeys.refreshToken,
    );
  }

  /// Save both access and refresh tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait<void>([
      SharedPrefHelper.setSecuredString(
        SharedPreferencesKeys.accessToken,
        accessToken,
      ),
      SharedPrefHelper.setSecuredString(
        SharedPreferencesKeys.refreshToken,
        refreshToken,
      ),
    ]);
  }

  /// Clear all tokens
  Future<void> clearTokens() async {
    await SharedPrefHelper.clearAllSecuredData();
  }

  /// Check if access token is expired or will expire soon
  Future<bool> isAccessTokenExpired() async {
    final token = await getAccessToken();
    if (token == null || token.isEmpty) {
      return true;
    }

    try {
      // Check if token is expired
      if (JwtDecoder.isExpired(token)) {
        return true;
      }

      // Check if token will expire soon (within threshold)
      final expirationDate = JwtDecoder.getExpirationDate(token);
      final now = DateTime.now();
      final difference = expirationDate.difference(now).inSeconds;

      // If token expires within the threshold, consider it expired
      return difference <= DioConfig.tokenRefreshThreshold;
    } catch (e) {
      log('Error checking token expiration: $e');
      return true; // Consider expired if we can't parse it
    }
  }

  /// Check if refresh token is expired
  Future<bool> isRefreshTokenExpired() async {
    final token = await getRefreshToken();
    if (token == null || token.isEmpty) {
      return true;
    }

    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      log('Error checking refresh token expiration: $e');
      return true;
    }
  }

  /// Refresh the access token using the refresh token
  /// This method handles concurrent refresh requests properly
  Future<String> refreshAccessToken(Dio dio) async {
    // If already refreshing, wait for the existing refresh to complete
    if (_isRefreshing && _refreshCompleter != null) {
      log('Token refresh already in progress, waiting...');
      return await _refreshCompleter!.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<String>();

    try {
      log('Starting token refresh...');

      final refreshToken = await getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw TokenRefreshException(
          'No refresh token available',
          statusCode: 401,
        );
      }

      // Check if refresh token is expired
      if (await isRefreshTokenExpired()) {
        throw TokenRefreshException(
          'Refresh token is expired',
          statusCode: 401,
        );
      }

      // Create a separate Dio instance for refresh to avoid interceptor conflicts
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: Duration(milliseconds: DioConfig.connectTimeout),
          receiveTimeout: Duration(milliseconds: DioConfig.receiveTimeout),
          sendTimeout: Duration(milliseconds: DioConfig.sendTimeout),
        ),
      );

      log(
        'Sending refresh request to: ${ApiConstants.baseUrl}${ApiConstants.refreshToken}',
      );

      final response = await refreshDio.post(
        ApiConstants.refreshToken,
        data: {'refresh': refreshToken},
      );

      final newAccessToken = response.data['access'] as String?;
      final newRefreshToken = response.data['refresh'] as String?;

      if (newAccessToken == null || newAccessToken.isEmpty) {
        throw TokenRefreshException(
          'Invalid response: missing access token',
          statusCode: response.statusCode,
        );
      }

      // Save the new tokens
      await saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken ?? refreshToken,
      );

      log('Token refresh successful!');

      // Resolve all pending requests
      _refreshCompleter!.complete(newAccessToken);

      // Process any pending requests
      await _processPendingRequests(dio, newAccessToken);

      return newAccessToken;
    } on DioException catch (e) {
      log('Token refresh failed with Dio error: ${e.message}');

      final statusCode = e.response?.statusCode;
      String errorMessage = 'Token refresh failed';

      if (statusCode == 401 || statusCode == 403) {
        errorMessage = 'Refresh token is invalid or expired';
      } else if (statusCode == 404) {
        errorMessage = 'Refresh endpoint not found';
      }

      final exception = TokenRefreshException(
        errorMessage,
        statusCode: statusCode,
        originalError: e,
      );

      _completeRefreshWithError(exception);
      throw exception;
    } catch (e) {
      log('Token refresh failed with unexpected error: $e');

      final exception = TokenRefreshException(
        'Unexpected error during token refresh',
        originalError: e,
      );

      _completeRefreshWithError(exception);
      throw exception;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  /// Queue a request to be retried after token refresh
  Future<Response> queueRequest(RequestOptions requestOptions, Dio dio) async {
    final completer = Completer<Response>();
    _pendingRequests.add(_PendingRequest(requestOptions, completer));

    log(
      'Request queued during token refresh. Queue size: ${_pendingRequests.length}',
    );

    return completer.future;
  }

  /// Process all pending requests after successful token refresh
  Future<void> _processPendingRequests(Dio dio, String newAccessToken) async {
    if (_pendingRequests.isEmpty) {
      return;
    }

    log('Processing ${_pendingRequests.length} pending requests...');

    final requests = List<_PendingRequest>.from(_pendingRequests);
    _pendingRequests.clear();

    for (final request in requests) {
      try {
        // Update the request with the new token
        request.requestOptions.headers['Authorization'] =
            'Bearer $newAccessToken';

        // Retry the request
        final response = await dio.fetch(request.requestOptions);
        request.completer.complete(response);
      } catch (e) {
        request.completer.completeError(e);
      }
    }

    log('Finished processing pending requests');
  }

  /// Clear the pending requests queue (e.g., on logout)
  void clearPendingRequests() {
    for (final request in _pendingRequests) {
      request.completer.completeError(
        AuthenticationException('Session ended during request'),
      );
    }
    _pendingRequests.clear();
  }

  void _completeRefreshWithError(TokenRefreshException exception) {
    final completer = _refreshCompleter;
    if (completer == null || completer.isCompleted) return;

    completer.future.catchError((_) => '');
    completer.completeError(exception);
  }
}

/// Internal class to hold pending requests during token refresh
class _PendingRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;

  _PendingRequest(this.requestOptions, this.completer);
}
