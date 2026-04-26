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

  /// Определяет, соответствует ли ошибка указанному коду [ValidationErrorCode] если указан.
  bool isValidationError([int? code]) =>
      isError(ValidationErrorCode.domain, code);

  /// Определяет, является ли ошибка сообщением о режиме обслуживания.
  ///
  /// См. [GlobalErrorCode.maintenanceError].
  bool get isMaintenanceError => isGlobalError(GlobalErrorCode.maintenanceError);

  /// Определяет, следует ли подавить логирование данной ошибки.
  ///
  /// Возвращает `true` для ошибок, которые являются временным/ожидаемым
  /// состоянием сервера (например, режим обслуживания) - такие ошибки
  /// не должны попадать в логи и не должны инициировать показ отдельных
  /// сообщений пользователю (за исключением случаев, когда пользователю
  /// требуется показать результат запроса явно).
  bool get shouldSuppressLogging => isMaintenanceError;
}

/// Расширения [RemoteError] для работы с кодами общих ошибок.
extension InternalErrorCodeExtensionRemoteError on RemoteError {
  /// Определяет, соответствует ли ошибка указанному коду [InternalErrorCode] если указан.
  bool isInternalError([int? code]) => isError(InternalErrorCode.domain, code);
}
