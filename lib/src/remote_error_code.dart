// Коды серверных ошибок

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:innim_remote_error/innim_remote_error.dart'
    hide CommonRemoteErrorExtensionErrorCode;

/// Общие ошибки.
class GlobalErrorCode {
  /// Домен.
  static const domain = 'Global';

  /// Общая ошибка системы.
  static const systemError = 0;

  /// Сущность не найдена.
  static const notFound = 1;

  /// Неверные данные запроса.
  static const badRequest = 2;

  /// Ошибка при взаимодействии с внешними сервисами.
  static const externalServiceError = 3;

  GlobalErrorCode._();
}

/// Ошибки сети.
class NetworkErrorCode {
  /// Домен.
  static const domain = 'Network';

  /// Превышен таймаут соединения.
  static const connectTimeout = 1;

  /// Превышен таймаут отправки.
  static const sendTimeout = 2;

  /// Превышен таймаут получения.
  static const receiveTimeout = 3;

  /// Запрос был отменен.
  static const cancel = 4;

  /// Ошибка сокет соединения.
  static const socketConnectionFailed = 5;

  /// Соединение разорвано во время handshake.
  ///
  /// Произошла какая-то ошибка в фазе handshake при установке
  /// защищенного соединения.
  static const handshakeFailed = 6;

  NetworkErrorCode._();
}

/// Расширения [RemoteError] для работы с кодами общих ошибок.
extension CommonRemoteErrorExtensionErrorCode on RemoteError {
  /// Определяет, соответствует ли ошибка указанному домену и коду, если указан.
  bool isError(String domain, [int? code]) =>
      this.domain == domain && (code == null || this.code == code);

  /// Определяет, соответствует ли ошибка указанному коду [GlobalErrorCode] если указан.
  bool isGlobalError([int? code]) => isError(GlobalErrorCode.domain, code);

  /// Определяет, соответствует ли ошибка указанному коду [NetworkErrorCode] если указан.
  bool isNetworkError([int? code]) => isError(NetworkErrorCode.domain, code);
}

/// Расширения [ErrorResult] для работы с кодами общих ошибок.
extension CommonErrorResultExtensionErrorCode on ErrorResult {
  /// Определяет, является ли текущий результат ошибкой 'Не найдено'.
  bool get isNotFound =>
      toError()?.isGlobalError(GlobalErrorCode.notFound) ??
      toDioError()?.response?.statusCode == _HttpStatus.notFound;

  /// Определяет, является ли текущий результат ошибкой 'Неправильные данные запроса'.
  bool get isBadRequest =>
      toError()?.isGlobalError(GlobalErrorCode.badRequest) ??
      toDioError()?.response?.statusCode == _HttpStatus.badRequest;

  /// Определяет, является ли текущий результат ошибкой взаимодействия с внешними сервисами.
  bool get isExternalServiceError =>
      toError()?.isGlobalError(GlobalErrorCode.externalServiceError) ?? false;

  /// Определяет, является ли текущий результат ошибкой сокет соединения.
  bool get isSocketConnectionFailed =>
      toError()?.isNetworkError(NetworkErrorCode.socketConnectionFailed) ??
      false;

  /// Определяет, соответствует ли ошибка указанному домену и коду, если указан.
  bool isError(String domain, [int? code]) =>
      toError()?.isError(domain, code) ?? false;

  /// Определяет, соответствует ли ошибка указанному коду [GlobalErrorCode] если указан.
  bool isGlobalError([int? code]) => toError()?.isGlobalError(code) ?? false;

  /// Определяет, соответствует ли ошибка указанному коду [NetworkErrorCode] если указан.
  bool isNetworkError([int? code]) => toError()?.isNetworkError(code) ?? false;

  /// Возвращает [RemoteError] текущего результата.
  RemoteError? toError() => error is RemoteError ? error as RemoteError : null;

  /// Возвращает [DioError] текущего результата.
  DioError? toDioError() => error is DioError ? error as DioError : null;
}

class _HttpStatus {
  static const badRequest = 400;
  static const notFound = 404;
}
