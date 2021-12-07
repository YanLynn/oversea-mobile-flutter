// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desired_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesiredCondition _$DesiredConditionFromJson(Map<String, dynamic> json) {
  return DesiredCondition(
    json['city_list'] as List,
    json['date_list'] as List,
    json['desired_condition'],
    json['industries'] as List,
    json['industry_list'] as List,
    json['occupation_list'] as List,
    json['occupations'] as List,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$DesiredConditionToJson(DesiredCondition instance) =>
    <String, dynamic>{
      'desired_condition': instance.desired_condition,
      'city_list': instance.city_list,
      'industry_list': instance.industry_list,
      'occupation_list': instance.occupation_list,
      'date_list': instance.date_list,
      'industries': instance.industries,
      'occupations': instance.occupations,
      'error': instance.error,
    };
