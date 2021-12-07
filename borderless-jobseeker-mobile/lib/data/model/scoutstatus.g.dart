// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoutstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scoutstatus _$ScoutstatusFromJson(Map<String, dynamic> json) {
  return Scoutstatus(
    json['id'] as int,
    json['scout_status'] as String,
  );
}

Map<String, dynamic> _$ScoutstatusToJson(Scoutstatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scout_status': instance.scout_status,
    };
