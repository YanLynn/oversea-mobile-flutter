// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrer_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarrerDetail _$CarrerDetailFromJson(Map<String, dynamic> json) {
  return CarrerDetail(
    json['carrers'],
    json['educations'] as List,
    json['experiences'] as List,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$CarrerDetailToJson(CarrerDetail instance) =>
    <String, dynamic>{
      'carrers': instance.carrers,
      'educations': instance.educations,
      'experiences': instance.experiences,
      'error': instance.error,
    };
