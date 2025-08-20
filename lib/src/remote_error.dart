import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_error.g.dart';

/// Error object received from the server.
@JsonSerializable(includeIfNull: false)
class RemoteError extends Equatable {
  /// Error domain.
  @JsonKey(required: true, disallowNullValue: true)
  final String domain;

  /// Error code.
  @JsonKey(required: true, disallowNullValue: true)
  final int code;

  /// Localized error message.
  ///
  /// Can be `null`.
  final String? localizedMessage;

  /// Error description.
  ///
  /// Can be `null`.
  final String? description;

  /// Retry capabilities.
  @JsonKey(defaultValue: false)
  final bool retry;

  /// Additional data.
  ///
  /// Can be `null`.
  final Map<String, dynamic>? data;

  const RemoteError(
    this.domain,
    this.code, {
    this.localizedMessage,
    this.description,
    this.data,
    this.retry = false,
  }) : super();

  /// Creates an instance from the deserialized JSON.
  factory RemoteError.fromJson(Map<String, dynamic> json) =>
      _$RemoteErrorFromJson(json);

  /// Converts the object to a [Map] for JSON serialization.
  Map<String, dynamic> toJson() => _$RemoteErrorToJson(this);

  @override
  List<Object?> get props =>
      [domain, code, localizedMessage, description, data, retry];

  @override
  String toString() {
    return 'RemoteError{domain: $domain, code: $code, '
        'localizedMessage: ${jsonEncode(localizedMessage)}, '
        'description: $description, '
        'data: $data, retry: $retry}';
  }
}
