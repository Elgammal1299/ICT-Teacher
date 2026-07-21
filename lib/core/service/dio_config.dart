/// Configuration for Dio HTTP client
class DioConfig {
  /// Connection timeout in milliseconds
  static const int connectTimeout = 30000;

  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;

  /// Send timeout in milliseconds
  static const int sendTimeout = 30000;

  /// Maximum number of retry attempts for failed requests
  static const int maxRetryAttempts = 3;

  /// Delay between retry attempts in milliseconds
  static const int retryDelay = 1000;

  /// Time in seconds before access token expiration to trigger proactive refresh
  /// For example, if set to 300 (5 minutes), the token will be refreshed
  /// 5 minutes before it actually expires
  static const int tokenRefreshThreshold = 300;

  /// Whether to enable pretty logging
  static const bool enablePrettyLogging = true;

  /// Whether to log request headers
  static const bool logRequestHeaders = false;

  /// Whether to log response headers
  static const bool logResponseHeaders = false;

  /// Whether to log request body
  static const bool logRequestBody = true;

  /// Whether to log response body
  static const bool logResponseBody = true;

  /// Whether to log errors
  static const bool logErrors = true;

  /// HTTP headers configuration
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
