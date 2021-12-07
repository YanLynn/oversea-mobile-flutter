// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getupload _$GetuploadFromJson(Map<String, dynamic> json) {
  return Getupload(
    json['id'] as int,
    json['url'] as String,
    json['record_status'] as int,
  );
}

Map<String, dynamic> _$GetuploadToJson(Getupload instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'record_status': instance.record_status,
    };
