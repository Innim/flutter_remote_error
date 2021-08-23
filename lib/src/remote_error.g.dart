// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteError _$RemoteErrorFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['domain', 'code'],
      disallowNullValues: const ['domain', 'code']);
  return RemoteError(
    json['domain'] as String,
    json['code'] as int,
    localizedMessage: json['localizedMessage'] as String?,
    description: json['description'] as String?,
    data: json['data'] as Map<String, dynamic>?,
    retry: json['retry'] as bool? ?? false,
  );
}

Map<String, dynamic> _$RemoteErrorToJson(RemoteError instance) {
  final val = <String, dynamic>{
    'domain': instance.domain,
    'code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('localizedMessage', instance.localizedMessage);
  writeNotNull('description', instance.description);
  val['retry'] = instance.retry;
  writeNotNull('data', instance.data);
  return val;
}
