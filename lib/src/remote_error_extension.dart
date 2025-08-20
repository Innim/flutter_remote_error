import 'remote_error.dart';
import 'remote_error_code.dart';

/// Расширения [RemoteError] для работы с кодами общих ошибок.
extension CommonRemoteErrorExtensionErrorCode on RemoteError {
  /// Определяет, соответствует ли ошибка указанному домену и коду, если указан.
  bool isError(String domain, [int? code]) =>
      this.domain == domain && (code == null || this.code == code);

  /// Определяет, соответствует ли ошибка указанному коду [GlobalErrorCode] если указан.
  bool isGlobalError([int? code]) => isError(GlobalErrorCode.domain, code);

  /// Определяет, соответствует ли ошибка указанному коду [NetworkErrorCode] если указан.
  bool isNetworkError([int? code]) => isError(NetworkErrorCode.domain, code);

  /// Определяет, соответствует ли ошибка указанному коду [AuthErrorCode] если указан.
  bool isAuthError([int? code]) => isError(AuthErrorCode.domain, code);
}

/// Расширения [RemoteError] для работы с кодами общих ошибок.
extension InternalErrorCodeExtensionRemoteError on RemoteError {
  /// Определяет, соответствует ли ошибка указанному коду [InternalErrorCode] если указан.
  bool isInternalError([int? code]) => isError(InternalErrorCode.domain, code);
}
