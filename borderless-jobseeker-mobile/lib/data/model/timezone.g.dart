// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeZoneModel _$TimeZoneModelFromJson(Map<String, dynamic> json) {
  return TimeZoneModel(
    json['Country_Code'] as String,
    json['Country_Name'] as String,
    json['Time_Zone'] as String,
    json['GMT_Offset'] as String,
  );
}

Map<String, dynamic> _$TimeZoneModelToJson(TimeZoneModel instance) =>
    <String, dynamic>{
      'Country_Code': instance.Country_Code,
      'Country_Name': instance.Country_Name,
      'Time_Zone': instance.Time_Zone,
      'GMT_Offset': instance.GMT_Offset,
    };
