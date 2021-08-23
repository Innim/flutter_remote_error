import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_error.g.dart';

/// Объект ошибки, полученный с сервера.
@JsonSerializable(includeIfNull: false)
class RemoteError extends Equatable {
  /// Домен ошибки.
  @JsonKey(required: true, disallowNullValue: true)
  final String domain;

  /// Код ошибки.
  @JsonKey(required: true, disallowNullValue: true)
  final int code;

  /// Локализованное сообщение об ошибке.
  ///
  /// Может быть `null`.
  final String? localizedMessage;

  /// Описание ошибки.
  ///
  /// Может быть `null`.
  final String? description;

  /// Возможности повторного запроса.
  final bool retry;

  /// Дополнительные данные.
  ///
  /// Может быть `null`.
  final Map<String, dynamic>? data;

  const RemoteError(
    this.domain,
    this.code, {
    this.localizedMessage,
    this.description,
    this.data,
    this.retry = false,
  }) : super();

  /// Создает инстанцию по десериаллизованному JSON.
  factory RemoteError.fromJson(Map<String, dynamic> json) =>
      _$RemoteErrorFromJson(json);

  /// Преобразует объект в [Map] для сериализации в JSON.
  Map<String, dynamic> toJson() => _$RemoteErrorToJson(this);

  @override
  List<Object?> get props =>
      [domain, code, localizedMessage, description, data, retry];

  @override
  String toString() {
    return 'RemoteError{domain: $domain, code: $code, '
        'localizedMessage: $localizedMessage, '
        'description: $description, '
        'data: $data, retry: $retry}';
  }
}
