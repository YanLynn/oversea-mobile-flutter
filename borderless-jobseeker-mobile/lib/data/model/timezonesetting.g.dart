// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezonesetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeZoneSettingModel _$TimeZoneSettingModelFromJson(Map<String, dynamic> json) {
  return TimeZoneSettingModel(
    json['timezone'] as String,
    json['offset'] as String,
  );
}

Map<String, dynamic> _$TimeZoneSettingModelToJson(
        TimeZoneSettingModel instance) =>
    <String, dynamic>{
      'timezone': instance.timezone,
      'offset': instance.offset,
    };
