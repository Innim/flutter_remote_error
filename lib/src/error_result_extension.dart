import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'remote_error.dart';
import 'remote_error_code.dart';
import 'remote_error_extension.dart';

/// Расширения [ErrorResult] для работы с кодами общих ошибок.
extension CommonErrorResultExtensionErrorCode on ErrorResult? {
  /// Определяет, является ли текущий результат ошибкой 'Не найдено'.
  bool get isNotFound =>
      toError()?.isGlobalError(GlobalErrorCode.notFound) ??
      toDioError()?.response?.statusCode == HttpStatus.notFound;

  /// Определяет, является ли текущий результат ошибкой 'Неправильные данные запроса'.
  bool get isBadRequest =>
      toError()?.isGlobalError(GlobalErrorCode.badRequest) ??
      toDioError()?.response?.statusCode == HttpStatus.badRequest;

  /// Определяет, является ли текущий результат ошибкой взаимодействия с внешними сервисами.
  bool get isExternalServiceError =>
      toError()?.isGlobalError(GlobalErrorCode.externalServiceError) ?? false;

  /// Определяет, является ли текущий результат ошибкой сокет соединения.
  bool get isSocketConnectionFailed =>
      toError()?.isNetworkError(NetworkErrorCode.socketConnectionFailed) ??
      false;

  /// Определяет, является ли текущая ошибка ошибкой авторизации.
  bool get isUnauthorized =>
      toError()?.isAuthError(AuthErrorCode.unauthorized) ??
      toDioError()?.response?.statusCode == HttpStatus.unauthorized;

  /// Определяет, соответствует ли ошибка указанному домену и коду, если указан.
  bool isError(String domain, [int? code]) =>
      toError()?.isError(domain, code) ?? false;

  /// Определяет, соответствует ли ошибка указанному коду [GlobalErrorCode] если указан.
  bool isGlobalError([int? code]) => toError()?.isGlobalError(code) ?? false;

  /// Определяет, соответствует ли ошибка указанному коду [NetworkErrorCode] если указан.
  bool isNetworkError([int? code]) => toError()?.isNetworkError(code) ?? false;

  /// Определяет, соответствует ли ошибка указанному коду [AuthErrorCode] если указан.
  bool isAuthError([int? code]) => toError()?.isAuthError(code) ?? false;

  /// Возвращает [RemoteError] текущего результата.
  RemoteError? toError() =>
      this?.error is RemoteError ? this!.error as RemoteError : null;

  /// Возвращает [DioException] текущего результата.
  DioException? toDioError() =>
      this?.error is DioException ? this!.error as DioException : null;
}

/// Расширения [ErrorResult] для работы с кодами общих ошибок.
extension InternalErrorCodeExtensionErrorResult on ErrorResult {
  static List<int> get _temporaryServerStatuses => [
        HttpStatus.badGateway,
        HttpStatus.serviceUnavailable,
        HttpStatus.gatewayTimeout,
      ];

  /// Определяет, является ли текущий результат ошибкой взаимодействия с внешними сервисами.
  bool get isEmptyDataError => isInternalError(InternalErrorCode.emptyData);

  /// Определяет, является ли текущий результат временной ошибкой сервера.
  bool get isTemporaryServerError =>
      toError()?.isInternalError(InternalErrorCode.temporaryServerError) ??
      _temporaryServerStatuses.contains(toDioError()?.response?.statusCode);

  /// Определяет, соответствует ли ошибка указанному коду [InternalErrorCode] если указан.
  bool isInternalError([int? code]) =>
      toError()?.isInternalError(code) ?? false;
}
