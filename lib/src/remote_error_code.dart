// Коды серверных ошибок

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

  /// Невалидный конечный (end-entity) сертификат.
  static const badCertificate = 7;

  /// Прочая ошибка соединения.
  static const connectionError = 8;

  /// HTTP ошибка.
  ///
  /// Соответствует HttpException из пакета _http.
  static const httpException = 9;

  NetworkErrorCode._();
}

/// Ошибки авторизации.
class AuthErrorCode {
  /// Домен.
  static const domain = 'Auth';

  /// Неверные данные авторизации (логин/пароль).
  static const invalidLoginInfo = 1;

  /// Пользователь с указанным email уже существует.
  static const emailIsBusy = 2;

  /// Не авторизован.
  ///
  /// Неверный токен.
  static const unauthorized = 3;

  /// Токен уже был использован.
  static const tokenAlreadyUsed = 4;

  /// Токен устарел.
  ///
  /// Время жизни токена истекло.
  static const tokenExpired = 5;

  /// Переданный JWT refresh-токен не найден.
  static const refreshTokenNotFound = 6;

  /// Действие не поддерживается для данного пользователя.
  ///
  /// Например если пользователь, который вошел через внешний сервис
  /// пытается сменить email (конкретно это поведение будет разрешено
  /// в будущем).
  static const unsupportedActionForUser = 7;

  /// Неподдерживаемая версия клиента.
  static const incorrectClientVersion = 8;

  /// Неверный пароль.
  static const incorrectPassword = 9;

  /// Токен аннулирован.
  static const tokenCanceled = 10;

  AuthErrorCode._();
}

/// Ошибки валидации.
class ValidationErrorCode {
  /// Домен.
  static const domain = 'Validation';

  /// Некорректные входные данные.
  static const incorrectInputData = 1;

  /// Некорректный email.
  static const incorrectEmail = 2;

  /// Некорректный пароль.
  static const incorrectPassword = 3;

  ValidationErrorCode._();
}

/// Внутренние ошибки.
class InternalErrorCode {
  /// Домен.
  static const domain = 'Internal';

  /// Неизвестная ошибка.
  static const unknown = 0;

  /// Получен ответ со статусом успеха, но требуемых данных нет.
  static const emptyData = 1;

  /// Временная ошибка сервера.
  static const temporaryServerError = 2;

  InternalErrorCode._();
}
